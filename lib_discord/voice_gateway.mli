type t
type consumer_cast_msg = [ `Event of Event.t ]
type consumer = consumer_cast_msg Actaa.Gen_server.t_cast

val create : unit -> t

val start :
  t ->
  Eio_unix.Stdenv.base ->
  Eio.Switch.t ->
  consumer ->
  guild_id:string ->
  unit

val attach_voice_state : user_id:string -> session_id:string -> t -> unit
val attach_voice_server : token:string -> endpoint:string -> t -> unit
val send_frame_source : t -> Eio.Flow.source -> unit
