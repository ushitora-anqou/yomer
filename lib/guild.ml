open Util

type normal_message = [ `Bare of string | `Discord of Discord.Entity.message ]

type message =
  [ normal_message | `Wait of float (* seconds *) | `ScheduledLeave ]

type init_arg = {
  guild_id : string;
  agent : Discord.Agent.t;
  rest : Discord.Rest.t;
  config : Config.t;
  voice_states : Discord.Event.dispatch_voice_state_update StringMap.t;
}

type call_msg = |
type call_reply = |

type cast_msg =
  [ `JoinByMessage of Discord.Entity.message
  | `LeaveByMessage of Discord.Entity.message
  | `MessageArrived of message
  | `VoiceReady
  | `VoiceSpeaking of bool
  | `Ping of string (* channel_id *)
  | `VoiceStateUpdateArrived of Discord.Event.dispatch_voice_state_update
  | `ThreadCreate of Discord.Entity.channel ]

type basic_msg = (call_msg, call_reply, cast_msg) Actaa.Gen_server.basic_msg
type msg = [ basic_msg | `Timeout of [ `Leave of string | `Wait ] ]
type speaking_status = NotReady | Ready | Speaking | Waiting

type state = {
  config : Config.t;
  guild_id : string;
  agent : Discord.Agent.t;
  rest : Discord.Rest.t;
  msg_queue : message Fqueue.t;
  speaking_status : speaking_status;
  voice_states : Discord.Event.dispatch_voice_state_update StringMap.t;
  (* user_id -> voice_state *)
  leave_timer_id : string option;
}

type Actaa.Process.Stop_reason.t += Restart

let genid () = Random.bits () |> string_of_int

let get_my_vc_id state =
  let ( let* ) = Option.bind in
  let* user = Discord.Agent.me state.agent in
  let* vstate = StringMap.find_opt user.id state.voice_states in
  vstate.channel_id

let get_num_of_non_bots_in_my_vc state =
  match get_my_vc_id state with
  | None -> failwith "not in any vc"
  | Some vchannel_id ->
      let aux _ (vstate : Discord.Event.dispatch_voice_state_update) num =
        let ( let* ) = Option.bind in
        if vstate.channel_id <> Some vchannel_id then num
        else
          let is_bot =
            match
              let* member = vstate.member in
              let* user = member.user in
              let* bot = user.bot in
              Some bot
            with
            | Some bot -> bot
            | None ->
                let user =
                  Discord.Rest.get_user ~user_id:vstate.user_id state.rest
                  |> Result.get_ok
                in
                Option.value ~default:false user.bot
          in
          if is_bot then num else num + 1
      in
      StringMap.fold aux state.voice_states 0

let query_voice_provider env ~config ~provider ~text =
  match provider with
  | Config.Post endpoint ->
      Eio.Switch.run @@ fun sw ->
      let resp = Httpx.Http.post env ~sw ~body:(`Fixed text) endpoint in
      let status = fst resp |> Http.Response.status in
      if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
        Httpx.Http.drain_resp_body resp
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
        Httpx.Http.post env ~sw
          ~headers:[ ("content-type", "application/x-www-form-urlencoded") ]
          ~body:(`Fixed body) endpoint
      in
      let status = fst resp |> Http.Response.status in
      if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
        Httpx.Http.drain_resp_body resp
      else
        failwith
          (Printf.sprintf "Failed to get speech: %s"
             (Cohttp.Code.string_of_status status))
  | Config.Voicevox style_id ->
      Eio.Switch.run @@ fun sw ->
      let u =
        Uri.with_path (Uri.of_string config.voicevox_endpoint) "/audio_query"
      in
      let u =
        Uri.with_query u
          [ ("style_id", [ string_of_int style_id ]); ("text", [ text ]) ]
      in
      let resp =
        Httpx.Http.post env ~sw
          ~headers:[ ("content-type", "application/x-www-form-urlencoded") ]
          (Uri.to_string u)
      in
      if
        fst resp |> Http.Response.status |> Cohttp.Code.code_of_status
        |> Cohttp.Code.is_success |> not
      then failwith "query_voice_provider: Voicevox: Failed to get query.json";
      let query_json = Httpx.Http.drain_resp_body resp in

      let u =
        Uri.with_path (Uri.of_string config.voicevox_endpoint) "/synthesis"
      in
      let u = Uri.with_query u [ ("style_id", [ string_of_int style_id ]) ] in
      let resp =
        Httpx.Http.post env ~sw
          ~headers:[ ("content-type", "application/json") ]
          ~body:(`Fixed query_json) (Uri.to_string u)
      in
      if
        fst resp |> Http.Response.status |> Cohttp.Code.code_of_status
        |> Cohttp.Code.is_success |> not
      then failwith "query_voice_provider: Voicevox: Failed to get speech";
      Httpx.Http.drain_resp_body resp

