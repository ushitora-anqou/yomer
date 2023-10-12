type 'user_state user_handler =
  Eio_unix.Stdenv.base ->
  sw:Eio.Switch.t ->
  Agent.t ->
  'user_state ->
  Event.t ->
  'user_state

type 'user_state init_arg = {
  config : Config.t;
  user_init : unit -> 'user_state;
  user_handler : 'user_state user_handler;
}

type call_msg = |
type call_reply = |
type cast_msg = Event.t

type 'user_state state = {
  agent : Agent.t;
  user_state : 'user_state;
  user_handler : 'user_state user_handler;
}

class ['user_state] t =
  object (self)
    inherit
      ['user_state init_arg, call_msg, call_reply, cast_msg, 'user_state state] Gen_server
                                                                                .t

    method private init env ~sw { config; user_init; user_handler } =
      let agent = new Agent.t in
      Gen_server.start agent env ~sw
        { config; consumer = (self :> _ Gen_server.process) };
      let user_state = user_init () in
      { agent; user_state; user_handler }

    method! private handle_cast env ~sw state event =
      let user_state =
        try state.user_handler env ~sw state.agent state.user_state event
        with e ->
          Logs.err (fun m ->
              m "User consumer failed: %s\n%s" (Printexc.to_string e)
                (Printexc.get_backtrace ()));
          state.user_state
      in
      `NoReply { state with user_state }
  end

let start env ~sw config user_init user_handler =
  let t = new t in
  Gen_server.start t env ~sw { config; user_init; user_handler };
  t
