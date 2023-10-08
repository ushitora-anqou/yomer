open Util

type join_channel = {
  self_mute : bool;
  self_deaf : bool;
  guild_id : string;
  channel_id : string;
}

type leave_channel = { guild_id : string }
type play_voice = { guild_id : string; src : [ `PCM_S16LE of string ] }
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

    method private as_consumer =
      object
        method cast : Event.t -> unit = fun ev -> self#cast (`Event ev)
      end

    method private init env ~sw { config; consumer } =
      let st = State.start env ~sw in
      let gw = Gateway.spawn config env sw st self#as_consumer in
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
              Voice_gateway.start vgw config env sw self#as_consumer ~guild_id);
          Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute
            ~self_deaf gw;
          `NoReply state
      | `LeaveChannel { guild_id } ->
          Gateway.send_voice_state_update ~guild_id ~self_mute:false
            ~self_deaf:false gw;
          State.unset_voice st ~guild_id;
          `NoReply state
      | `PlayVoice { guild_id; src } -> (
          match State.voice st guild_id with
          | None -> failwith "VoiceGateway is not available"
          | Some { gateway; _ } -> (
              match src with
              | `PCM_S16LE data ->
                  let buf_len = Voice_udp_stream.frame_size * 2 * 2 in
                  let frames =
                    List.init
                      (String.length data / buf_len)
                      (fun i -> String.sub data (i * buf_len) buf_len)
                  in
                  frames
                  |> List.iter (fun frame ->
                         Voice_gateway.send_frame gateway frame);
                  `NoReply state))

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

let play_voice : guild_id:string -> src:[> `PCM_S16LE of string ] -> t -> unit =
 fun ~guild_id ~src agent ->
  Gen_server.cast agent (`PlayVoice { guild_id; src })
