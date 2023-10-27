type voice = Post of string (* url *)
type role_voice = { role : string; voice : voice }

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
}

type t = {
  discord_token : string;
  gateway_intents : int;
  announcer : voice;
  dummy_message : string;
  ffmpeg_path : string;
  ffmpeg_options : string list;
  message_length_limit : int;
  ms_before_leave : int;
  prompt_regex : Pcre2.regexp;
  role_to_voice : role_voice list;
  template_text_message : template_text_message;
  template_voice_message : template_voice_message;
}

module P = struct
  include Yaml.Util

  let to_list_exn = function `A xs -> xs | _ -> failwith "invalid list"
  let to_map_exn = function `O xs -> xs | _ -> failwith "invalid map"

  let to_int_exn = function
    | `Float x -> int_of_float x
    | _ -> failwith "invalid int"

  let member name x = x |> find_exn name |> Option.get

  let to_voice_exn x =
    match to_list_exn x with
    | [ `String "post"; `String url ] -> Post url
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
  {
    i_joined;
    im_leaving;
    joined;
    left;
    started_live;
    stopped_live;
    created_thread;
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
    let announcer =
      try_ "announcer" @@ fun n -> root |> member n |> to_voice_exn
    in
    let dummy_message = root |> try_string "dummy_message" in
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
    let role_to_voice =
      try_ "role_to_voice" @@ fun n ->
      root |> member n |> to_list_exn
      |> List.map (fun x ->
             let role = x |> member "role" |> to_string_exn in
             let voice = x |> member "voice" |> to_voice_exn in
             { role; voice })
    in
    let template_text_message =
      try_ "template_text_message" @@ fun n ->
      root |> member n |> template_text_message_of_yojson
    in
    let template_voice_message =
      try_ "template_voice_message" @@ fun n ->
      root |> member n |> template_voice_message_of_yojson
    in
    Ok
      {
        discord_token;
        gateway_intents;
        announcer;
        dummy_message;
        ffmpeg_path;
        ffmpeg_options;
        message_length_limit;
        ms_before_leave;
        prompt_regex;
        role_to_voice;
        template_text_message;
        template_voice_message;
      }
  with Failure msg -> Error (`Msg msg)
