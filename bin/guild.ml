module Gen_server = Discord.Gen_server

type message = [ `Bare of string | `Discord of Discord.Object.message ]

type init_arg = {
  guild_id : string;
  agent : Discord.Agent.t;
  config : Discord.Config.t;
}

type call_msg = |
type call_reply = |

type cast_msg =
  [ `JoinByMessage of Discord.Object.message
  | `LeaveByMessage of Discord.Object.message
  | `MessageArrived of message
  | `VoiceReady
  | `VoiceSpeaking of bool
  | `Ping of string (* channel_id *) ]

type speaking_status = NotReady | Ready | Speaking

type state = {
  config : Discord.Config.t;
  guild_id : string;
  agent : Discord.Agent.t;
  msg_queue : message Queue.t;
  speaking_status : speaking_status;
}

type Discord.Gen_server.stop_reason += Restart

let voice_provider_endpoint = "http://localhost:8400"

let query_voice_provider env text =
  Eio.Switch.run @@ fun sw ->
  let resp =
    Discord.Httpx.post env ~sw ~body:(`Fixed text) voice_provider_endpoint
  in
  let status = fst resp |> Http.Response.status in
  if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
    Cohttp_eio.Client.read_fixed resp
  else
    failwith
      (Printf.sprintf "Failed to get speech: %s"
         (Cohttp.Code.string_of_status status))

let enqueue_message state msg =
  let { msg_queue; _ } = state in
  Queue.push msg msg_queue

let format_discord_message (msg : Discord.Object.message) =
  let dummy = "ちくわ大明神。" in

  (* Concat dummy to content if there are attachments *)
  let content =
    match msg.attachments with
    | None | Some [] -> msg.content
    | _ -> dummy ^ msg.content
  in

  (* Concat sticker names to content *)
  let content =
    msg.sticker_items |> Option.value ~default:[]
    |> List.fold_left
         (fun content (sticker : Discord.Object.sticker_item) ->
           content ^ " " ^ sticker.name)
         content
  in

  (content, msg.author.id)

let start_speaking env config ~sw state msg =
  let content, _user_id =
    match msg with
    | `Bare content -> (content, None)
    | `Discord msg ->
        let content, user_id = format_discord_message msg in
        (content, Some user_id)
  in
  let content =
    Message_san.sanitize env config ~guild_id:state.guild_id ~text:content
  in

  let wav = query_voice_provider env content in
  let src = Eio.Flow.string_source wav in
  state.agent
  |> Discord.Agent.play_voice
       (Eio.Stdenv.process_mgr env)
       ~sw ~guild_id:state.guild_id ~src:(`Pipe src)

let rec consume_message env config ~sw state =
  match Queue.take_opt state.msg_queue with
  | None -> { state with speaking_status = Ready }
  | Some msg -> (
      try
        start_speaking env config ~sw state msg;
        { state with speaking_status = Speaking }
      with e ->
        Logs.err (fun m ->
            m "Failed to start speech: %s\n%s" (Printexc.to_string e)
              (Printexc.get_backtrace ()));
        consume_message env config ~sw state)

class t =
  object (self)
    inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t

    method private init _env ~sw:_ { guild_id; agent; config } =
      {
        config;
        guild_id;
        agent;
        msg_queue = Queue.create ();
        speaking_status = NotReady;
      }

    method private handle_status env ~sw state
        : speaking_status * cast_msg -> state Gen_server.cast_result =
      function
      (*
       * status = NotReady
       *)
      | NotReady, `MessageArrived (`Bare _ as msg) ->
          (* Enqueue only bare messages to speak out the welcome message *)
          enqueue_message state msg;
          `NoReply state
      | NotReady, `MessageArrived _ -> (* Just ignore *) `NoReply state
      | NotReady, `VoiceReady -> `NoReply { state with speaking_status = Ready }
      | NotReady, `VoiceSpeaking _ ->
          (* invalid state *)
          Logs.warn (fun m ->
              m
                "invalid state detected: not ready but received VoiceSpeaking: \
                 %s"
                state.guild_id);
          `NoReply state
      (*
       * status = Ready
       *)
      | Ready, `VoiceReady -> (* Just ignore *) `NoReply state
      | Ready, `MessageArrived msg ->
          enqueue_message state msg;
          let state = consume_message env state.config ~sw state in
          `NoReply state
      | Ready, `VoiceSpeaking _ ->
          (* invalid state *)
          Logs.warn (fun m ->
              m "invalid state detected: ready but received VoiceSpeaking: %s"
                state.guild_id);
          `NoReply state
      (*
       * status = Speaking
       *)
      | Speaking, `VoiceReady | Speaking, `VoiceSpeaking true ->
          (* Just ignore *) `NoReply state
      | Speaking, `MessageArrived msg ->
          enqueue_message state msg;
          `NoReply state
      | Speaking, `VoiceSpeaking false ->
          let state = consume_message env state.config ~sw state in
          `NoReply state
      (*
       * misc
       *)
      | _, (`JoinByMessage _ | `LeaveByMessage _ | `Ping _) ->
          failwith "invalid state"

    method! private handle_cast env ~sw state msg =
      let { agent; guild_id; speaking_status; _ } = state in
      match msg with
      | `JoinByMessage msg ->
          let ( >>= ) = Option.bind in
          agent
          |> Discord.Agent.get_voice_states ~guild_id ~user_id:msg.author.id
          >>= (fun vstate -> vstate.Discord.Voice_state.channel_id)
          |> Option.iter (fun channel_id ->
                 agent |> Discord.Agent.join_channel ~guild_id ~channel_id);
          `NoReply state
      | `LeaveByMessage _msg ->
          agent |> Discord.Agent.leave_channel ~guild_id;
          `NoReply state
      | `Ping channel_id ->
          if
            Discord.Rest.make_create_message_param
              ~embeds:[ Discord.Object.make_embed ~description:"pong" () ]
              ()
            |> Discord.Rest.create_message env state.config channel_id
            |> Result.is_error
          then Logs.err (fun m -> m "Failed to send pong");
          `NoReply state
      | _ -> self#handle_status env ~sw state (speaking_status, msg)
  end

let create () = new t

let start env ~sw ~guild_id ~agent ~config (t : t) =
  t#start env ~sw { guild_id; agent; config }

let join_by_message msg t = t#cast (`JoinByMessage msg)
let leave_by_message msg t = t#cast (`LeaveByMessage msg)
let cast_message msg t = t#cast (`MessageArrived (`Discord msg))
let cast_voice_ready t = t#cast `VoiceReady
let cast_voice_speaking speaking t = t#cast (`VoiceSpeaking speaking)
let ping channel_id t = t#cast (`Ping channel_id)