let format_discord_message (config : Config.t) (msg : Discord.Entity.message) =
  (* Concat dummy to content if there are attachments *)
  let content =
    match msg.attachments with
    | None | Some [] -> msg.content
    | _ -> config.template_voice_message.dummy ^ msg.content
  in

  (* Concat sticker names to content *)
  let content =
    msg.sticker_items |> Option.value ~default:[]
    |> List.fold_left
         (fun content (sticker : Discord.Entity.sticker_item) ->
           content ^ " " ^ sticker.name)
         content
  in

  content

let start_speaking env ~sw:_ state msg =
  let guild_id = state.guild_id in
  let config = state.config in

  let content =
    match msg with
    | `Bare content -> content
    | `Discord msg ->
        let content = format_discord_message config msg in
        content
  in
  let content =
    Message_san.sanitize config ~rest:state.rest ~guild_id ~text:content
  in
  if content = "" then failwith "sanitized message is empty";

  let provider =
    match msg with
    | `Bare _ -> (StringMap.find config.announcer config.voices).provider
    | `Discord (msg : Discord.Entity.message) -> (
        let id_to_role =
          Discord.Rest.get_guild_roles ~guild_id state.rest
          |> Result.get_ok
          |> List.map (fun (r : Discord.Entity.role) -> (r.id, r))
          |> List.to_seq |> StringMap.of_seq
        in
        let member =
          Discord.Rest.get_guild_member ~user_id:msg.author.id ~guild_id
            state.rest
          |> Result.get_ok
        in
        let additionally_available_voices =
          config.users
          |> StringMap.find_opt msg.author.id
          |> Option.fold ~none:[] ~some:(fun (u : Config.user) ->
                 u.additionally_available_voices)
        in
        match
          member.roles
          |> List.find_map (fun (role_id : string) ->
                 let r = id_to_role |> StringMap.find role_id in
                 match config.voices |> StringMap.find_opt r.name with
                 | Some v
                   when v.available_for_all_users
                        || List.mem r.name additionally_available_voices ->
                     Some v.provider
                 | _ -> None)
        with
        | Some p -> p
        | None ->
            (* The author doesn't have any role for voice, so select one based on their id *)
            let num_roles = Array.length config.voice_names in
            let index = int_of_string msg.author.id mod num_roles in
            (StringMap.find config.voice_names.(index) config.voices).provider)
  in

  Logs.info (fun m ->
      m "Speaking: %s: %s: %s" guild_id (Config.show_provider provider) content);
  let wav =
    query_voice_provider env ~config:state.config ~provider ~text:content
  in
  let src = Eio.Flow.string_source wav in
  state.agent |> Discord.Agent.play_voice ~guild_id ~src:(`Pipe src)

let push_msg_queue msg state =
  { state with msg_queue = Fqueue.push state.msg_queue msg }

let take_msg_from_queue state =
  let elm, msg_queue = Fqueue.take_opt state.msg_queue in
  let state = { state with msg_queue } in
  (elm, state)

let get_activity state (payload : Discord.Event.dispatch_voice_state_update) =
  let ( let* ) = Option.bind in
  let p = StringMap.find_opt payload.user_id state.voice_states in
  let c = payload in
  let* me = Discord.Agent.me state.agent in
  let my_user_id = me.id in
  let ch =
    if payload.user_id = my_user_id then payload.channel_id
    else
      let* x = StringMap.find_opt my_user_id state.voice_states in
      x.channel_id
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

let get_display_name : Discord.Entity.guild_member -> string option = function
  | { nick = Some nick; _ } -> Some nick
  | { user = Some { global_name = Some global_name; _ }; _ } -> Some global_name
  | { user = Some { username; _ }; _ } -> Some username
  | _ -> None

let get_voice_channel_from_user_id ~user_id agent =
  Option.bind (StringMap.find_opt user_id agent.voice_states) (fun x ->
      x.channel_id)

let send_message _env channel_id state content =
  let open Jingoo.Jg_types in
  let description_src, models =
    match content with
    | `Summon channel_name ->
        ( state.config.template_text_message.summon,
          [ ("channel_name", Tstr channel_name) ] )
    | `Summon_not_from_vc ->
        (state.config.template_text_message.summon_not_from_vc, [])
    | `Summon_but_already_joined ->
        (state.config.template_text_message.summon_but_already_joined, [])
    | `Unsummon -> (state.config.template_text_message.unsummon, [])
    | `Unsummon_not_joined ->
        (state.config.template_text_message.unsummon_not_joined, [])
    | `Unsummon_not_from_same_vc ->
        (state.config.template_text_message.unsummon_not_from_same_vc, [])
  in
  let description = Jingoo.Jg_template.from_string ~models description_src in
  let (_ : _ result) =
    Discord.Rest.make_create_message_param
      ~embeds:[ Discord.Entity.make_embed ~description () ]
      ()
    |> Discord.Rest.create_message channel_id state.rest
  in
  ()

let reset_speaking_status state =
  { state with msg_queue = Fqueue.empty; speaking_status = NotReady }

let reset_leave_timer env ~sw state self =
  if get_num_of_non_bots_in_my_vc state <> 0 then
    { state with leave_timer_id = None }
  else (
    Logs.info (fun m -> m "No one is in the vc. Scheduling leave");
    let timer_id = genid () in
    let seconds = float_of_int state.config.ms_before_leave /. 1000.0 in
    Actaa.Timer.spawn env ~sw ~id:(`Leave timer_id) ~seconds
      ~target:(self :> _ Actaa.Timer.receiver)
    |> ignore;
    { state with leave_timer_id = Some timer_id })

