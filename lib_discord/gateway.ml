open Util

type consumer_cast_msg = Event.t

type init_arg = {
  consumer : consumer_cast_msg Gen_server.caster;
  config : Config.t;
  state : State.t;
}

type call_msg = |
type call_reply = |

type voice_state = {
  guild_id : string;
  channel_id : string option;
  self_mute : bool;
  self_deaf : bool;
}

type cast_msg =
  [ `VoiceStateUpdate of voice_state
  | `WSText of string
  | `WSClose of int
  | `Timeout of [ `Heartbeat ] ]

type state = {
  consumer : consumer_cast_msg Gen_server.caster;
  ws_conn : Ws.conn;
  heartbeat_interval : float option;
  st : State.t;
  config : Config.t;
}
[@@deriving make]

let send_json conn json =
  let content = Yojson.Safe.to_string json in
  Logs.info (fun m -> m "Sending: %s" content);
  Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

let send_heartbeat st conn =
  let open Event in
  Heartbeat (Some (State.s st)) |> to_yojson |> send_json conn

let extract_sequence_number src =
  let open Yojson.Safe.Util in
  src |> member "s" |> to_int_option

class t =
  object (self)
    inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t

    method connect_ws env ~sw =
      let endpoint = "https://gateway.discord.gg/?v=10&encoding=json" in
      let conn = Ws.connect ~sw env endpoint in
      Gen_server.start_ws_receiving ~sw conn self;
      conn

    method private init env ~sw { consumer; config; state = st } =
      let ws_conn = self#connect_ws env ~sw in
      make_state ~consumer ~ws_conn ~config ~st ()

    method! private terminate _ ~sw:_ _state = ()

    method handle_event env ~sw state =
      let open Event in
      function
      | Hello { heartbeat_interval } ->
          let interval = float_of_int heartbeat_interval /. 1000.0 in
          if Option.is_none state.heartbeat_interval then
            Gen_server.start_timeout (Eio.Stdenv.clock env) ~sw interval
              `Heartbeat self;

          Identify
            {
              token = Config.token state.config;
              intents = Config.intents state.config;
              properties =
                `Assoc
                  [
                    ("os", `String "linux");
                    ("browser", `String "yomer");
                    ("device", `String "yomer");
                  ];
            }
          |> to_yojson |> send_json state.ws_conn;

          { state with heartbeat_interval = Some interval }
      | HeartbeatAck ->
          (* FIXME: check if HeartbeatAck is correctly received *)
          Logs.info (fun m -> m "Heartbeat acked");
          state
      | Heartbeat _ ->
          Heartbeat (Some (State.s state.st))
          |> to_yojson |> send_json state.ws_conn;
          state
      | Dispatch
          (VOICE_STATE_UPDATE
            { guild_id = Some guild_id; user_id; session_id; channel_id }) ->
          let self_user_id = State.me state.st |> Option.get in
          (if user_id = self_user_id.User.id then
             let g = State.guild_data state.st guild_id |> Option.get in
             let vgw = Option.get g.voice |> snd in
             Voice_gateway.attach_voice_state ~user_id ~session_id vgw);

          State.update_guild_data state.st guild_id (fun data ->
              (* Update data.voice_states *)
              {
                data with
                voice_states =
                  data.voice_states
                  |> StringMap.add user_id
                       (Voice_state.make ~guild_id:data.guild_id ?channel_id
                          ~user_id ());
              });

          state
      | Dispatch (VOICE_SERVER_UPDATE { token; guild_id; endpoint }) ->
          let g = State.guild_data state.st guild_id |> Option.get in
          let vgw = Option.get g.voice |> snd in
          Voice_gateway.attach_voice_server ~token ~endpoint vgw;
          state
      | Dispatch (READY { user; _ }) ->
          State.set_me state.st (Some user);
          state
      | Dispatch (GUILD_CREATE json) -> (
          match Guild.of_yojson json with
          | exception _ -> state
          | g ->
              State.update_guild_data state.st g.id (fun data ->
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
              state)
      | Dispatch _ | VoiceStateUpdate _ -> state
      | VoiceReady _ | Identify _ -> failwith "Unexpected event"

    method! private handle_cast env ~sw state =
      function
      | `VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf } ->
          Event.VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf }
          |> Event.to_yojson |> send_json state.ws_conn;
          `NoReply state
      | `Timeout `Heartbeat ->
          let clock = Eio.Stdenv.clock env in
          send_heartbeat state.st state.ws_conn;
          Gen_server.start_timeout clock ~sw
            (Option.get state.heartbeat_interval)
            `Heartbeat self;
          `NoReply state
      | `WSText content -> (
          try
            let json = Yojson.Safe.from_string content in
            (match extract_sequence_number json with
            | Some s -> State.set_s state.st s
            | None -> ());
            let ev = Event.of_yojson json in
            let state = self#handle_event env ~sw state ev in
            state.consumer#cast ev;
            `NoReply state
          with e ->
            Logs.err (fun m ->
                m "Handling event failed: %s: %s" (Printexc.to_string e) content);
            `NoReply state)
      | `WSClose 4015 ->
          Logs.info (fun m ->
              m "Discord voice server crashed. Trying to resume.");
          (* FIXME *)
          `Stop
      | `WSClose _ -> `Stop
  end

let spawn config env sw state consumer_mailbox =
  let t = new t in
  Gen_server.start t env ~sw
    {
      config;
      state;
      consumer =
        object
          method cast e = Mailbox.send consumer_mailbox e
        end;
    };
  t

let send_voice_state_update ~guild_id ?channel_id ~self_mute ~self_deaf t =
  t#cast @@ `VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf }
