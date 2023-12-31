open Util

type provider =
  | Post of string
  (* `Post url` will send POST request to url *)
  | Su_shiki_com of string (* `Su_shiki_com query` will use su-shiki.com API *)
  | Voicevox of int (* `Voicevox style_id` will use Voicevox *)
[@@deriving show]

type voice = {
  name : string;
  provider : provider;
  available_for_all_users : bool;
}

type user = {
  id : string;
  additionally_available_voices : string list;
  can_use_debug_commands : bool;
}

type template_text_message = {
  summon : string;
  summon_but_already_joined : string;
  summon_not_from_vc : string;
  unsummon : string;
  unsummon_not_from_same_vc : string;
  unsummon_not_joined : string;
  help : string;
}

type template_voice_message = {
  i_joined : string;
  im_leaving : string;
  joined : string;
  left : string;
  started_live : string;
  stopped_live : string;
  created_thread : string;
  dummy : string;
  message_omitted : string;
}

type t = {
  discord_token : string;
  gateway_intents : int;
  announcer : string;
  ffmpeg_path : string;
  ffmpeg_options : string list;
  message_length_limit : int;
  ms_before_leave : int;
  prompt_regex : Pcre2.regexp;
  template_text_message : template_text_message;
  template_voice_message : template_voice_message;
  su_shiki_com_api_key : string option;
  voices : voice StringMap.t;
  voice_names : string array;
  users : user StringMap.t;
  voicevox_endpoint : string;
}

module P = struct
  include Yaml.Util

  let to_list_exn = function `A xs -> xs | _ -> failwith "invalid list"
  let to_map_exn = function `O xs -> xs | _ -> failwith "invalid map"

  let to_int_exn = function
    | `Float x -> int_of_float x
    | _ -> failwith "invalid int"

  let member name x = x |> find_exn name |> Option.get

  let member_opt name x =
    match x |> find name |> Result.to_option with
    | Some (Some x) -> Some x
    | _ -> None

  let to_voice_exn x =
    match to_list_exn x with
    | [ `String "post"; `String url ] -> Post url
    | [ `String "su_shiki_com"; `String q ] -> Su_shiki_com q
    | [ `String "voicevox"; `Float style_id ] ->
        Voicevox (int_of_float style_id)
    | _ -> failwith "invalid voice"

  let try_ name f =
    try f name
    with Value_error msg | Failure msg | Invalid_argument msg ->
      failwith (Printf.sprintf "config invalid: %s: %s" name msg)

  let try_string name root =
    try_ name @@ fun n -> root |> member n |> to_string_exn

  let try_int name root = try_ name @@ fun n -> root |> member n |> to_int_exn
end

let template_text_message_of_yojson root =
  let open P in
  let summon = root |> try_string "summon" in
  let summon_but_already_joined =
    root |> try_string "summon_but_already_joined"
  in
  let summon_not_from_vc = root |> try_string "summon_not_from_vc" in
  let unsummon = root |> try_string "unsummon" in
  let unsummon_not_from_same_vc =
    root |> try_string "unsummon_not_from_same_vc"
  in
  let unsummon_not_joined = root |> try_string "unsummon_not_joined" in
  let help = root |> try_string "help" in
  {
    summon;
    summon_but_already_joined;
    summon_not_from_vc;
    unsummon;
    unsummon_not_from_same_vc;
    unsummon_not_joined;
    help;
  }

let template_voice_message_of_yojson root =
  let open P in
  let i_joined = root |> try_string "i_joined" in
  let im_leaving = root |> try_string "im_leaving" in
  let joined = root |> try_string "joined" in
  let left = root |> try_string "left" in
  let started_live = root |> try_string "started_live" in
  let stopped_live = root |> try_string "stopped_live" in
  let created_thread = root |> try_string "created_thread" in
  let dummy = root |> try_string "dummy" in
  let message_omitted = root |> try_string "message_omitted" in
  {
    i_joined;
    im_leaving;
    joined;
    left;
    started_live;
    stopped_live;
    created_thread;
    dummy;
    message_omitted;
  }

let of_yaml root =
  let open P in
  try
    let discord_token = root |> try_string "discord_token" in
    let gateway_intents =
      try_ "gateway_intents" @@ fun n ->
      root |> member n |> to_list_exn |> List.map to_string_exn
      |> List.map Discord.Intent.of_string
      |> Discord.Intent.encode
    in
    let announcer = root |> try_string "announcer" in
    let ffmpeg_path = root |> try_string "ffmpeg_path" in
    let ffmpeg_options =
      try_ "ffmpeg_options" @@ fun n ->
      root |> member n |> to_list_exn |> List.map to_string_exn
    in
    let message_length_limit = root |> try_int "message_length_limit" in
    let ms_before_leave = root |> try_int "ms_before_leave" in
    let prompt_regex =
      try_ "prompt_regex" @@ fun n ->
      let re = root |> member n |> to_string_exn |> Pcre2.regexp in
      if Pcre2.capturecount re <> 1 then failwith "capture count should be 1";
      re
    in
    let template_text_message =
      try_ "template_text_message" @@ fun n ->
      root |> member n |> template_text_message_of_yojson
    in
    let template_voice_message =
      try_ "template_voice_message" @@ fun n ->
      root |> member n |> template_voice_message_of_yojson
    in
    let su_shiki_com_api_key =
      try_ "su_shiki_com_api_key" @@ fun n ->
      root |> member_opt n |> Option.map to_string_exn
      (* FIXME: validate su_shiki_com_api_key is set if necessary *)
    in
    let voices =
      try_ "voices" @@ fun n ->
      root |> member n |> to_map_exn
      |> List.map (fun (name, src) ->
             let provider = src |> member "provider" |> to_voice_exn in
             let available_for_all_users =
               src
               |> member_opt "available_for_all_users"
               |> Option.map to_bool_exn |> Option.value ~default:true
             in
             (name, { name; provider; available_for_all_users }))
      |> List.to_seq |> StringMap.of_seq
    in
    let voice_names =
      voices |> StringMap.to_rev_seq |> Seq.map fst |> Array.of_seq
    in
    let users =
      try_ "users" @@ fun n ->
      root |> member n |> to_map_exn
      |> List.map (fun (user_id, src) ->
             let can_use_debug_commands =
               src
               |> member_opt "can_use_debug_commands"
               |> Option.map to_bool_exn
               |> Option.value ~default:false
             in
             let additionally_available_voices =
               src
               |> member_opt "additionally_available_voices"
               |> Option.map to_list_exn
               |> Option.map (List.map to_string_exn)
               |> Option.value ~default:[]
             in
             ( user_id,
               {
                 id = user_id;
                 can_use_debug_commands;
                 additionally_available_voices;
               } ))
      |> List.to_seq |> StringMap.of_seq
    in
    let voicevox_endpoint = root |> try_string "voicevox_endpoint" in
    Ok
      {
        discord_token;
        gateway_intents;
        announcer;
        ffmpeg_path;
        ffmpeg_options;
        message_length_limit;
        ms_before_leave;
        prompt_regex;
        template_text_message;
        template_voice_message;
        su_shiki_com_api_key;
        voices;
        voice_names;
        users;
        voicevox_endpoint;
      }
  with Failure msg -> Error (`Msg msg)
