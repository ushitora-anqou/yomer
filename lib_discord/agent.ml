open Util

type t = {
  config : Config.t;
  env : Eio_unix.Stdenv.base;
  state : State.t;
  sw : Eio.Switch.t;
  gw : Gateway.t;
  consumer_mailbox : Event.t Mailbox.t;
}

let consumer env config sw state gw user_handler mailbox : unit =
  let rec loop () =
    let event = Mailbox.receive mailbox in
    (try
       user_handler
         { config; gw; env; sw; state; consumer_mailbox = mailbox }
         event
     with e ->
       Logs.err (fun m ->
           m "User event consumer raised an exception: %s: %a"
             (Printexc.to_string e) Event.pp event));
    loop ()
  in
  loop ()

let start ~env ~config user_handler =
  let state = State.create () in
  let consumer_mailbox = Mailbox.create () in
  Eio.Switch.run @@ fun sw ->
  let gw = Gateway.spawn config env sw state consumer_mailbox in
  consumer env config sw state gw user_handler consumer_mailbox;
  ()

let join_channel ?(self_mute = false) ?(self_deaf = false) ~guild_id ~channel_id
    (a : t) =
  State.update_guild_data a.state guild_id (fun data ->
      match data.voice with
      | Some (channel_id', _) when channel_id = channel_id' -> data
      | _ ->
          let voice_gw =
            Voice_gateway.spawn a.config a.env a.sw a.consumer_mailbox ~guild_id
          in
          { data with voice = Some (channel_id, voice_gw) });
  Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute ~self_deaf
    a.gw

let leave_channel ~guild_id (a : t) =
  Gateway.send_voice_state_update ~guild_id ~self_mute:false ~self_deaf:false
    a.gw;
  State.update_guild_data a.state guild_id (fun data ->
      { data with voice = None })

let get_voice_states ~guild_id (a : t) =
  State.guild_data a.state guild_id
  |> Option.fold ~none:StringMap.empty ~some:(fun x -> x.State.voice_states)

let play_voice ~guild_id ~src (a : t) =
  let vgw =
    match State.guild_data a.state guild_id with
    | None -> failwith "Guild not found"
    | Some g -> (
        match g.voice with
        | None -> failwith "VoiceGateway is not available"
        | Some (_, vgw) -> vgw)
  in
  match src with
  | `PCM_S16LE data ->
      let buf_len = Voice_udp_stream.frame_size * 2 * 2 in
      let frames =
        List.init
          (String.length data / buf_len)
          (fun i -> String.sub data (i * buf_len) buf_len)
      in
      frames |> List.iter (fun frame -> Voice_gateway.send_frame vgw frame)
