open Util

let frame_size = 960
let second_per_frame = 0.02
let sample_rate = 48000
let channels = 2
let application = Opus.Voip
let num_burst_frames = 10
let five_silent_frames = List.init 5 (fun _ -> "\xf8\xff\xfe")

type connection_param = {
  vgw_conn : Ws.conn;
  ip : string;
  port : int;
  ssrc : int;
  modes : string list;
}

type vgw_cast_msg = [ `Speaking of int (* ssrc *) * bool (* speaking *) ]

type init_arg = {
  ip : string;
  port : int;
  ssrc : int;
  vgw : vgw_cast_msg Gen_server.caster;
}

type call_msg = [ `DiscoverIP ]
type call_reply = [ `DiscoverIP of string (* ip *) * int (* port *) ]

type cast_msg =
  [ `SecretKey of int list | `Frame of string | `Timeout of string ]

type state = {
  socket : Eio.Net.datagram_socket;
  dst : Eio.Net.Sockaddr.datagram;
  ssrc : int;
  secret_key : Sodium.secret Sodium.Secret_box.key option;
  frames : string list (* reversed order *);
  speaking : bool; [@default false]
  vgw : vgw_cast_msg Gen_server.caster;
  seq_num : int;
  timestamp : int;
  opus_encoder : Opus.Encoder.t;
}
[@@deriving make]

let udp_send { socket; dst; _ } = Eio.Net.send ~dst socket
let udp_recv { socket; _ } = Eio.Net.recv socket

let discover_ip ssrc send recv =
  (* IP Discovery: send a request *)
  let buf = Cstruct.create 74 in
  Cstruct.BE.set_uint16 buf 0 0x01;
  Cstruct.BE.set_uint16 buf 2 70;
  Cstruct.BE.set_uint16 buf 4 ssrc;
  send [ buf ];

  (* IP Discovery: receive a response and extract the address and port *)
  let buf = Cstruct.create 74 in
  let _, r = recv buf in
  if r <> 74 then (
    Logs.err (fun m -> m "Received %d bytes instead of 74 bytes" r);
    failwith "couldn't discover the IP address and port");
  let ip =
    Cstruct.to_bytes ~off:8 ~len:64 buf
    |> Bytes.fold_left (fun acc ch -> if ch = '\x00' then acc else ch :: acc) []
    |> List.rev |> List.to_seq |> String.of_seq
  in
  let port = Cstruct.BE.get_uint16 buf 72 in
  (ip, port)

let send_speaking state v = state.vgw#cast (`Speaking (state.ssrc, v))

let send_frame state frame =
  let opus =
    match frame with
    | `PCM_S16LE pcm -> Opus.Encoder.encode state.opus_encoder (`S16LE pcm)
    | `Opus opus -> Bytes.of_string opus
  in

  (* Build RTP header *)
  let header = Cstruct.create 12 in
  Cstruct.set_uint8 header 0 0x80;
  Cstruct.set_uint8 header 1 0x78;
  Cstruct.BE.set_uint16 header 2 state.seq_num (* Sequence *);
  Cstruct.BE.set_uint32 header 4 (Int32.of_int state.timestamp) (* Timestamp *);
  Cstruct.BE.set_uint32 header 8 (Int32.of_int state.ssrc);

  (* Encrypt the voice data *)
  let nonce =
    let buf = Cstruct.create 24 in
    Cstruct.blit header 0 buf 0 12;
    buf |> Cstruct.to_bytes |> Sodium.Secret_box.nonce_of_bytes
  in
  let ctxt =
    Sodium.Secret_box.Bytes.secret_box (Option.get state.secret_key) opus nonce
    |> Cstruct.of_bytes
  in

  (* Send the data *)
  udp_send state [ header; ctxt ];

  (* Increment sequence number and timestamp *)
  {
    state with
    seq_num = state.seq_num + 1;
    timestamp = state.timestamp + frame_size;
  }

let start_sending_frames clock ~sw state caster =
  let start_time = Eio.Time.now clock in

  match state.frames |> List.rev |> List.take_at_most num_burst_frames with
  | [], _ ->
      let state =
        five_silent_frames
        |> List.fold_left
             (fun state opus -> send_frame state (`Opus opus))
             state
      in
      send_speaking state false;
      { state with speaking = false }
  | heads, rest ->
      if not state.speaking then send_speaking state true;

      let state =
        heads
        |> List.fold_left
             (fun state frame -> send_frame state (`PCM_S16LE frame))
             state
      in

      let end_time = Eio.Time.now clock in
      let diff = end_time -. start_time in
      Gen_server.start_timeout clock ~sw
        ((second_per_frame *. float_of_int (List.length heads)) -. diff)
        "" caster;

      { state with speaking = true; frames = List.rev rest }

class t =
  object (self)
    inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t

    method private init env ~sw { ip; port; ssrc; vgw } =
      let socket =
        Eio.Net.datagram_socket ~sw (Eio.Stdenv.net env)
          (`Udp (Eio.Net.Ipaddr.V4.any, 0))
      in
      let dst =
        `Udp
          ( Ipaddr.of_string ip |> Result.get_ok |> Ipaddr.to_octets
            |> Eio.Net.Ipaddr.of_raw,
            port )
      in
      let seq_num = 123 (* FIXME *) in
      let timestamp = 123456 (* FIXME *) in
      let opus_encoder =
        Opus.Encoder.create ~sample_rate ~channels ~application
      in
      make_state ~socket ~dst ~ssrc ~vgw ~seq_num ~timestamp ~opus_encoder ()

    method! private terminate _ ~sw:_ state = Eio.Net.close state.socket

    method! private handle_call _env ~sw:_ state =
      function
      | `DiscoverIP ->
          let addr = discover_ip state.ssrc (udp_send state) (udp_recv state) in
          `Reply (`DiscoverIP addr, state)

    method! private handle_cast env ~sw state =
      function
      | `SecretKey key ->
          let secret_key =
            key |> List.map char_of_int |> List.to_seq |> Bytes.of_seq
            |> Sodium.Secret_box.Bytes.to_key |> Option.some
          in
          `NoReply { state with secret_key }
      | `Frame _ when Option.is_none state.secret_key -> `NoReply state
      | `Frame frame ->
          let state = { state with frames = frame :: state.frames } in
          let state =
            if state.speaking then state
            else start_sending_frames (Eio.Stdenv.clock env) ~sw state self
          in
          `NoReply state
      | `Timeout _ ->
          let state =
            start_sending_frames (Eio.Stdenv.clock env) ~sw state self
          in
          `NoReply state
  end

let create () = new t

let connect env sw t { vgw_conn; ip; port; ssrc; _ } =
  t#start env ~sw
    {
      ip;
      port;
      ssrc;
      vgw =
        object
          method cast =
            function
            | `Speaking (ssrc, speaking) ->
                let send_json conn json =
                  let content = Yojson.Safe.to_string json in
                  Logs.info (fun m -> m "Sending: %s" content);
                  Ws.write conn
                    Websocket.Frame.(create ~opcode:Opcode.Text ~content ())
                in
                Voice_event.(
                  Speaking
                    { speaking = (if speaking then 1 else 0); delay = 0; ssrc }
                  |> to_yojson)
                |> send_json vgw_conn
        end;
    }

let send_frame t frame = t#cast (`Frame frame)
let attach_secret_key t key = t#cast (`SecretKey key)
let close t = t#stop
let discover_ip (t : t) = match t#call `DiscoverIP with `DiscoverIP r -> r
