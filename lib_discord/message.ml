open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t = {
  id : string;
  author : User.t;
  channel_id : string;
  content : string;
  timestamp : string;
  edited_timestamp : string option;
  tts : bool;
  mention_everyone : bool;
  pinned : bool;
  webhook_id : string option; [@yojson.option]
  type_ : int; [@key "type"]
  guild_id : string option; [@yojson.option]
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show]

let of_yojson = t_of_yojson
let to_yojson = yojson_of_t
