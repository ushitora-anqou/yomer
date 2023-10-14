[@@@warning "-30"]

open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type user = { username : string; id : string }
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

type embed = { description : string option [@yojson.option] }
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

type attachment = { id : string }
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

type sticker_item = { id : string; name : string }
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]

type message = {
  id : string;
  author : user;
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
  embeds : embed list option; [@yojson.option]
  attachments : attachment list option; [@yojson.option]
  sticker_items : sticker_item list option; [@yojson.option]
}
[@@yojson.allow_extra_fields] [@@deriving yojson, show, make]
