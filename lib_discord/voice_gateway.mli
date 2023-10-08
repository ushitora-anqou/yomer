type t

val create : unit -> t

val start :
  t ->
  Config.t ->
  Eio_unix.Stdenv.base ->
  Eio.Switch.t ->
  Event.t Mailbox.t ->
  guild_id:string ->
  unit

val attach_voice_state : user_id:string -> session_id:string -> t -> unit
val attach_voice_server : token:string -> endpoint:string -> t -> unit
val send_frame : t -> string -> unit
