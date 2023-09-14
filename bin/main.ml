[@@@warning "-27-32"]

type state = { mutable voice_ready : bool } [@@deriving make]

let make_noise env guild_id agent =
  let path =
    let ( / ) = Eio.Path.( / ) in
    Eio.Stdenv.cwd env / "misc" / "test.s16le"
  in
  let src =
    Eio.Path.with_open_in path (fun flow ->
        Eio.Buf_read.(parse ~max_size:max_int take_all flow) |> Result.get_ok)
  in
  Discord.Agent.play_voice ~guild_id ~src:(`PCM_S16LE src) agent

let consume_event env state agent = function
  | Discord.Event.Dispatch (READY _) -> ()
  | Dispatch (MESSAGE_CREATE msg) -> (
      if String.contains msg.content '!' then
        let guild_id = msg.guild_id in
        let m = Discord.Agent.get_voice_states ~guild_id agent in
        match Discord.StringMap.find_opt Discord.Message.(msg.author.id) m with
        | None -> ()
        | Some vstate -> (
            match vstate.channel_id with
            | None -> ()
            | Some channel_id -> (
                match msg.content with
                | "!join" ->
                    Discord.Agent.join_channel ~guild_id ~channel_id agent
                | "!leave" -> Discord.Agent.leave_channel ~guild_id agent
                | "!play" when state.voice_ready ->
                    make_noise env guild_id agent
                | _ -> ())))
  | VoiceReady { guild_id; _ } ->
      Logs.info (fun m -> m "Voice ready for guild %s" guild_id);
      state.voice_ready <- true;
      (*
      Eio.Fiber.fork ~sw:agent.sw (fun () ->
          let rec loop i =
            Logs.info (fun m -> m "Loop: %d" i);
            make_noise env guild_id agent;
            Eio.Time.sleep (Eio.Stdenv.clock env) 10.0;
            loop (i + 1)
          in
          loop 0);
          *)
      ()
  | _ -> ()
[@@warning "-11"]

let () =
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_level (Some Logs.Info);

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
  Discord.Agent.start ~env ~config
    (consume_event env (make_state ~voice_ready:false));
  ()
