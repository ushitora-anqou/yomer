[@@@warning "-32-69"]

let command_re = Regex.e {|^(\S+)(?:\s+(.*))?$|}

let parse_command s =
  let open Regex in
  s |> match_ command_re
  |> List.map (fun a ->
         (a.(1) |> Option.map substr, a.(2) |> Option.map substr))

let read_at_most src buf =
  let rec loop working_buf =
    match Eio.Flow.single_read src working_buf with
    | exception End_of_file -> `Last (Cstruct.sub buf 0 working_buf.off)
    | got ->
        let working_buf = Cstruct.shift working_buf got in
        if Cstruct.length working_buf = 0 then `Full else loop working_buf
  in
  loop buf

class frames_sink agent guild_id =
  object
    inherit Eio.Flow.sink

    method copy src =
      let open Discord in
      let buf =
        Cstruct.create (voice_frame_size * 2 * 2 * voice_num_burst_frames)
      in
      let rec loop () =
        let buf, is_last =
          match read_at_most src buf with
          | `Full -> (buf, false)
          | `Last buf -> (buf, true)
        in
        agent
        |> Agent.play_voice ~guild_id ~src:(`PCM_S16LE (Cstruct.to_string buf));
        if not is_last then loop ()
      in
      loop ()
  end

let spawn_youtubedl process_mgr ~sw ~stdout url =
  let executable =
    Sys.getenv_opt "YOUTUBEDL_PATH"
    |> Option.value ~default:"/usr/bin/youtube-dl"
  in
  Eio.Process.spawn ~sw process_mgr ~stdout ~executable
    [ executable; "-f"; "bestaudio"; "-o"; "-"; "-q"; "--no-warnings"; url ]

let spawn_ffmpeg process_mgr ~sw ~stdin ~stdout =
  let executable =
    Sys.getenv_opt "FFMPEG_PATH" |> Option.value ~default:"/usr/bin/ffmpeg"
  in
  Eio.Process.spawn ~sw process_mgr ~stdin ~stdout ~executable
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

let play_url env sw guild_id url agent =
  let process_mgr = Eio.Stdenv.process_mgr env in
  let src, sink = Eio.Process.pipe ~sw process_mgr in
  let final_sink = new frames_sink agent guild_id in
  let _p1 = spawn_youtubedl process_mgr ~sw ~stdout:sink url in
  let _p2 = spawn_ffmpeg process_mgr ~sw ~stdin:src ~stdout:final_sink in
  ()

let query_voice_provider env config text =
  Eio.Switch.run @@ fun sw ->
  let resp =
    Discord.Httpx.post env ~sw ~body:(`Fixed text)
      config.Discord.Config.voice_provider_endpoint
  in
  let status = fst resp |> Http.Response.status in
  if status |> Cohttp.Code.code_of_status |> Cohttp.Code.is_success then
    Cohttp_eio.Client.read_fixed resp
  else
    failwith
      (Printf.sprintf "Failed to get speech: %s"
         (Cohttp.Code.string_of_status status))

let start_speech env ~sw config ~text ~guild_id agent =
  let wav = query_voice_provider env config text in
  let src = Eio.Flow.string_source wav in
  let process_mgr = Eio.Stdenv.process_mgr env in
  let final_sink = new frames_sink agent guild_id in
  let _p = spawn_ffmpeg process_mgr ~sw ~stdin:src ~stdout:final_sink in
  ()

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
      | [ (Some "!play", Some url) ] ->
          Logs.info (fun m -> m "Playing %s" url);
          play_url env sw guild_id url agent;
          state
      | _ ->
          (try start_speech env ~sw config ~text:msg.content ~guild_id agent
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
  let voice_provider_endpoint = "http://localhost:8400" in
  let config = Discord.Config.make ~token ~intents ~voice_provider_endpoint in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw ->
  let _consumer =
    Discord.Consumer.start env ~sw config (fun () -> ()) (handle_event config)
  in
  ()
