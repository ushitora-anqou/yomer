[@@@warning "-32-69"]

let voice_provider_endpoint = "http://localhost:8400"
let command_re = Regex.e {|^(\S+)(?:\s+(.*))?$|}

let parse_command s =
  let open Regex in
  s |> match_ command_re
  |> List.map (fun a ->
         (a.(1) |> Option.map substr, a.(2) |> Option.map substr))

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

let handle_event config (env : Eio_unix.Stdenv.base) ~sw agent state = function
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
            |> Discord.Rest.create_message env config msg.channel_id
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
              match vstate.Discord.Voice_state.channel_id with
              | None -> ()
              | Some channel_id ->
                  agent |> Discord.Agent.join_channel ~guild_id ~channel_id));
          state
      | [ (Some "!leave", None) ] ->
          agent |> Discord.Agent.leave_channel ~guild_id;
          state
      | _ ->
          (try
             let wav = query_voice_provider env msg.content in
             let src = Eio.Flow.string_source wav in
             agent
             |> Discord.Agent.play_voice
                  (Eio.Stdenv.process_mgr env)
                  ~sw ~guild_id ~src:(`Pipe src)
           with e ->
             Logs.err (fun m ->
                 m "Failed to start speech: %s\n%s" (Printexc.to_string e)
                   (Printexc.get_backtrace ())));
          state)
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
  let config = Discord.Config.make ~token ~intents in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let _consumer =
    Discord.Consumer.start env ~sw config (fun () -> ()) (handle_event config)
  in
  ()
