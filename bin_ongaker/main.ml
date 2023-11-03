[@@@warning "-32-69"]

let command_re = Regex.e {|^(\S+)(?:\s+(.*))?$|}

let parse_command s =
  let open Regex in
  s |> match_ command_re
  |> List.map (fun a ->
         (a.(1) |> Option.map substr, a.(2) |> Option.map substr))

let handle_event token (env : Eio_unix.Stdenv.base) ~sw agent state = function
  | Discord.Event.Dispatch (READY _) -> state
  | Dispatch (MESSAGE_CREATE msg) -> (
      let guild_id = Option.get msg.guild_id in
      match parse_command msg.content with
      | [ (Some "!ping", None) ] ->
          Logs.info (fun m -> m "ping");
          if
            Discord.Rest.make_create_message_param
              ~embeds:[ Discord.Object.make_embed ~description:"pong" () ]
              ()
            |> Discord.Rest.create_message env ~token msg.channel_id
            |> Result.is_error
          then Logs.err (fun m -> m "Failed to send pong");
          state
      | [ (Some "!join", None) ] ->
          (match
             agent
             |> Discord.Agent.get_voice_states ~guild_id ~user_id:msg.author.id
           with
          | None -> ()
          | Some vstate -> (
              match vstate.Discord.Event.channel_id with
              | None -> ()
              | Some channel_id ->
                  agent |> Discord.Agent.join_channel ~guild_id ~channel_id));
          state
      | [ (Some "!leave", None) ] ->
          agent |> Discord.Agent.leave_channel ~guild_id;
          state
      | [ (Some "!play", Some url) ] ->
          Logs.info (fun m -> m "Playing %s" url);
          agent
          |> Discord.Agent.play_voice
               (Eio.Stdenv.process_mgr env)
               ~sw ~guild_id ~src:(`Ytdl url);
          state
      | _ -> state)
  | VoiceReady { guild_id; _ } ->
      Logs.info (fun m -> m "Voice ready for guild %s" guild_id);
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

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let _consumer : _ Discord.Consumer.t =
    Discord.Consumer.start env ~sw ~token ~intents
      (fun () -> ())
      (handle_event token)
  in
  ()
