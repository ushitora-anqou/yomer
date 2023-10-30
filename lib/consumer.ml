open Util

let parse_command command_re s =
  let open Regex in
  s |> match_ command_re |> List.map (fun a -> a.(1) |> Option.map substr)

type state = { guilds : Guild.t StringMap.t }

let get_guild guild_id state = StringMap.find_opt guild_id state.guilds

let handle_event ~(config : Config.t) (env : Eio_unix.Stdenv.base) ~sw agent
    state = function
  | Discord.Event.Dispatch (READY _) -> state
  | Dispatch (MESSAGE_CREATE msg) -> (
      let guild_id = Option.get msg.guild_id in
      let can_use_debug_command =
        config.users
        |> StringMap.find_opt msg.author.id
        |> Option.fold ~none:false ~some:(fun (u : Config.user) ->
               u.can_use_debug_commands)
      in

      (* Ensure guild exists *)
      let guild, state =
        match StringMap.find_opt guild_id state.guilds with
        | Some guild -> (guild, state)
        | None ->
            let guild = Guild.create () in
            guild |> Guild.start env ~sw ~guild_id ~agent ~config;
            (guild, { guilds = state.guilds |> StringMap.add guild_id guild })
      in

      match parse_command config.prompt_regex msg.content with
      | [ Some "ping" ] ->
          Logs.info (fun m -> m "Received ping");
          guild |> Guild.ping msg.channel_id;
          state
      | [ Some "join" ] ->
          guild |> Guild.join_by_message msg;
          state
      | [ Some "leave" ] ->
          guild |> Guild.leave_by_message msg;
          state
      | [ Some "debug__reconnect" ] when can_use_debug_command ->
          agent |> Discord.Agent.force_reconnect;
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
      ~intents:config.gateway_intents
      (fun () -> { guilds = StringMap.empty })
      (handle_event ~config)
  in
  ()
