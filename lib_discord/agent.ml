type join_channel = {
  self_mute : bool;
  self_deaf : bool;
  guild_id : string;
  channel_id : string;
}

type leave_channel = { guild_id : string }

type play_voice = {
  guild_id : string;
  src : [ `FrameSource of Eio.Flow.source ];
}

type get_voice_states = { guild_id : string; user_id : string }
type init_arg = { config : Config.t; consumer : Event.t Gen_server.process }
type call_msg = [ `GetVoiceStates of get_voice_states ]
type call_reply = [ `GetVoiceStates of Voice_state.t option ]

type cast_msg =
  [ `Event of Event.t
  | `JoinChannel of join_channel
  | `LeaveChannel of leave_channel
  | `PlayVoice of play_voice ]

type state = {
  config : Config.t;
  st : State.t;
  gw : Gateway.t;
  consumer : Event.t Gen_server.process;
}

class t =
  object (self)
    inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t

    method private init env ~sw { config; consumer } =
      let st = State.start env ~sw in
      let gw =
        Gateway.spawn config env sw st
          (self :> Gateway.consumer_cast_msg Gen_server.process)
      in
      { config; st; gw; consumer }

    method! private handle_cast env ~sw ({ config; st; gw; consumer } as state)
        =
      function
      | `Event ev ->
          consumer#cast ev;
          `NoReply state
      | `JoinChannel { self_mute; self_deaf; guild_id; channel_id } ->
          let vgw = Voice_gateway.create () in
          (match
             State.set_voice_if_not_exists st ~guild_id ~channel_id ~gateway:vgw
           with
          | false, _ -> ()
          | true, _ ->
              Voice_gateway.start vgw config env sw
                (self :> Gateway.consumer_cast_msg Gen_server.process)
                ~guild_id);
          Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute
            ~self_deaf gw;
          `NoReply state
      | `LeaveChannel { guild_id } ->
          Gateway.send_voice_state_update ~guild_id ~self_mute:false
            ~self_deaf:false gw;
          State.unset_voice st ~guild_id;
          `NoReply state
      | `PlayVoice { guild_id; src } ->
          (match State.voice st guild_id with
          | None -> Logs.warn (fun m -> m "VoiceGateway is not available")
          | Some { gateway; _ } -> (
              match src with
              | `FrameSource src -> Voice_gateway.send_frame_source gateway src));
          `NoReply state

    method! private handle_call _env ~sw:_ state =
      function
      | `GetVoiceStates { guild_id; user_id } ->
          `Reply
            ( `GetVoiceStates (State.voice_states state.st ~guild_id ~user_id),
              state )
  end

let join_channel ?(self_mute = false) ?(self_deaf = false) ~guild_id ~channel_id
    agent =
  Gen_server.cast agent
    (`JoinChannel { guild_id; channel_id; self_mute; self_deaf })

let leave_channel ~guild_id agent =
  Gen_server.cast agent (`LeaveChannel { guild_id })

let get_voice_states ~guild_id ~user_id agent =
  match Gen_server.call agent (`GetVoiceStates { guild_id; user_id }) with
  | `GetVoiceStates v -> v

let spawn_youtubedl process_mgr ~sw ~stdout url =
  let executable =
    Sys.getenv_opt "YOUTUBEDL_PATH"
    |> Option.value ~default:"/usr/bin/youtube-dl"
  in
  Eio.Process.spawn ~sw process_mgr ~stdout ~executable
    [ executable; "-f"; "bestaudio"; "-o"; "-"; "-q"; "--no-warnings"; url ]

let spawn_ffmpeg process_mgr ~sw ~stdin ~stdout =
  let executable =
    Sys.getenv_opt "FFMPEG_PATH" |> Option.value ~default:"/usr/bin/ffmpeg"
  in
  Eio.Process.spawn ~sw process_mgr ~stdin ~stdout ~executable
    [
      executable;
      "-i";
      "pipe:0";
      "-ac";
      "2";
      "-ar";
      "48000";
      "-f";
      "s16le";
      "-loglevel";
      "quiet";
      "pipe:1";
    ]

let play_voice process_mgr ~sw ~guild_id ~src agent =
  let play src =
    let src', sink' = Eio.Process.pipe ~sw process_mgr in
    let _p = spawn_ffmpeg process_mgr ~sw ~stdin:src ~stdout:sink' in
    Eio.Flow.close sink';
    Gen_server.cast agent
      (`PlayVoice { guild_id; src = `FrameSource (src' :> Eio.Flow.source) })
  in
  match src with
  | `Pipe (src : Eio.Flow.source) -> play src
  | `Ytdl url ->
      let src, sink = Eio.Process.pipe ~sw process_mgr in
      let _p1 = spawn_youtubedl process_mgr ~sw ~stdout:sink url in
      play src;
      Eio.Flow.close src;
      Eio.Flow.close sink
