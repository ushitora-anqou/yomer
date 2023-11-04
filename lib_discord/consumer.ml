type 'user_state user_handler =
  Eio_unix.Stdenv.base ->
  sw:Eio.Switch.t ->
  Agent.t ->
  'user_state ->
  Event.t ->
  'user_state

type 'user_state init_arg = {
  token : string;
  intents : int;
  user_init : unit -> 'user_state;
  user_handler : 'user_state user_handler;
  ffmpeg_path : string;
  ffmpeg_options : string list;
}

type call_msg = |
type call_reply = |
type cast_msg = Event.t
type basic_msg = (call_msg, call_reply, cast_msg) Actaa.Gen_server.basic_msg
type msg = basic_msg

type 'user_state state = {
  agent : Agent.t;
  user_state : 'user_state;
  user_handler : 'user_state user_handler;
}

class ['user_state] t =
  object (self)
    inherit
      ['user_state init_arg, msg, 'user_state state] Actaa.Gen_server.behaviour

    method private init env ~sw
        { token; intents; user_init; user_handler; ffmpeg_path; ffmpeg_options }
        =
      let agent = new Agent.t in
      agent
      |> Actaa.Gen_server.start env ~sw
           Agent.
             {
               token;
               intents;
               consumer = (self :> consumer);
               ffmpeg_path;
               ffmpeg_options;
             };
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

let start env ~sw ~token ~intents ~ffmpeg_path ~ffmpeg_options user_init
    user_handler =
  let t = new t in
  t
  |> Actaa.Gen_server.start env ~sw
       { token; intents; user_init; user_handler; ffmpeg_path; ffmpeg_options };
  t
