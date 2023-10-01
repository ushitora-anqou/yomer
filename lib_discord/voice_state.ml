open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t = {
  guild_id : string option; [@yojson.option]
  channel_id : string option;
  user_id : string;
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

let of_yojson = t_of_yojson
