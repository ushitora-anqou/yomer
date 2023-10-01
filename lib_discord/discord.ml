module StringMap = Map.Make (String)

module With_mutex = struct
  type 'a t = { mtx : Eio.Mutex.t; v : 'a }

  let make v = { mtx = Eio.Mutex.create (); v }
  let ro_lock { mtx; v } f = Eio.Mutex.use_ro mtx (fun () -> f v)
  let rw_lock { mtx; v } f = Eio.Mutex.use_rw mtx (fun () -> f v)
end

(*
module Channel = struct
  type 'a t = {
    q : 'a Queue.t;
    m : Eio.Mutex.t;
    c : Eio.Condition.t;
    mutable waiters : (int, Eio.Condition.t) Hashtbl.t;
  }

  let add_waiter t c =
    let id = Random.bits () (* FIXME *) in
    Eio.Mutex.use_rw ~protect:true t.m (fun () -> Hashtbl.add t.waiters id c);
    id

  let remove_waiter t id =
    Eio.Mutex.use_rw ~protect:true t.m (fun () -> Hashtbl.remove t.waiters id)

  let pop_opt t =
    Eio.Mutex.use_rw ~protect:true t.m (fun () -> Queue.take_opt t.q)

  let worker t () =
    let rec loop () =
      Eio.Mutex.use_rw ~protect:true t.m (fun () ->
          while Queue.is_empty t.q do
            Eio.Condition.await t.c t.m
          done;
          t.waiters |> Hashtbl.iter (fun _ c -> Eio.Condition.broadcast c));
      loop ()
    in
    loop ()

  let create ~sw =
    let t =
      {
        q = Queue.create ();
        m = Eio.Mutex.create ();
        c = Eio.Condition.create ();
        waiters = Hashtbl.create 0;
      }
    in
    Eio.Fiber.fork ~sw (worker t);
    t

  let send t v =
    Eio.Mutex.use_rw ~protect:true t.m (fun () -> Queue.add v t.q);
    Eio.Condition.broadcast t.c

  let select ts =
    let m = Eio.Mutex.create () in
    let c = Eio.Condition.create () in
    let ids = ts |> List.map (fun t -> add_waiter t c) in
    let try_pop_somewhere () =
      let rec aux i = function
        | [] -> None
        | t :: ts -> (
            match pop_opt t with None -> aux (i + 1) ts | Some v -> Some (i, v))
      in
      aux 0 ts
    in
    let rec loop () =
      match try_pop_somewhere () with
      | None ->
          Eio.Condition.await c m;
          loop ()
      | Some (i, v) ->
          List.combine ids ts |> List.iter (fun (id, t) -> remove_waiter t id);
          (i, v)
    in
    loop ()

  let receive t = select [ t ] |> snd
end
*)

module Mailbox = struct
  type 'a t = {
    q : 'a Queue.t;
    c : Eio.Condition.t;
    m : Eio.Mutex.t;
    closed : bool Atomic.t;
  }

  let create () =
    {
      q = Queue.create ();
      c = Eio.Condition.create ();
      m = Eio.Mutex.create ();
      closed = Atomic.make false;
    }

  let close t = Atomic.set t.closed true

  let is_empty t =
    if Atomic.get t.closed then true
    else Eio.Mutex.use_ro t.m (fun () -> Queue.is_empty t.q)

  let send t v =
    if Atomic.get t.closed then (
      Logs.warn (fun m -> m "Mailbox.send: already closed");
      ())
    else (
      Eio.Mutex.use_rw ~protect:false t.m (fun () -> Queue.add v t.q);
      Eio.Condition.broadcast t.c)

  let receive t =
    Eio.Mutex.use_rw ~protect:false t.m (fun () ->
        while Queue.is_empty t.q do
          Eio.Condition.await t.c t.m
        done;
        Queue.take t.q)

  let receive_nowait t =
    Eio.Mutex.use_rw ~protect:false t.m (fun () -> Queue.take_opt t.q)
