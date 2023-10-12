open Util
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type dispatch_ready = {
  v : int;
  user : Object.user;
  guilds : json_any;
  session_id : string;
  resume_gateway_url : string;
  application : json_any;
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show]

type dispatch_voice_server_update = {
  token : string;
  guild_id : string;
  endpoint : string;
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show]

type dispatch_voice_state_update = {
  guild_id : string option;
  channel_id : string option;
  user_id : string;
  session_id : string;
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show]

type dispatch =
  | READY of dispatch_ready
  | GUILD_CREATE of json_any
  | MESSAGE_CREATE of Object.message
  | VOICE_STATE_UPDATE of dispatch_voice_state_update
  | VOICE_SERVER_UPDATE of dispatch_voice_server_update
[@@deriving yojson, show]

type t =
  | (* 0 *) Dispatch of dispatch
  | (* 1 *) Heartbeat of int option
  | (* 2 *) Identify of {
      token : string;
      properties : Yojson.Safe.t;
      intents : int;
    }
  | (* 4 *) VoiceStateUpdate of {
      guild_id : string;
      channel_id : string option;
      self_mute : bool;
      self_deaf : bool;
    }
  | (* 6 *) Resume of { token : string; session_id : string; seq : int }
  | (* 7 *) Reconnect
  | (* 9 *) InvalidSession of bool
  | (* 10 *) Hello of { heartbeat_interval : int }
  | (* 11 *) HeartbeatAck
  | (* custom *) VoiceReady of { guild_id : string }
  | (* custom *) VoiceSpeaking of { guild_id : string; speaking : bool }
[@@deriving show]

let of_yojson json =
  let open Yojson.Safe.Util in
  try
    let op = json |> member "op" |> to_int in
    match op with
    | 0 ->
        let t = json |> member "t" in
        let d = json |> member "d" in
        `List [ t; d ] |> dispatch_of_yojson |> fun x -> Dispatch x
    | 1 -> Heartbeat None
    | 7 -> Reconnect
    | 9 ->
        let d = json |> member "d" |> to_bool in
        InvalidSession d
    | 10 ->
        let d = json |> member "d" in
        let heartbeat_interval = d |> member "heartbeat_interval" |> to_int in
        Hello { heartbeat_interval }
    | 11 -> HeartbeatAck
    | _ -> failwith "Invalid op"
  with Type_error _ -> failwith "Invalid JSON for event"

let to_yojson = function
  | Heartbeat s ->
      `Assoc
        [
          ("op", `Int 1);
          ("d", s |> Option.fold ~none:`Null ~some:(fun s -> `Int s));
        ]
  | Identify { token; properties; intents } ->
      `Assoc
        [
          ("op", `Int 2);
          ( "d",
            `Assoc
              [
                ("token", `String token);
                ("properties", properties);
                ("intents", `Int intents);
              ] );
        ]
  | VoiceStateUpdate { guild_id; channel_id; self_mute; self_deaf } ->
      `Assoc
        [
          ("op", `Int 4);
          ( "d",
            `Assoc
              [
                ("guild_id", `String guild_id);
                ( "channel_id",
                  channel_id
                  |> Option.fold ~none:`Null ~some:(fun s -> `String s) );
                ("self_mute", `Bool self_mute);
                ("self_deaf", `Bool self_deaf);
              ] );
        ]
  | Resume { token; session_id; seq } ->
      `Assoc
        [
          ("op", `Int 6);
          ( "d",
            `Assoc
              [
                ("token", `String token);
                ("session_id", `String session_id);
                ("seq", `Int seq);
              ] );
        ]
  | _ -> failwith "Not implemeneted"
