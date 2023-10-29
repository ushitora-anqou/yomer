open Util

type normal_message = [ `Bare of string | `Discord of Discord.Object.message ]
type message = [ normal_message | `ScheduledLeave ]

type init_arg = {
  guild_id : string;
  agent : Discord.Agent.t;
  config : Config.t;
}

type call_msg = |
type call_reply = |

type cast_msg =
  [ `JoinByMessage of Discord.Object.message
  | `LeaveByMessage of Discord.Object.message
  | `MessageArrived of message
  | `VoiceReady
  | `VoiceSpeaking of bool
  | `Ping of string (* channel_id *)
  | `VoiceStateUpdateArrived of Discord.Event.dispatch_voice_state_update ]

type basic_msg = (call_msg, call_reply, cast_msg) Actaa.Gen_server.basic_msg
type msg = basic_msg
type speaking_status = NotReady | Ready | Speaking

type state = {
  config : Config.t;
  guild_id : string;
  agent : Discord.Agent.t;
  msg_queue : message Queue.t;
  speaking_status : speaking_status;
  voice_states : Discord.Event.dispatch_voice_state_update StringMap.t;
      (* user_id -> voice_state *)
}

type Actaa.Process.Stop_reason.t += Restart

let query_voice_provider env ~config ~provider ~text =
  match provider with
  | Config.Post endpoint ->
      Eio.Switch.run @@ fun sw ->
      let resp = Discord.Httpx.post env ~sw ~body:(`Fixed text) endpoint in
      let status = fst resp |> Http.Response.status in
      if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
        Discord.Httpx.drain_resp_body resp
      else
        failwith
          (Printf.sprintf "Failed to get speech: %s"
             (Cohttp.Code.string_of_status status))
  | Config.Su_shiki_com query ->
      let key =
        match config.Config.su_shiki_com_api_key with
        | None -> failwith "su_shiki_com_api_key is not set"
        | Some key -> key
      in
      Eio.Switch.run @@ fun sw ->
      let endpoint = "https://api.su-shiki.com/v2/voicevox/audio/?" ^ query in
      let body =
        Uri.encoded_of_query [ ("text", [ text ]); ("key", [ key ]) ]
      in
      let resp =
        Discord.Httpx.post env ~sw
          ~headers:[ ("content-type", "application/x-www-form-urlencoded") ]
          ~body:(`Fixed body) endpoint
      in
      let status = fst resp |> Http.Response.status in
      if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
        Discord.Httpx.drain_resp_body resp
      else
        failwith
          (Printf.sprintf "Failed to get speech: %s"
             (Cohttp.Code.string_of_status status))

let format_discord_message (msg : Discord.Object.message) =
  (* Concat dummy to content if there are attachments *)
  let content =
    match msg.attachments with
    | None | Some [] -> msg.content
    | _ -> Message_san.dummy_text ^ msg.content
  in

  (* Concat sticker names to content *)
  let content =
    msg.sticker_items |> Option.value ~default:[]
    |> List.fold_left
         (fun content (sticker : Discord.Object.sticker_item) ->
           content ^ " " ^ sticker.name)
         content
  in

  content