end

(*
  Architecture of Discord module:
    - Fiber Gateway (x 1)
    - Fiber VoiceGateway (x # of guilds with voice)
    - Fiber VoiceUDPStream (x # of guilds with voice)
    - Fiber EventConsumer (x 1)

  Each fiber has a mailbox to interact with other fibers.

  Each fiber consists of a module with the following interface:

  ```ocaml
  module M = struct
    type msg = ...
    type t = { m : msg Mailbox.t; ... }

    let main config env sw ... m () =
      let rec loop () =
        match Mailbox.receive m with
        | ... -> ...
      in
      loop ()

    let spawn config env ... =
      let m = Mailbox.create () in
      Eio.Fiber.fork ~sw (main config env ... m);
      { m; ... }

    let send_message { m; _ } msg = Mailbox.send m msg
  end
  ```
*)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type json_any = Yojson.Safe.t [@@deriving show]

let json_any_of_yojson = Fun.id
let yojson_of_json_any = Fun.id

module Config = struct
  type t = { token : string; intents : int } [@@deriving make]

  let token { token; _ } = token
  let intents { intents; _ } = intents
end

module User = struct
  type t = { username : string; id : string }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]
end

module VoiceState = struct
  type t = {
    guild_id : string option; [@yojson.option]
    channel_id : string option;
    user_id : string;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

  let of_yojson = t_of_yojson
end

module Guild = struct
  type t = {
    id : string;
    voice_states : VoiceState.t list option; [@yojson.option]
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  let of_yojson = t_of_yojson
end

module Message = struct
  type t = {
    id : string;
    author : User.t;
    channel_id : string;
    content : string;
    timestamp : string;
    edited_timestamp : string option;
    tts : bool;
    mention_everyone : bool;
    pinned : bool;
    webhook_id : string option; [@yojson.option]
    type_ : int; [@key "type"]
    guild_id : string;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  let of_yojson = t_of_yojson
  let to_yojson = yojson_of_t
end

module Event = struct
  type dispatch_ready = {
    v : int;
    user : User.t;
    guilds : json_any;
    session_id : string;
    resume_gateway_url : string;
    application : json_any;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type dispatch_voice_server_update = {
    token : string;
    guild_id : string;
    endpoint : string;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type dispatch_voice_state_update = {
    guild_id : string option;
    channel_id : string option;
    user_id : string;
    session_id : string;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type dispatch =
    | READY of dispatch_ready
    | GUILD_CREATE of json_any
    | MESSAGE_CREATE of Message.t
    | VOICE_STATE_UPDATE of dispatch_voice_state_update
    | VOICE_SERVER_UPDATE of dispatch_voice_server_update
  [@@deriving yojson, show]

  type t =
    | (* 0 *) Dispatch of dispatch
    | (* 1 *) Heartbeat of int option
    | (* 2 *) Identify of {
        token : string;
        properties : Yojson.Safe.t;
        intents : int;
      }
    | (* 4 *) VoiceStateUpdate of {
        guild_id : string;
        channel_id : string option;
        self_mute : bool;
        self_deaf : bool;
      }
    | (* 10 *) Hello of { heartbeat_interval : int }
    | (* 11 *) HeartbeatAck
    | (* custom *) VoiceReady of { guild_id : string }
  [@@deriving show]

  let of_yojson json =
    let open Yojson.Safe.Util in
    try
      let op = json |> member "op" |> to_int in
      match op with
      | 0 ->
          let t = json |> member "t" in
          let d = json |> member "d" in
          `List [ t; d ] |> dispatch_of_yojson |> fun x -> Dispatch x
      | 1 -> Heartbeat None
      | 10 ->
          let d = json |> member "d" in
          let heartbeat_interval = d |> member "heartbeat_interval" |> to_int in
          Hello { heartbeat_interval }
      | 11 -> HeartbeatAck
      | _ -> failwith "Invalid op"
    with Type_error _ -> failwith "Invalid JSON for event"

  let to_yojson = function
    | Heartbeat s ->
        `Assoc
          [
            ("op", `Int 1);
            ("d", s |> Option.fold ~none:`Null ~some:(fun s -> `Int s));
          ]
    | Identify { token; properties; intents } ->
        `Assoc
          [
            ("op", `Int 2);
            ( "d",
              `Assoc
                [
                  ("token", `String token);
                  ("properties", properties);
                  ("intents", `Int intents);
                ] );
          ]
    | VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf } ->
        `Assoc
          [
            ("op", `Int 4);
            ( "d",
              `Assoc
                [
                  ("guild_id", `String guild_id);
                  ( "channel_id",
                    channel_id
                    |> Option.fold ~none:`Null ~some:(fun s -> `String s) );
                  ("self_mute", `Bool self_mute);
                  ("self_deaf", `Bool self_deaf);
                ] );
          ]
    | _ -> failwith "Not implemeneted"
end

module Intent = struct
  type t =
    | GUILDS
    | GUILD_MEMBERS
    | GUILD_MODERATION
    | GUILD_EMOJIS_AND_STICKERS
    | GUILD_INTEGRATIONS
    | GUILD_WEBHOOKS
    | GUILD_INVITES
    | GUILD_VOICE_STATES
    | GUILD_PRESENCES
    | GUILD_MESSAGES
    | GUILD_MESSAGE_REACTIONS
    | GUILD_MESSAGE_TYPING
    | DIRECT_MESSAGES
    | DIRECT_MESSAGE_REACTIONS
    | DIRECT_MESSAGE_TYPING
    | MESSAGE_CONTENT
    | GUILD_SCHEDULED_EVENTS
    | INTENT_17
    | INTENT_18
    | INTENT_19
    | AUTO_MODERATION_CONFIGURATION
    | AUTO_MODERATION_EXECUTION
  [@@deriving enum]

  let encode = List.fold_left (fun acc i -> acc lor (1 lsl to_enum i)) 0
end

module VoiceEvent = struct
  type ready = {
    ssrc : int;
    ip : string;
    port : int;
    modes : string list;
    heartbeat_interval : int;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type identify = {
    server_id : string;
    user_id : string;
    session_id : string;
    token : string;
  }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type select_protocol_data = { address : string; port : int; mode : string }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type select_protocol = { protocol : string; data : select_protocol_data }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type session_description = { mode : string; secret_key : int list }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type speaking = { speaking : int; delay : int; ssrc : int }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type hello = { heartbeat_interval : int }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type resume = { server_id : string; session_id : string; token : string }
  [@@yojson.allow_extra_fields] [@@deriving yojson, show]

  type t =
    | Identify (* 0 *) of identify
    | SelectProtocol (* 1 *) of select_protocol
    | Ready (* 2 *) of ready
    | Heartbeat (* 3 *) of int (* nonce *)
    | SessionDescription (* 4 *) of session_description
    | Speaking (* 5 *) of speaking
    | HeartbeatAck (* 6 *) of int (* nonce *)
    | Resume (* 7 *) of resume
    | Hello (* 8 *) of hello
    | Resumed (* 9 *)

  let of_yojson json =
    let open Yojson.Safe.Util in
    try
      let op = json |> member "op" |> to_int in
      let d = json |> member "d" in
      match op with
      | 0 -> d |> identify_of_yojson |> fun x -> Identify x
      | 1 -> d |> select_protocol_of_yojson |> fun x -> SelectProtocol x
      | 2 -> d |> ready_of_yojson |> fun x -> Ready x
      | 3 -> d |> to_int |> fun x -> Heartbeat x
      | 4 -> d |> session_description_of_yojson |> fun x -> SessionDescription x
      | 5 -> d |> speaking_of_yojson |> fun x -> Speaking x
      | 6 -> d |> to_int |> fun x -> HeartbeatAck x
      | 7 -> d |> resume_of_yojson |> fun x -> Resume x
      | 8 -> d |> hello_of_yojson |> fun x -> Hello x
      | 9 -> Resumed
      | _ -> failwith "Invalid op"
    with Type_error _ -> failwith "Invalid JSON for event"

  let to_yojson = function
    | Identify d -> `Assoc [ ("op", `Int 0); ("d", yojson_of_identify d) ]
    | SelectProtocol d ->
        `Assoc [ ("op", `Int 1); ("d", yojson_of_select_protocol d) ]
    | Ready d -> `Assoc [ ("op", `Int 2); ("d", yojson_of_ready d) ]
    | Heartbeat d -> `Assoc [ ("op", `Int 3); ("d", `Int d) ]
    | SessionDescription d ->
        `Assoc [ ("op", `Int 4); ("d", yojson_of_session_description d) ]
    | Speaking d -> `Assoc [ ("op", `Int 5); ("d", yojson_of_speaking d) ]
    | HeartbeatAck d -> `Assoc [ ("op", `Int 6); ("d", `Int d) ]
    | Resume d -> `Assoc [ ("op", `Int 7); ("d", yojson_of_resume d) ]
    | Hello d -> `Assoc [ ("op", `Int 8); ("d", yojson_of_hello d) ]
    | Resumed -> `Assoc [ ("op", `Int 9); ("d", `Null) ]
end

module VoiceUDPStream : sig
  type t

  type connection_param = {
    vgw_conn : Ws.conn;
    ip : string;
    port : int;
    ssrc : int;
    modes : string list;
  }

  val frame_size : int
  val spawn : Config.t -> Eio_unix.Stdenv.base -> Eio.Switch.t -> t
  val connect : t -> connection_param -> unit
  val send_frame : t -> string -> unit
  val attach_secret_key : t -> int list -> unit
  val close : t -> unit
end = struct
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
    Fun.protect
      ~finally:(fun () -> Eio.Net.close socket)
      (fun () -> f send recv)

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
      |> Bytes.fold_left
           (fun acc ch -> if ch = '\x00' then acc else ch :: acc)
           []
      |> List.rev |> List.to_seq |> String.of_seq
    in
    let port = Cstruct.BE.get_uint16 buf 72 in
    (ip, port)

  let send_select_protocol conn ip port modes =
    if modes |> List.find_opt (fun m -> m = encryption_mode) = None then
      failwith (encryption_mode ^ " is not supported");
    VoiceEvent.(
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
      Sodium.Secret_box.Bytes.secret_box secret_key opus nonce
      |> Cstruct.of_bytes
    in

    (* Send the data *)
    udp_send [ header; ctxt ];

    (* Increment sequence number and timestamp *)
    seq_num := !seq_num + 1;
    timestamp := !timestamp + frame_size;

    ()

  let send_speaking conn ssrc speaking =
    VoiceEvent.(
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

      if empty then
        (* Beginning of the speech *)
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
end

module VoiceGateway : sig
  type t

  val spawn :
    Config.t ->
    Eio_unix.Stdenv.base ->
    Eio.Switch.t ->
    Event.t Mailbox.t ->
    guild_id:string ->
    t

  val attach_voice_state : user_id:string -> session_id:string -> t -> unit
  val attach_voice_server : token:string -> endpoint:string -> t -> unit
  val send_frame : t -> string -> unit
end = struct
  type msg =
    | VoiceState of { user_id : string; session_id : string }
    | VoiceServer of { token : string; endpoint : string }

  type t = { udp_stream : VoiceUDPStream.t; mailbox : msg Mailbox.t }

  let send_json conn json =
    let content = Yojson.Safe.to_string json in
    Logs.info (fun m -> m "Sending: %s" content);
    Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

  let send_heartbeat clock conn =
    let nonce = Eio.Time.now clock |> int_of_float in
    VoiceEvent.(Heartbeat nonce |> to_yojson) |> send_json conn;
    Logs.info (fun m -> m "Voice Heartbeat sent")

  exception Shutdown

  let main_heartbeat clock mailbox =
    (* FIXME: VGWConn should be handled during the sleep *)
    let rec loop interval conn =
      let interval, conn =
        match Mailbox.receive_nowait mailbox with
        | None -> (interval, conn)
        | Some (`VGWConn (Some interval, conn)) -> (interval, conn)
        | Some (`VGWConn (None, conn)) -> (interval, conn)
        | Some `Close -> raise Shutdown
      in
      (try send_heartbeat clock conn
       with e ->
         Logs.err (fun m ->
             m "Failed to send heartbeat: %s" (Printexc.to_string e)));
      (* FIXME: Although `/. 2.0` is not necessary in theory, ws and udp connections
         don't maintain without this hack. *)
      Eio.Time.sleep clock (interval /. 2.0);
      loop interval conn
    in
    let interval, conn =
      match Mailbox.receive mailbox with
      | `VGWConn (Some interval, conn) -> (interval, conn)
      | _ -> failwith "Invalid initial VGWConn"
    in
    try loop interval conn with Shutdown -> ()

  let spawn_heartbeat clock sw mailbox =
    Eio.Fiber.fork ~sw (fun () -> main_heartbeat clock mailbox)

  let event_handler _config _env _sw vgw_conn udp_stream guild_id
      heartbeat_mailbox consumer_mailbox = function
    | VoiceEvent.Hello { heartbeat_interval } ->
        let interval = float_of_int heartbeat_interval /. 1000.0 in
        Mailbox.send heartbeat_mailbox (`VGWConn (Some interval, vgw_conn))
    | Resumed -> Mailbox.send heartbeat_mailbox (`VGWConn (None, vgw_conn))
    | Heartbeat _ | HeartbeatAck _ ->
        (*
          FIXME: Although the Discord doc says that the server will return
          HeartbeatAck (opcode 6) in response to Heartbeat (opcode 3) from its clients,
          it seems to actually return Heartbeat.
        *)
        ()
    | Ready { ip; port; ssrc; modes; _ } ->
        VoiceUDPStream.connect udp_stream { vgw_conn; ip; port; ssrc; modes }
    | SessionDescription { secret_key; _ } ->
        VoiceUDPStream.attach_secret_key udp_stream secret_key;
        Mailbox.send consumer_mailbox (Event.VoiceReady { guild_id })
    | Identify _ | SelectProtocol _ | Speaking _ | Resume _ ->
        failwith "Unexpected event"

  let receive_ids mailbox =
    let ref_endpoint = ref None in
    let ref_token = ref None in
    let ref_session_id = ref None in
    let ref_user_id = ref None in
    while
      !ref_endpoint = None || !ref_token = None || !ref_session_id = None
      || !ref_user_id = None
    do
      match Mailbox.receive mailbox with
      | VoiceState { user_id; session_id } ->
          ref_user_id := Some user_id;
          ref_session_id := Some session_id
      | VoiceServer { token; endpoint } ->
          ref_token := Some token;
          ref_endpoint := Some endpoint
    done;
    ( Option.get !ref_endpoint,
      Option.get !ref_token,
      Option.get !ref_session_id,
      Option.get !ref_user_id )

  let main env sw config guild_id consumer_mailbox udp_stream mailbox () =
    let endpoint, token, session_id, user_id = receive_ids mailbox in

    let heartbeat_mailbox = Mailbox.create () in
    spawn_heartbeat (Eio.Stdenv.clock env) sw heartbeat_mailbox;

    let connect_ws () =
      Ws.connect ~sw env ("https://" ^ endpoint ^ "/?v=4&encoding=json")
    in
    let conn = ref @@ connect_ws () in

    VoiceEvent.(
      Identify { server_id = guild_id; user_id; session_id; token } |> to_yojson)
    |> send_json !conn;
    let rec loop () =
      let frame = Ws.read !conn in
      Logs.info (fun m -> m "Received (voice): %a" Websocket.Frame.pp frame);
      match frame.opcode with
      | Text ->
          (try
             frame.content |> Yojson.Safe.from_string |> VoiceEvent.of_yojson
             |> event_handler config env sw !conn udp_stream guild_id
                  heartbeat_mailbox consumer_mailbox
           with e ->
             Logs.err (fun m ->
                 m "Handling event failed (voice): %s: %s"
                   (Printexc.to_string e) frame.content));
          loop ()
      | Close ->
          let status_code = String.get_int16_be frame.content 0 in
          Logs.warn (fun m ->
              m "Voice Websocket connection closed: code %d" status_code);
          if status_code = 4015 then (
            Logs.info (fun m ->
                m "Discord voice server crashed. Trying to resume.");
            conn := connect_ws ();
            VoiceEvent.(
              Resume { server_id = guild_id; session_id; token } |> to_yojson)
            |> send_json !conn;
            loop ())
      | _ ->
          Logs.info (fun m ->
              m "Received non-text frame (voice): %a" Websocket.Frame.pp frame);
          loop ()
    in
    loop ();

    (* Gracefully shutdown *)
    Mailbox.close mailbox;
    Mailbox.send heartbeat_mailbox `Close;
    Mailbox.close heartbeat_mailbox;
    VoiceUDPStream.close udp_stream;
    ()

  let spawn config env sw consumer_mailbox ~guild_id =
    let mailbox = Mailbox.create () in
    let udp_stream = VoiceUDPStream.spawn config env sw in
    Eio.Fiber.fork ~sw
      (main env sw config guild_id consumer_mailbox udp_stream mailbox);
    { udp_stream; mailbox }

  let attach_voice_state ~user_id ~session_id { mailbox; _ } =
    Mailbox.send mailbox (VoiceState { user_id; session_id })

  let attach_voice_server ~token ~endpoint { mailbox; _ } =
    Mailbox.send mailbox (VoiceServer { token; endpoint })

  let send_frame t frame = VoiceUDPStream.send_frame t.udp_stream frame
end

module State = struct
  type guild_data_t = {
    guild_id : string;
    voice_states : VoiceState.t StringMap.t (* user_id -> VoiceState.t *);
    voice : (string (* channel_id *) * VoiceGateway.t) option;
  }

  let empty_guild_data guild_id =
    { guild_id; voice_states = StringMap.empty; voice = None }

  type t = {
    s : int Atomic.t;
    guild_data : (string (* guild id *), guild_data_t) Hashtbl.t With_mutex.t;
    me : User.t option Atomic.t;
  }

  let create () =
    {
      s = Atomic.make 0;
      guild_data = Hashtbl.create 0 |> With_mutex.make;
      me = Atomic.make None;
    }

  let s { s; _ } = Atomic.get s
  let set_s { s; _ } = Atomic.set s
  let me { me; _ } = Atomic.get me
  let set_me { me; _ } = Atomic.set me

  let guild_data { guild_data; _ } guild_id =
    With_mutex.ro_lock guild_data @@ fun h -> Hashtbl.find_opt h guild_id

  let update_guild_data { guild_data; _ } guild_id f =
    With_mutex.rw_lock ~protect:true guild_data @@ fun h ->
    Hashtbl.find_opt h guild_id
    |> Option.value ~default:(empty_guild_data guild_id)
    |> f |> Hashtbl.replace h guild_id
end

module Gateway : sig
  type t

  val spawn :
    Config.t ->
    Eio_unix.Stdenv.base ->
    Eio.Switch.t ->
    State.t ->
    Event.t Mailbox.t ->
    t

  val send_voice_state_update :
    guild_id:string ->
    ?channel_id:string ->
    self_mute:bool ->
    self_deaf:bool ->
    t ->
    unit
end = struct
  type msg =
    | SendVoiceStateUpdate of {
        guild_id : string;
        channel_id : string option;
        self_mute : bool;
        self_deaf : bool;
      }

  type t = { mailbox : msg Mailbox.t }

  let extract_sequence_number src =
    let open Yojson.Safe.Util in
    src |> member "s" |> to_int_option

  let send_json conn json =
    let content = Yojson.Safe.to_string json in
    Logs.info (fun m -> m "Sending: %s" content);
    Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

  let start_sending_heartbeat st env sw conn interval =
    let open Event in
    let rec loop () =
      Heartbeat (Some (State.s st)) |> to_yojson |> send_json conn;
      Logs.info (fun m -> m "Heartbeat sent");
      Eio.Time.sleep (Eio.Stdenv.clock env) interval;
      loop ()
    in
    Eio.Fiber.fork ~sw (fun () ->
        Eio.Time.sleep (Eio.Stdenv.clock env) (interval *. Random.float 1.0);
        loop ())

  let event_handler config st env sw conn =
    let open Event in
    function
    | Hello { heartbeat_interval } ->
        start_sending_heartbeat st env sw conn
          (float_of_int heartbeat_interval /. 1000.0);
        Identify
          {
            token = Config.token config;
            intents = Config.intents config;
            properties =
              `Assoc
                [
                  ("os", `String "linux");
                  ("browser", `String "yomer");
                  ("device", `String "yomer");
                ];
          }
        |> to_yojson |> send_json conn
    | HeartbeatAck ->
        (* FIXME: check if HeartbeatAck is correctly received *)
        Logs.info (fun m -> m "Heartbeat acked");
        ()
    | Heartbeat _ ->
        Heartbeat (Some (State.s st)) |> to_yojson |> send_json conn
    | Dispatch
        (VOICE_STATE_UPDATE
          { guild_id = Some guild_id; user_id; session_id; channel_id }) ->
        let self_user_id = State.me st |> Option.get in
        (if user_id = self_user_id.User.id then
           let g = State.guild_data st guild_id |> Option.get in
           let vgw = Option.get g.voice |> snd in
           VoiceGateway.attach_voice_state ~user_id ~session_id vgw);

        State.update_guild_data st guild_id (fun data ->
            (* Update data.voice_states *)
            {
              data with
              voice_states =
                data.voice_states
                |> StringMap.add user_id
                     (VoiceState.make ~guild_id:data.guild_id ?channel_id
                        ~user_id ());
            })
    | Dispatch (VOICE_SERVER_UPDATE { token; guild_id; endpoint }) ->
        let g = State.guild_data st guild_id |> Option.get in
        let vgw = Option.get g.voice |> snd in
        VoiceGateway.attach_voice_server ~token ~endpoint vgw
    | Dispatch (READY { user; _ }) ->
        State.set_me st (Some user);
        ()
    | Dispatch (GUILD_CREATE json) -> (
        match Guild.of_yojson json with
        | exception _ -> ()
        | g ->
            State.update_guild_data st g.id (fun data ->
                {
                  data with
                  guild_id = g.id;
                  voice_states =
                    g.voice_states
                    |> Option.map (fun xs ->
                           xs
                           |> List.map (fun x -> (x.VoiceState.user_id, x))
                           |> List.to_seq |> StringMap.of_seq)
                    |> Option.value ~default:StringMap.empty;
                });
            ())
    | Dispatch _ | VoiceStateUpdate _ -> ()
    | VoiceReady _ | Identify _ -> failwith "Unexpected event"

  let main_ws_send mailbox conn () =
    let rec loop () =
      let msg = Mailbox.receive mailbox in
      (match msg with
      | SendVoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf } ->
          Event.VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf }
          |> Event.to_yojson |> send_json conn);
      loop ()
    in
    loop ()

  let main_ws_recv config env sw state consumer_mailbox conn () =
    let rec loop () =
      let frame = Ws.read conn in
      Logs.info (fun m -> m "Received: %a" Websocket.Frame.pp frame);
      match frame.opcode with
      | Text ->
          (try
             let json = frame.content |> Yojson.Safe.from_string in
             (match extract_sequence_number json with
             | Some s -> State.set_s state s
             | None -> ());
             let ev = json |> Event.of_yojson in
             event_handler config state env sw conn ev;
             Mailbox.send consumer_mailbox ev
           with e ->
             Logs.err (fun m ->
                 m "Handling event failed: %s: %s" (Printexc.to_string e)
                   frame.content));
          loop ()
      | Close ->
          let status_code = String.get_int16_be frame.content 0 in
          Logs.warn (fun m ->
              m "Voice Websocket connection closed: code %d" status_code);
          (* FIXME: Resume the connection if possible *)
          ()
      | _ ->
          Logs.info (fun m ->
              m "Received non-text frame: %a" Websocket.Frame.pp frame);
          loop ()
    in
    loop ()

  let main config env sw state consumer_mailbox mailbox () =
    let conn =
      Ws.connect ~sw env "https://gateway.discord.gg/?v=10&encoding=json"
    in
    Eio.Fiber.both
      (main_ws_recv config env sw state consumer_mailbox conn)
      (main_ws_send mailbox conn)

  let spawn config env sw state consumer_mailbox =
    let mailbox = Mailbox.create () in
    Eio.Fiber.fork ~sw (main config env sw state consumer_mailbox mailbox);
    { mailbox }

  let send_voice_state_update ~guild_id ?channel_id ~self_mute ~self_deaf t =
    SendVoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf }
    |> Mailbox.send t.mailbox
