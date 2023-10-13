type t
type consumer_cast_msg = [ `Event of Event.t ]

val spawn :
  Config.t ->
  Eio_unix.Stdenv.base ->
  Eio.Switch.t ->
  State.t ->
  consumer_cast_msg Gen_server.process ->
  t

val send_voice_state_update :
  guild_id:string ->
  ?channel_id:string ->
  self_mute:bool ->
  self_deaf:bool ->
  t ->
  unit
