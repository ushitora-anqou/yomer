[@@@warning "-32-69"]

class frames_sink agent guild_id =
  object
    inherit Eio.Flow.sink

    method copy src =
      let rec loop () =
        let buf = Cstruct.create (Discord.voice_frame_size * 2 * 2 * 10) in
        Eio.Flow.read_exact src buf;
        agent
        |> Discord.Agent.play_voice ~guild_id
             ~src:(`PCM_S16LE (Cstruct.to_string buf));
        loop ()
      in
      try loop () with End_of_file -> ()
  end

let command_re = Regex.e {|^(\S+)(?:\s+(.*))?$|}

let parse_command s =
  let open Regex in
  s |> match_ command_re
  |> List.map (fun a ->
         (a.(1) |> Option.map substr, a.(2) |> Option.map substr))

let make_noise env sw guild_id url agent =
  let process_mgr = Eio.Stdenv.process_mgr env in
  let src, sink = Eio.Process.pipe ~sw process_mgr in
  let final_sink = new frames_sink agent guild_id in
  let _p1 =
    let executable =
      Sys.getenv_opt "YOUTUBEDL_PATH"
      |> Option.value ~default:"/usr/bin/youtube-dl"
    in
    Eio.Process.spawn ~sw process_mgr ~stdout:sink ~executable
      [ executable; "-f"; "bestaudio"; "-o"; "-"; "-q"; "--no-warnings"; url ]
  in
  let _p2 =
    let executable =
      Sys.getenv_opt "FFMPEG_PATH" |> Option.value ~default:"/usr/bin/ffmpeg"
    in
    Eio.Process.spawn ~sw process_mgr ~stdin:src ~stdout:final_sink ~executable
      [
        executable;
        "-i";
        "pipe:0";
        "-ac";
        "2";
        "-ar";
        "48000";
        "-f";
        "s16le";
        "-loglevel";
        "quiet";
        "pipe:1";
      ]
  in
  ()

let handle_event env ~sw agent state = function
  | Discord.Event.Dispatch (READY _) -> state
  | Dispatch (MESSAGE_CREATE msg) -> (
      let guild_id = msg.guild_id in
      match parse_command msg.content with
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
      | [ (Some "!play", Some url) ] ->
          Logs.info (fun m -> m "Playing %s" url);
          make_noise env sw guild_id url agent;
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
  let config = Discord.Config.make ~token ~intents in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let _consumer =
    Discord.Consumer.start env ~sw config (fun () -> ()) handle_event
  in
  ()