end

module Agent = struct
  type t = {
    config : Config.t;
    env : Eio_unix.Stdenv.base;
    state : State.t;
    sw : Eio.Switch.t;
    gw : Gateway.t;
    consumer_mailbox : Event.t Mailbox.t;
  }

  let consumer env config sw state gw user_handler mailbox : unit =
    let rec loop () =
      let event = Mailbox.receive mailbox in
      (try
         user_handler
           { config; gw; env; sw; state; consumer_mailbox = mailbox }
           event
       with e ->
         Logs.err (fun m ->
             m "User event consumer raised an exception: %s: %a"
               (Printexc.to_string e) Event.pp event));
      loop ()
    in
    loop ()

  let start ~env ~config user_handler =
    let state = State.create () in
    let consumer_mailbox = Mailbox.create () in
    Eio.Switch.run @@ fun sw ->
    let gw = Gateway.spawn config env sw state consumer_mailbox in
    consumer env config sw state gw user_handler consumer_mailbox;
    ()

  let join_channel ?(self_mute = false) ?(self_deaf = false) ~guild_id
      ~channel_id (a : t) =
    State.update_guild_data a.state guild_id (fun data ->
        match data.voice with
        | Some (channel_id', _) when channel_id = channel_id' -> data
        | _ ->
            let voice_gw =
              VoiceGateway.spawn a.config a.env a.sw a.consumer_mailbox
                ~guild_id
            in
            { data with voice = Some (channel_id, voice_gw) });
    Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute ~self_deaf
      a.gw

  let leave_channel ~guild_id (a : t) =
    Gateway.send_voice_state_update ~guild_id ~self_mute:false ~self_deaf:false
      a.gw;
    State.update_guild_data a.state guild_id (fun data ->
        { data with voice = None })

  let get_voice_states ~guild_id (a : t) =
    State.guild_data a.state guild_id
    |> Option.fold ~none:StringMap.empty ~some:(fun x -> x.State.voice_states)

  let play_voice ~guild_id ~src (a : t) =
    let vgw =
      match State.guild_data a.state guild_id with
      | None -> failwith "Guild not found"
      | Some g -> (
          match g.voice with
          | None -> failwith "VoiceGateway is not available"
          | Some (_, vgw) -> vgw)
    in
    match src with
    | `PCM_S16LE data ->
        let buf_len = VoiceUDPStream.frame_size * 2 * 2 in
        let frames =
          List.init
            (String.length data / buf_len)
            (fun i -> String.sub data (i * buf_len) buf_len)
        in
        frames |> List.iter (fun frame -> VoiceGateway.send_frame vgw frame)
end
