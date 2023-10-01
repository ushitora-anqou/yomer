open Util

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
  | Heartbeat _ -> Heartbeat (Some (State.s st)) |> to_yojson |> send_json conn
  | Dispatch
      (VOICE_STATE_UPDATE
        { guild_id = Some guild_id; user_id; session_id; channel_id }) ->
      let self_user_id = State.me st |> Option.get in
      (if user_id = self_user_id.User.id then
         let g = State.guild_data st guild_id |> Option.get in
         let vgw = Option.get g.voice |> snd in
         Voice_gateway.attach_voice_state ~user_id ~session_id vgw);

      State.update_guild_data st guild_id (fun data ->
          (* Update data.voice_states *)
          {
            data with
            voice_states =
              data.voice_states
              |> StringMap.add user_id
                   (Voice_state.make ~guild_id:data.guild_id ?channel_id
                      ~user_id ());
          })
  | Dispatch (VOICE_SERVER_UPDATE { token; guild_id; endpoint }) ->
      let g = State.guild_data st guild_id |> Option.get in
      let vgw = Option.get g.voice |> snd in
      Voice_gateway.attach_voice_server ~token ~endpoint vgw
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
                         |> List.map (fun x -> (x.Voice_state.user_id, x))
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