let start_speaking env ~sw ~token state msg =
  let guild_id = state.guild_id in

  let content =
    match msg with
    | `Bare content -> content
    | `Discord msg ->
        let content = format_discord_message msg in
        content
  in
  let content = Message_san.sanitize env ~token ~guild_id ~text:content in
  if content = "" then failwith "sanitized message is empty";

  let provider =
    match msg with
    | `Bare _ -> state.config.announcer
    | `Discord (msg : Discord.Object.message) -> (
        let id_to_role =
          Discord.Rest.get_guild_roles env ~token ~guild_id
          |> Result.get_ok
          |> List.map (fun (r : Discord.Object.role) -> (r.id, r))
          |> List.to_seq |> StringMap.of_seq
        in
        let member =
          Discord.Rest.get_guild_member env ~token ~user_id:msg.author.id
            ~guild_id
          |> Result.get_ok
        in
        match
          member.roles
          |> List.find_map (fun (role_id : string) ->
                 let r = id_to_role |> StringMap.find role_id in
                 state.config.role_to_voice
                 |> Array.find_map (fun (r' : Config.role_voice) ->
                        if r.name = r'.role then Some r'.voice else None))
        with
        | Some voice -> voice
        | None ->
            (* The author doesn't have any role for voice, so select one based on their id *)
            let num_roles = Array.length state.config.role_to_voice in
            let index = int_of_string msg.author.id mod num_roles in
            state.config.role_to_voice.(index).voice)
  in

  Logs.info (fun m ->
      m "Speaking: %s: %s: %s" guild_id (Config.show_voice provider) content);
  let wav =
    query_voice_provider env ~config:state.config ~provider ~text:content
  in
  let src = Eio.Flow.string_source wav in
  state.agent
  |> Discord.Agent.play_voice
       (Eio.Stdenv.process_mgr env)
       ~sw ~guild_id ~src:(`Pipe src)

let rec consume_message env ~sw state =
  match Queue.take_opt state.msg_queue with
  | None -> { state with speaking_status = Ready }
  | Some `ScheduledLeave ->
      state.agent |> Discord.Agent.leave_channel ~guild_id:state.guild_id;
      { state with speaking_status = NotReady; msg_queue = Queue.create () }
  | Some (#normal_message as msg) -> (
      try
        start_speaking env ~sw ~token:state.config.discord_token state msg;
        { state with speaking_status = Speaking }
      with e ->
        Logs.err (fun m ->
            m "Failed to start speech: %s\n%s" (Printexc.to_string e)
              (Printexc.get_backtrace ()));
        consume_message env ~sw state)

let enqueue_message env ~sw state msg =
  match (state.speaking_status, msg) with
  | NotReady, `Bare _ ->
      (* Enqueue only bare messages if status is not ready
         in order to speak out the welcome message *)
      Queue.push msg state.msg_queue;
      state
  | NotReady, _ -> state
  | Ready, _ ->
      Queue.push msg state.msg_queue;
      consume_message env ~sw state
  | Speaking, _ ->
      Queue.push msg state.msg_queue;
      state

let get_activity state (payload : Discord.Event.dispatch_voice_state_update) =
  let ( let* ) = Option.bind in
  let p = StringMap.find_opt payload.user_id state.voice_states in
  let c = payload in
  let* me = Discord.Agent.me state.agent in
  let my_user_id = me.id in
  let ch =
    let* vstate =
      state.agent
      |> Discord.Agent.get_voice_states ~guild_id:state.guild_id
           ~user_id:my_user_id
    in
    vstate.channel_id
  in

  let joining_any_channel =
    c.channel_id <> None
    && (p = None || (Option.get p).channel_id <> c.channel_id)
  in
  let joining = joining_any_channel && c.channel_id = ch in
  let leaving =
    p <> None && ch <> None
    && (Option.get p).channel_id <> c.channel_id
    && (Option.get p).channel_id = ch
  in
  let is_my_activity = payload.user_id = my_user_id in
  let i'm_joining = is_my_activity && joining in
  let i'm_leaving = is_my_activity && (leaving || ch = None) in

  let start_streaming =
    c.channel_id = ch && p <> None
    && ((Option.get p).self_stream = None
       || (Option.get p).self_stream = Some false)
    && c.self_stream = Some true
  in
  let stop_streaming =
    c.channel_id = ch && p <> None
    && (Option.get p).self_stream = Some true
    && (c.self_stream = None || c.self_stream = Some false)
  in

  if i'm_joining then Some `I'm_joining
  else if i'm_leaving then Some `I'm_leaving
  else if joining then Some `Someone's_joining
  else if leaving then Some `Someone's_leaving
  else if start_streaming then Some `Someone's_starting_streaming
  else if stop_streaming then Some `Someone's_stopping_streaming
  else if joining_any_channel then Some `Someone's_joining_any_channel
  else None

let update_voice_state state
    (payload : Discord.Event.dispatch_voice_state_update) =
  {
    state with
    voice_states = state.voice_states |> StringMap.add payload.user_id payload;
  }

let get_display_name : Discord.Object.guild_member -> string option = function
  | { nick = Some nick; _ } -> Some nick
  | { user = Some { username; _ }; _ } -> Some username
  | _ -> None

let get_voice_channel_from_user_id ~guild_id ~user_id agent =
  Option.bind
    (agent |> Discord.Agent.get_voice_states ~guild_id ~user_id)
    (fun x -> x.channel_id)

let send_message env ~token ~channel_id ~content =
  Discord.Rest.make_create_message_param
    ~embeds:[ Discord.Object.make_embed ~description:content () ]
    ()
  |> Discord.Rest.create_message env ~token channel_id

class t =
  object (self)
    inherit [init_arg, msg, state] Actaa.Gen_server.behaviour

    method private init _env ~sw:_ { guild_id; agent; config; _ } =
      let voice_states = Discord.Agent.get_all_voice_states agent ~guild_id in
      {
        config;
        guild_id;
        agent;
        msg_queue = Queue.create ();
        speaking_status = NotReady;
        voice_states;
      }

    method private handle_activity env ~sw state
        (member : Discord.Object.guild_member) activity =
      let react tmpl =
        let state =
          member |> get_display_name
          |> Option.fold ~none:state ~some:(fun display_name ->
                 let models =
                   [ ("user_name", Jingoo.Jg_types.Tstr display_name) ]
                 in
                 let msg = Jingoo.Jg_template.from_string ~models tmpl in
                 enqueue_message env ~sw state (`Bare msg))
        in
        `NoReply state
      in
      let tmpl = state.config.template_voice_message in
      match activity with
      | `I'm_joining -> react tmpl.i_joined
      | `Someone's_joining -> react tmpl.joined
      | `Someone's_leaving -> react tmpl.left
      | `Someone's_starting_streaming -> react tmpl.started_live
      | `Someone's_stopping_streaming -> react tmpl.stopped_live
      | `I'm_leaving | `Someone's_joining_any_channel -> `NoReply state

    method private handle_status env ~sw state
        : speaking_status * cast_msg -> state Actaa.Gen_server.cast_result =
      function
      (*
       * status = NotReady
       *)
      | NotReady, `MessageArrived (`Bare _ as msg) ->
          (* Enqueue only bare messages to speak out the welcome message *)
          let state = enqueue_message env ~sw state msg in
          `NoReply state
      | NotReady, `MessageArrived _ -> (* Just ignore *) `NoReply state
      | NotReady, `VoiceReady ->
          let state = consume_message env ~sw state in
          `NoReply state
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
          let state = enqueue_message env ~sw state msg in
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
          let state = enqueue_message env ~sw state msg in
          `NoReply state
      | Speaking, `VoiceSpeaking false ->
          let state = consume_message env ~sw state in
          `NoReply state
      (*
       * misc
       *)
      | _, `VoiceStateUpdateArrived payload -> (
          let activity = get_activity state payload in
          let state = update_voice_state state payload in
          match (activity, payload.member) with
          | None, _ | _, None -> `NoReply state
          | Some activity, Some member ->
              self#handle_activity env ~sw state member activity)
      | _, (`JoinByMessage _ | `LeaveByMessage _ | `Ping _) ->
          failwith "invalid state"

    method! private handle_cast env ~sw state msg =
      let { agent; guild_id; speaking_status; config; _ } = state in
      let token = config.discord_token in
      let ( >>= ) = Option.bind in
      let ( let* ) = ( >>= ) in
      match msg with
      | `JoinByMessage msg -> (
          match
            agent
            |> Discord.Agent.get_voice_states ~guild_id ~user_id:msg.author.id
            >>= fun vstate -> vstate.channel_id
          with
          | None ->
              send_message env ~token ~channel_id:msg.channel_id
                ~content:config.template_text_message.summon_not_from_vc
              |> ignore;
              `NoReply state
          | Some channel_id ->
              agent |> Discord.Agent.join_channel ~guild_id ~channel_id;
              `NoReply state)
      | `LeaveByMessage msg ->
          let user_vc_id =
            agent
            |> get_voice_channel_from_user_id ~guild_id ~user_id:msg.author.id
          in
          let my_vc_id =
            let* user = Discord.Agent.me agent in
            let* vstate =
              agent |> Discord.Agent.get_voice_states ~guild_id ~user_id:user.id
            in
            vstate.channel_id
          in
          if user_vc_id = my_vc_id then
            let state =
              enqueue_message env ~sw state
                (`Bare config.template_voice_message.im_leaving)
            in
            let state = enqueue_message env ~sw state `ScheduledLeave in
            `NoReply state
          else (
            send_message env ~token ~channel_id:msg.channel_id
              ~content:config.template_text_message.unsummon_not_from_same_vc
            |> ignore;
            `NoReply state)
      | `Ping channel_id ->
          if
            Discord.Rest.make_create_message_param
              ~embeds:[ Discord.Object.make_embed ~description:"pong" () ]
              ()
            |> Discord.Rest.create_message env ~token channel_id
            |> Result.is_error
          then Logs.err (fun m -> m "Failed to send pong");
          `NoReply state
      | _ -> self#handle_status env ~sw state (speaking_status, msg)
  end

let create () = new t

let start env ~sw ~guild_id ~agent ~config (t : t) =
  Actaa.Gen_server.start env ~sw { guild_id; agent; config } t

let join_by_message msg t = Actaa.Gen_server.cast t (`JoinByMessage msg)
let leave_by_message msg t = Actaa.Gen_server.cast t (`LeaveByMessage msg)

let cast_message msg t =
  Actaa.Gen_server.cast t (`MessageArrived (`Discord msg))

let cast_voice_ready t = Actaa.Gen_server.cast t `VoiceReady

let cast_voice_speaking speaking t =
  Actaa.Gen_server.cast t (`VoiceSpeaking speaking)

let ping channel_id t = Actaa.Gen_server.cast t (`Ping channel_id)

let cast_voice_state_update payload t =
  Actaa.Gen_server.cast t (`VoiceStateUpdateArrived payload)
