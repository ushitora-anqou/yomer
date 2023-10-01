type connection_param = {
  vgw_conn : Ws.conn;
  ip : string;
  port : int;
  ssrc : int;
  modes : string list;
}

type item =
  | SecretKey of int list
  | Frame of string
  | Connect of connection_param
  | Close

type t = { m : item Mailbox.t }

exception Reconnect of connection_param

let encryption_mode = "xsalsa20_poly1305"
let frame_size = 960
let second_per_frame = 0.02
let sample_rate = 48000
let channels = 2
let application = Opus.Voip
let num_burst_frames = 10

let with_udp_connection env sw ip port f =
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
  let send = Eio.Net.send ~dst socket in
  let recv = Eio.Net.recv socket in
  Fun.protect ~finally:(fun () -> Eio.Net.close socket) (fun () -> f send recv)

let send_json conn json =
  let content = Yojson.Safe.to_string json in
  Logs.info (fun m -> m "Sending: %s" content);
  Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

let perform_ip_discovery ssrc send recv =
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

let send_select_protocol conn ip port modes =
  if modes |> List.find_opt (fun m -> m = encryption_mode) = None then
    failwith (encryption_mode ^ " is not supported");
  Voice_event.(
    SelectProtocol
      {
        protocol = "udp";
        data = { address = ip; port; mode = encryption_mode };
      }
    |> to_yojson)
  |> send_json conn

let receive_secret_key mailbox =
  match Mailbox.receive mailbox with
  | SecretKey secret_key ->
      secret_key |> List.map char_of_int |> List.to_seq |> Bytes.of_seq
      |> Sodium.Secret_box.Bytes.to_key
  | _ -> failwith "unexpected event"

let send_frame opus_encoder seq_num timestamp ssrc secret_key udp_send frame =
  let opus =
    match frame with
    | `PCM_S16LE pcm -> Opus.Encoder.encode opus_encoder (`S16LE pcm)
    | `Opus opus -> Bytes.of_string opus
  in

  (* Build RTP header *)
  let header = Cstruct.create 12 in
  Cstruct.set_uint8 header 0 0x80;
  Cstruct.set_uint8 header 1 0x78;
  Cstruct.BE.set_uint16 header 2 !seq_num (* Sequence *);
  Cstruct.BE.set_uint32 header 4 (Int32.of_int !timestamp) (* Timestamp *);
  Cstruct.BE.set_uint32 header 8 (Int32.of_int ssrc);

  (* Encrypt the voice data *)
  let nonce =
    let buf = Cstruct.create 24 in
    Cstruct.blit header 0 buf 0 12;
    buf |> Cstruct.to_bytes |> Sodium.Secret_box.nonce_of_bytes
  in
  let ctxt =
    Sodium.Secret_box.Bytes.secret_box secret_key opus nonce |> Cstruct.of_bytes
  in

  (* Send the data *)
  udp_send [ header; ctxt ];

  (* Increment sequence number and timestamp *)
  seq_num := !seq_num + 1;
  timestamp := !timestamp + frame_size;

  ()

let send_speaking conn ssrc speaking =
  Voice_event.(
    Speaking { speaking = (if speaking then 1 else 0); delay = 0; ssrc }
    |> to_yojson)
  |> send_json conn

exception Shutdown

let main _config env sw { vgw_conn; ip; port; ssrc; modes } mailbox () =
  let encoder = Opus.Encoder.create ~sample_rate ~channels ~application in
  let seq_num = ref 123 (* FIXME: should be random *) in
  let timestamp = ref 123456 (* FIXME: should be random *) in

  with_udp_connection env sw ip port @@ fun udp_send udp_recv ->
  let my_ip, my_port = perform_ip_discovery ssrc udp_send udp_recv in
  send_select_protocol vgw_conn my_ip my_port modes;
  let secret_key = receive_secret_key mailbox in

  let five_silent_frames = List.init 5 (fun _ -> "\xf8\xff\xfe") in

  let rec send_loop () =
    let empty = Mailbox.is_empty mailbox in

    if empty then (
      (* End of the speech *)
      five_silent_frames
      |> List.iter (fun opus ->
             send_frame encoder seq_num timestamp ssrc secret_key udp_send
               (`Opus opus));
      send_speaking vgw_conn ssrc false);

    let head_frame =
      match Mailbox.receive mailbox with
      | Connect param -> raise (Reconnect param)
      | SecretKey _ -> failwith "duplicated secret_key"
      | Frame frame -> frame
      | Close -> raise Shutdown
    in
    let frames =
      List.init (num_burst_frames - 1) (fun _ ->
          match Mailbox.receive_nowait mailbox with
          | Some (Connect param) -> raise (Reconnect param)
          | Some (SecretKey _) -> failwith "duplicated secret_key"
          | Some (Frame frame) -> Some frame
          | Some Close -> raise Shutdown
          | None -> None)
      |> List.filter_map Fun.id |> List.cons head_frame
    in

    if empty then (* Beginning of the speech *)
      send_speaking vgw_conn ssrc true;

    frames
    |> List.iter (fun frame ->
           send_frame encoder seq_num timestamp ssrc secret_key udp_send
             (`PCM_S16LE frame));
    Eio.Time.sleep (Eio.Stdenv.clock env)
      (second_per_frame *. float_of_int (List.length frames));

    send_loop ()
  in
  (try send_loop () with Shutdown -> ());

  ()

let connector config env sw m () =
  let rec loop param =
    try main config env sw param m () with Reconnect param -> loop param
  in
  match Mailbox.receive m with
  | Connect param -> loop param
  | _ -> failwith "Invalid event"

let spawn config env sw =
  let m = Mailbox.create () in
  Eio.Fiber.fork ~sw (connector config env sw m);
  { m }

let connect { m; _ } param = Connect param |> Mailbox.send m
let send_frame { m; _ } frame = Mailbox.send m (Frame frame)

let attach_secret_key { m; _ } secret_key =
  Mailbox.send m (SecretKey secret_key)

let close { m; _ } = Mailbox.send m Close
