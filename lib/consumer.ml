open Util

let parse_command command_re s =
  let open Regex in
  s |> match_ command_re |> List.map (fun a -> a.(1) |> Option.map substr)

type state = { guilds : Guild.t StringMap.t }

let get_guild guild_id state = StringMap.find_opt guild_id state.guilds

let ensure_guild_exists env ~sw ~config ~guild_id ~state ~agent =
  match StringMap.find_opt guild_id state.guilds with
  | Some guild -> (guild, state)
  | None ->
      let guild = Guild.create () in
      guild |> Guild.start env ~sw ~guild_id ~agent ~config;
      (guild, { guilds = state.guilds |> StringMap.add guild_id guild })

let handle_event ~(config : Config.t) (env : Eio_unix.Stdenv.base) ~sw agent
    state = function
  | Discord.Event.Dispatch (READY _) -> state
  | Dispatch (GUILD_CREATE { voice_states = Some vstates; id = guild_id; _ })
    -> (
      (* Join the channel if we're already in it *)
      let self_user_id = (Option.get (Discord.Agent.me agent)).id in
      match
        vstates
        |> List.find_opt
             (fun (vstate : Discord.Event.dispatch_voice_state_update) ->
               vstate.user_id = self_user_id)
      with
      | Some
          {
            channel_id = Some channel_id;
            self_mute = Some self_mute;
            self_deaf = Some self_deaf;
            _;
          } ->
          let _, state =
            ensure_guild_exists env ~sw ~config ~guild_id ~state ~agent
          in
          agent
          |> Discord.Agent.join_channel ~self_mute ~self_deaf ~guild_id
               ~channel_id;
          state
      | _ -> state)
  | Dispatch (MESSAGE_CREATE msg)
    when msg.content <> "" && msg.author.bot <> Some true -> (
      let guild_id = Option.get msg.guild_id in
      let can_use_debug_command =
        config.users
        |> StringMap.find_opt msg.author.id
        |> Option.fold ~none:false ~some:(fun (u : Config.user) ->
               u.can_use_debug_commands)
      in

      let guild, state =
        ensure_guild_exists env ~sw ~config ~guild_id ~state ~agent
      in

      match parse_command config.prompt_regex msg.content with
      | [ Some "ping" ] ->
          Logs.info (fun m -> m "Received ping");
          guild |> Guild.ping msg.channel_id;
          state
      | [ Some "help" ] ->
          let description =
            Jingoo.Jg_template.from_string config.template_text_message.help
              ~models:
                [
                  ("version", Tstr Build_info.version);
                  ("revision", Tstr Build_info.revision);
                ]
          in
          Discord.(
            Rest.(
              create_message env ~token:config.discord_token msg.channel_id
                (make_create_message_param
                   ~embeds:[ Entity.make_embed ~description () ]
                   ())))
          |> ignore;
          state
      | [ Some "join" ] ->
          guild |> Guild.join_by_message msg;
          state
      | [ Some "leave" ] ->
          guild |> Guild.leave_by_message msg;
          state
      | [ Some "debug__resume" ] when can_use_debug_command ->
          agent |> Discord.Agent.force_resume;
          state
      | _ ->
          guild |> Guild.cast_message msg;
          state)
  | Dispatch (VOICE_STATE_UPDATE payload) ->
      (let ( let* ) x y = Option.iter y x in
       let* guild_id = payload.guild_id in
       let* guild = get_guild guild_id state in
       Guild.cast_voice_state_update payload guild);
      state
  | Dispatch (THREAD_CREATE payload) ->
      (let ( let* ) x y = Option.iter y x in
       let* guild_id = payload.guild_id in
       let* guild = get_guild guild_id state in
       Guild.cast_thread_create payload guild);
      state
  | VoiceReady { guild_id; _ } ->
      Logs.info (fun m -> m "Voice ready for guild %s" guild_id);
      (match StringMap.find_opt guild_id state.guilds with
      | None -> ()
      | Some guild -> guild |> Guild.cast_voice_ready);
      state
  | VoiceSpeaking { guild_id; speaking; _ } ->
      (match StringMap.find_opt guild_id state.guilds with
      | None -> ()
      | Some guild -> guild |> Guild.cast_voice_speaking speaking);
      state
  | _ -> state

let start env ~sw ~(config : Config.t) =
  let _consumer : _ Discord.Consumer.t =
    Discord.Consumer.start env ~sw ~token:config.discord_token
      ~intents:config.gateway_intents ~ffmpeg_path:config.ffmpeg_path
      ~ffmpeg_options:config.ffmpeg_options
      (fun () -> { guilds = StringMap.empty })
      (handle_event ~config)
  in
  ()
