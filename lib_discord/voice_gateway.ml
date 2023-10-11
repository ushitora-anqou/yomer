let encryption_mode = "xsalsa20_poly1305"

type consumer_cast_msg = Event.t

type init_arg = {
  guild_id : string;
  consumer : consumer_cast_msg Gen_server.process;
}

type call_msg = |
type call_reply = |
type voice_state = { user_id : string; session_id : string }
type voice_server = { token : string; endpoint : string }

type cast_msg =
  [ `VoiceState of voice_state
  | `VoiceServer of voice_server
  | `Timeout of [ `Heartbeat ]
  | `FrameSource of Eio.Flow.source
  | Ws.Process.msg ]

type process_status = WaitingParameters | Running

type state = {
  guild_id : string;
  consumer : consumer_cast_msg Gen_server.process;
  udp_stream : Voice_udp_stream.t;
  voice_state : voice_state option;
  voice_server : voice_server option;
  status : process_status; [@default WaitingParameters]
  ws_conn : Ws.conn option;
  heartbeat_interval : float option;
}
[@@deriving make]

type Gen_server.stop_reason += Restart

let send_json conn json =
  let content = Yojson.Safe.to_string json in
  Logs.info (fun m -> m "Sending: %s" content);
  Ws.write conn Websocket.Frame.(create ~opcode:Opcode.Text ~content ())

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

let send_heartbeat clock conn =
  let nonce = Eio.Time.now clock |> int_of_float in
  Voice_event.(Heartbeat nonce |> to_yojson) |> send_json conn;
  Logs.info (fun m -> m "Voice Heartbeat sent")

class t =
  object (self)
    inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t

    method private init _env ~sw:_ { guild_id; consumer } =
      let udp_stream = Voice_udp_stream.create () in
      make_state ~guild_id ~consumer ~udp_stream ()

    method! private terminate _ ~sw:_ state _reason =
      Voice_udp_stream.close state.udp_stream;
      ()

    method connect_ws env ~sw state =
      let endpoint = (Option.get state.voice_server).endpoint in
      let conn =
        Ws.connect ~sw env ("https://" ^ endpoint ^ "/?v=4&encoding=json")
      in
      Ws.Process.start ~sw conn self;
      conn

    method start_running env ~sw state =
      let token = (Option.get state.voice_server).token in
      let user_id = (Option.get state.voice_state).user_id in
      let session_id = (Option.get state.voice_state).session_id in

      let conn = self#connect_ws env ~sw state in

      Voice_event.(
        Identify { server_id = state.guild_id; user_id; session_id; token }
        |> to_yojson)
      |> send_json conn;

      { state with status = Running; ws_conn = Some conn }

    method start_running_if_ready env ~sw state =
      if
        Option.is_some state.voice_server
        && Option.is_some state.voice_state
        && state.status = WaitingParameters
      then self#start_running env ~sw state
      else state

    method handle_voice_event env ~sw state =
      function
      | Voice_event.Hello { heartbeat_interval } ->
          let interval = heartbeat_interval /. 1000.0 in
          if Option.is_none state.heartbeat_interval then
            Timeout.Process.start (Eio.Stdenv.clock env) ~sw interval `Heartbeat
              self;
          { state with heartbeat_interval = Some interval }
      | Resumed | HeartbeatAck _ -> state
      | Ready { ip; port; ssrc; modes; _ } ->
          let ws_conn = Option.get state.ws_conn in
          Voice_udp_stream.connect env sw state.udp_stream
            { vgw_conn = ws_conn; ip; port; ssrc; modes };
          let my_addr, my_port =
            Voice_udp_stream.discover_ip state.udp_stream
          in
          send_select_protocol ws_conn my_addr my_port modes;
          state
      | SessionDescription { secret_key; _ } ->
          Voice_udp_stream.attach_secret_key state.udp_stream secret_key;
          state.consumer#cast (Event.VoiceReady { guild_id = state.guild_id });
          state
      | Identify _ | SelectProtocol _ | Speaking _ | Resume _ | Heartbeat _ ->
          failwith "Unexpected event"

    method! private handle_cast env ~sw state =
      function
      | `VoiceState x ->
          let state = { state with voice_state = Some x } in
          `NoReply (self#start_running_if_ready env ~sw state)
      | `VoiceServer x ->
          let state = { state with voice_server = Some x } in
          `NoReply (self#start_running_if_ready env ~sw state)
      | `Timeout `Heartbeat ->
          let clock = Eio.Stdenv.clock env in
          send_heartbeat clock (Option.get state.ws_conn);
          Timeout.Process.start clock ~sw
            (Option.get state.heartbeat_interval)
            `Heartbeat self;
          `NoReply state
      | `WSText content -> (
          try
            content |> Yojson.Safe.from_string |> Voice_event.of_yojson
            |> self#handle_voice_event env ~sw state
            |> fun state -> `NoReply state
          with e ->
            Logs.err (fun m ->
                m "Handling event failed (voice): %s: %s" (Printexc.to_string e)
                  content);
            `NoReply state)
      | `WSClose (`Status_code 4015) ->
          Logs.info (fun m ->
              m "Discord voice server crashed. Trying to resume.");
          let ws_conn = self#connect_ws env ~sw state in
          let server_id = state.guild_id in
          let token = (Option.get state.voice_server).token in
          let session_id = (Option.get state.voice_state).session_id in
          Voice_event.(Resume { server_id; session_id; token } |> to_yojson)
          |> send_json ws_conn;
          `NoReply { state with ws_conn = Some ws_conn }
      | `WSClose reason ->
          Logs.info (fun m -> m "Voice gateway WS connection closed");
          `Stop
            ( (if reason = `Status_code 4014 then Gen_server.Normal else Restart),
              state )
      | `FrameSource src ->
          Voice_udp_stream.send_frame_source state.udp_stream src;
          `NoReply state
  end

let create () = new t

let start t _config env sw consumer ~guild_id =
  Gen_server.start t env ~sw { guild_id; consumer }

let attach_voice_state ~user_id ~session_id t =
  t#cast (`VoiceState { user_id; session_id })

let attach_voice_server ~token ~endpoint t =
  t#cast (`VoiceServer { token; endpoint })

let send_frame_source t src = t#cast (`FrameSource src)
