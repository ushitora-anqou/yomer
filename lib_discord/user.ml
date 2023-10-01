open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t = { username : string; id : string }
[@@yojson.allow_extra_fields] [@@deriving yojson, show]
