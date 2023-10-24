[@@@warning "-32-69"]

module StringMap = Map.Make (String)

let command_re = Regex.e {|^(\S+)(?:\s+(.*))?$|}

let parse_command s =
  let open Regex in
  s |> match_ command_re
  |> List.map (fun a ->
         (a.(1) |> Option.map substr, a.(2) |> Option.map substr))

type state = { guilds : Guild.t StringMap.t }

let get_guild guild_id state = StringMap.find_opt guild_id state.guilds

let handle_event config (env : Eio_unix.Stdenv.base) ~sw agent state = function
  | Discord.Event.Dispatch (READY _) -> state
  | Dispatch (MESSAGE_CREATE msg) -> (
      let guild_id = Option.get msg.guild_id in

      (* Ensure guild exists *)
      let guild, state =
        match StringMap.find_opt guild_id state.guilds with
        | Some guild -> (guild, state)
        | None ->
            let guild = Guild.create () in
            guild |> Guild.start env ~sw ~guild_id ~agent ~config;
            (guild, { guilds = state.guilds |> StringMap.add guild_id guild })
      in

      match parse_command msg.content with
      | [ (Some "!ping", None) ] ->
          Logs.info (fun m -> m "Received ping");
          guild |> Guild.ping msg.channel_id;
          state
      | [ (Some "!join", None) ] ->
          guild |> Guild.join_by_message msg;
          state
      | [ (Some "!leave", None) ] ->
          guild |> Guild.leave_by_message msg;
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

let () =
  Logg.setup ();

  let token =
    match Sys.getenv_opt "DISCORD_TOKEN" with
    | Some s -> s
    | None -> failwith "DISCORD_TOKEN not set"
  in
  let intents =
    Discord.Intent.encode
      [ GUILDS; GUILD_VOICE_STATES; GUILD_MESSAGES; MESSAGE_CONTENT ]
  in
  let config = Discord.Config.make ~token ~intents in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let _consumer =
    Discord.Consumer.start env ~sw config
      (fun () -> { guilds = StringMap.empty })
      (handle_event config)
  in
  ()
