type msg =
  | VoiceState of { user_id : string; session_id : string }
  | VoiceServer of { token : string; endpoint : string }

type t = { udp_stream : Voice_udp_stream.t; mailbox : msg Mailbox.t }

let send_json conn json =
  let content = Yojson.Safe.to_string json in
  Logs.info (fun m -> m "Sending: %s" content);
  Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

let send_heartbeat clock conn =
  let nonce = Eio.Time.now clock |> int_of_float in
  Voice_event.(Heartbeat nonce |> to_yojson) |> send_json conn;
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
  | Voice_event.Hello { heartbeat_interval } ->
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
      Voice_udp_stream.connect udp_stream { vgw_conn; ip; port; ssrc; modes }
  | SessionDescription { secret_key; _ } ->
      Voice_udp_stream.attach_secret_key udp_stream secret_key;
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

  Voice_event.(
    Identify { server_id = guild_id; user_id; session_id; token } |> to_yojson)
  |> send_json !conn;
  let rec loop () =
    let frame = Ws.read !conn in
    Logs.info (fun m -> m "Received (voice): %a" Websocket.Frame.pp frame);
    match frame.opcode with
    | Text ->
        (try
           frame.content |> Yojson.Safe.from_string |> Voice_event.of_yojson
           |> event_handler config env sw !conn udp_stream guild_id
                heartbeat_mailbox consumer_mailbox
         with e ->
           Logs.err (fun m ->
               m "Handling event failed (voice): %s: %s" (Printexc.to_string e)
                 frame.content));
        loop ()
    | Close ->
        let status_code = String.get_int16_be frame.content 0 in
        Logs.warn (fun m ->
            m "Voice Websocket connection closed: code %d" status_code);
        if status_code = 4015 then (
          Logs.info (fun m ->
              m "Discord voice server crashed. Trying to resume.");
          conn := connect_ws ();
          Voice_event.(
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
  Voice_udp_stream.close udp_stream;
  ()

let spawn config env sw consumer_mailbox ~guild_id =
  let mailbox = Mailbox.create () in
  let udp_stream = Voice_udp_stream.spawn config env sw in
  Eio.Fiber.fork ~sw
    (main env sw config guild_id consumer_mailbox udp_stream mailbox);
  { udp_stream; mailbox }

let attach_voice_state ~user_id ~session_id { mailbox; _ } =
  Mailbox.send mailbox (VoiceState { user_id; session_id })

let attach_voice_server ~token ~endpoint { mailbox; _ } =
  Mailbox.send mailbox (VoiceServer { token; endpoint })

let send_frame t frame = Voice_udp_stream.send_frame t.udp_stream frame
