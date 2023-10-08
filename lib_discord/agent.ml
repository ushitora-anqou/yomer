open Util

type init_arg = { config : Config.t }
type call_msg = |
type call_reply = |
type cast_msg = Event.t

type 'user_state state = {
  config : Config.t;
  env : Eio_unix.Stdenv.base;
  st : State.t;
  gw : Gateway.t;
  sw : Eio.Switch.t;
  user_state : 'user_state;
}

class virtual ['user_state] t =
  object (self)
    inherit
      [init_arg, call_msg, call_reply, cast_msg, 'user_state state] Gen_server.t

    val mutable working_state : 'user_state state option = None
    method private virtual user_init : unit -> 'user_state

    method private init env ~sw { config } =
      let st = State.start env ~sw in
      let gw = Gateway.spawn config env sw st (self :> _ Gen_server.process) in
      let user_state = self#user_init () in
      { config; env; st; gw; sw; user_state }

    method private virtual handle_event
        : Eio_unix.Stdenv.base ->
          sw:Eio.Switch.t ->
          'user_state ->
          Event.t ->
          'user_state

    method! private handle_cast env ~sw state event =
      working_state <- Some { state with sw };
      let user_state =
        try self#handle_event env ~sw state.user_state event
        with e ->
          Logs.err (fun m ->
              m "User event consumer raised an exception: %s: %a"
                (Printexc.to_string e) Event.pp event);
          state.user_state
      in
      `NoReply { state with user_state }

    method join_channel ?(self_mute = false) ?(self_deaf = false) ~guild_id
        ~channel_id () =
      let { config; env; sw; st; gw; _ } = Option.get working_state in
      let vgw = Voice_gateway.create () in
      (match
         State.set_voice_if_not_exists st ~guild_id ~channel_id ~gateway:vgw
       with
      | false, _ -> ()
      | true, _ ->
          Voice_gateway.start vgw config env sw
            (self :> _ Gen_server.process)
            ~guild_id);
      Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute
        ~self_deaf gw

    method leave_channel ~guild_id =
      let { gw; st; _ } = Option.get working_state in
      Gateway.send_voice_state_update ~guild_id ~self_mute:false
        ~self_deaf:false gw;
      State.unset_voice st ~guild_id;
      ()

    method get_voice_states ~guild_id ~user_id =
      let { st; _ } = Option.get working_state in
      State.voice_states st ~guild_id ~user_id

    method play_voice : guild_id:string -> src:[> `PCM_S16LE of string ] -> unit
        =
      fun ~guild_id ~src ->
        let { st; _ } = Option.get working_state in
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
                       Voice_gateway.send_frame gateway frame))
  end