class t =
  object (self)
    inherit [init_arg, msg, state] Actaa.Gen_server.behaviour

    method private init _env ~sw:_
        { guild_id; agent; rest; config; voice_states; _ } =
      {
        config;
        guild_id;
        agent;
        rest;
        msg_queue = Fqueue.empty;
        speaking_status = NotReady;
        voice_states;
        leave_timer_id = None;
      }

    method private consume_message env ~sw state =
      match take_msg_from_queue state with
      | None, state -> { state with speaking_status = Ready }
      | Some (`Wait seconds), state ->
          Actaa.Timer.spawn env ~sw ~id:`Wait ~seconds
            ~target:(self :> _ Actaa.Timer.receiver)
          |> ignore;
          { state with speaking_status = Waiting }
      | Some `ScheduledLeave, state ->
          state.agent |> Discord.Agent.leave_channel ~guild_id:state.guild_id;
          { state with speaking_status = NotReady; msg_queue = Fqueue.empty }
      | Some (#normal_message as msg), state -> (
          try
            if get_num_of_non_bots_in_my_vc state = 0 then
              { state with speaking_status = Ready; msg_queue = Fqueue.empty }
            else (
              start_speaking env ~sw state msg;
              { state with speaking_status = Speaking })
          with e ->
            Logs.err (fun m ->
                m "Failed to start speech: %s\n%s" (Printexc.to_string e)
                  (Printexc.get_backtrace ()));
            self#consume_message env ~sw state)

    method private enqueue_message env ~sw state msg =
      match (state.speaking_status, msg) with
      | NotReady, `Bare _ ->
          (* Enqueue only bare messages if status is not ready
             in order to speak out the welcome message *)
          push_msg_queue msg state
      | NotReady, _ -> state
      | Ready, _ ->
          let state = push_msg_queue msg state in
          self#consume_message env ~sw state
      | (Speaking | Waiting), _ -> push_msg_queue msg state

    method private handle_activity env ~sw state
        (member : Discord.Entity.guild_member) activity =
      let react tmpl state =
        let state =
          member |> get_display_name
          |> Option.fold ~none:state ~some:(fun display_name ->
                 let models =
                   [ ("user_name", Jingoo.Jg_types.Tstr display_name) ]
                 in
                 let msg = Jingoo.Jg_template.from_string ~models tmpl in
                 self#enqueue_message env ~sw state (`Bare msg))
        in
        `NoReply state
      in
      let tmpl = state.config.template_voice_message in
      match activity with
      | `I'm_joining ->
          let state = reset_speaking_status state in
          let state = reset_leave_timer env ~sw state self in
          react tmpl.i_joined state
      | `Someone's_joining ->
          let state = reset_leave_timer env ~sw state self in
          react tmpl.joined state
      | `Someone's_leaving ->
          let state = reset_leave_timer env ~sw state self in
          react tmpl.left state
      | `Someone's_starting_streaming -> react tmpl.started_live state
      | `Someone's_stopping_streaming -> react tmpl.stopped_live state
      | `I'm_leaving ->
          let state = reset_speaking_status state in
          `NoReply state
      | `Someone's_joining_any_channel -> `NoReply state

    method private handle_status env ~sw state
        : speaking_status * cast_msg -> state Actaa.Gen_server.cast_result =
      function
      (*
       * status = NotReady
       *)
      | NotReady, `MessageArrived (`Bare _ as msg) ->
          (* Enqueue only bare messages to speak out the welcome message *)
          let state = self#enqueue_message env ~sw state msg in
          `NoReply state
      | NotReady, (`MessageArrived _ | `ThreadCreate _) ->
          (* Just ignore *) `NoReply state
      | NotReady, `VoiceReady ->
          let state = self#consume_message env ~sw state in
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
          let state = self#enqueue_message env ~sw state msg in
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
          let state = self#enqueue_message env ~sw state msg in
          `NoReply state
      | Speaking, `VoiceSpeaking false ->
          let state = self#consume_message env ~sw state in
          `NoReply state
      (*
       * status = Waiting
       *)
      | Waiting, `VoiceReady | Waiting, `VoiceSpeaking _ ->
          (* Just ignore *) `NoReply state
      | Waiting, `MessageArrived msg ->
          let state = self#enqueue_message env ~sw state msg in
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
      | ( _,
          `ThreadCreate
            {
              name = Some thread_name;
              owner_id = Some user_id;
              guild_id = Some guild_id;
              _;
            } ) ->
          let state =
            match
              Discord.Rest.get_guild_member ~guild_id ~user_id state.rest
            with
            | Error _ -> state
            | Ok member -> (
                match get_display_name member with
                | None -> state
                | Some user_name ->
                    let msg =
                      Jingoo.Jg_template.from_string
                        ~models:
                          [
                            ("thread_name", Tstr thread_name);
                            ("user_name", Tstr user_name);
                          ]
                        state.config.template_voice_message.created_thread
                    in
                    self#enqueue_message env ~sw state (`Bare msg))
          in
          `NoReply state
      | _, `ThreadCreate _ -> `NoReply state
      | _, (`JoinByMessage _ | `LeaveByMessage _ | `Ping _) ->
          failwith "invalid state"

    method! private handle_cast env ~sw state msg =
      let { agent; guild_id; speaking_status; config; _ } = state in
      let ( >>= ) = Option.bind in
      match msg with
      | `JoinByMessage msg -> (
          match
            agent
            |> Discord.Agent.get_voice_states ~guild_id ~user_id:msg.author.id
            >>= fun vstate -> vstate.channel_id
          with
          | None ->
              send_message env msg.channel_id state `Summon_not_from_vc;
              `NoReply state
          | Some channel_id when get_my_vc_id state = Some channel_id ->
              send_message env msg.channel_id state `Summon_but_already_joined;
              `NoReply state
          | Some channel_id ->
              agent |> Discord.Agent.join_channel ~guild_id ~channel_id;

              Discord.Rest.get_channel ~channel_id state.rest
              |> Result.iter (fun (channel : Discord.Entity.channel) ->
                     channel.name
                     |> Option.iter (fun name ->
                            send_message env msg.channel_id state (`Summon name)));

              `NoReply state)
      | `LeaveByMessage msg -> (
          match get_my_vc_id state with
          | None ->
              send_message env msg.channel_id state `Unsummon_not_joined;
              `NoReply state
          | Some my_vc_id -> (
              match
                get_voice_channel_from_user_id ~user_id:msg.author.id state
              with
              | Some user_vc_id when user_vc_id = my_vc_id ->
                  let state =
                    self#enqueue_message env ~sw state
                      (`Bare config.template_voice_message.im_leaving)
                  in
                  let state = self#enqueue_message env ~sw state (`Wait 0.5) in
                  let state =
                    self#enqueue_message env ~sw state `ScheduledLeave
                  in
                  send_message env msg.channel_id state `Unsummon;
                  `NoReply state
              | _ ->
                  send_message env msg.channel_id state
                    `Unsummon_not_from_same_vc;
                  `NoReply state))
      | `Ping channel_id ->
          if
            Discord.Rest.make_create_message_param
              ~embeds:[ Discord.Entity.make_embed ~description:"pong" () ]
              ()
            |> Discord.Rest.create_message channel_id state.rest
            |> Result.is_error
          then Logs.err (fun m -> m "Failed to send pong");
          `NoReply state
      | _ -> self#handle_status env ~sw state (speaking_status, msg)

    method! private handle_info env ~sw state =
      function
      | #basic_msg -> assert false
      | `Timeout (`Leave timer_id) when state.leave_timer_id <> Some timer_id ->
          (* ignore *)
          `NoReply state
      | `Timeout (`Leave _) ->
          Logs.info (fun m -> m "Leave timeout reached");
          let state = self#enqueue_message env ~sw state `ScheduledLeave in
          `NoReply state
      | `Timeout `Wait ->
          Logs.info (fun m -> m "Wait timeout reached");
          let state = self#consume_message env ~sw state in
          `NoReply state
  end

let create () = new t

let start env ~sw ~guild_id ~agent ~rest ~config ~voice_states (t : t) =
  Actaa.Gen_server.start env ~sw
    { guild_id; agent; rest; config; voice_states }
    t

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

let cast_thread_create payload t =
  Actaa.Gen_server.cast t (`ThreadCreate payload)
