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
  let consumer_mailbox = Mailbox.create () in
  Eio.Switch.run @@ fun sw ->
  let state = State.start env ~sw in
  let gw = Gateway.spawn config env sw state consumer_mailbox in
  consumer env config sw state gw user_handler consumer_mailbox;
  ()

let join_channel ?(self_mute = false) ?(self_deaf = false) ~guild_id ~channel_id
    (a : t) =
  let vgw = Voice_gateway.create () in
  (match
     State.set_voice_if_not_exists a.state ~guild_id ~channel_id ~gateway:vgw
   with
  | false, _ -> ()
  | true, _ ->
      Voice_gateway.start vgw a.config a.env a.sw a.consumer_mailbox ~guild_id);

  Gateway.send_voice_state_update ~guild_id ~channel_id ~self_mute ~self_deaf
    a.gw

let leave_channel ~guild_id (a : t) =
  Gateway.send_voice_state_update ~guild_id ~self_mute:false ~self_deaf:false
    a.gw;
  State.unset_voice a.state ~guild_id;
  ()

let get_voice_states ~guild_id ~user_id (a : t) =
  State.voice_states a.state ~guild_id ~user_id

let play_voice ~guild_id ~src (a : t) =
  match State.voice a.state guild_id with
  | None -> failwith "VoiceGateway is not available"
  | Some { gateway; _ } -> (
      match src with
      | `PCM_S16LE data ->
          let buf_len = Voice_udp_stream.frame_size * 2 * 2 in
          let frames =
            List.init
              (String.length data / buf_len)
              (fun i -> String.sub data (i * buf_len) buf_len)
          in
          frames
          |> List.iter (fun frame -> Voice_gateway.send_frame gateway frame))
