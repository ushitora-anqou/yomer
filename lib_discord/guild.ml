open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t = {
  id : string;
  voice_states : Voice_state.t list option; [@yojson.option]
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show]

let of_yojson = t_of_yojson
