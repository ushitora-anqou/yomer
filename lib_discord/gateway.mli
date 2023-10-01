type t

val spawn :
  Config.t ->
  Eio_unix.Stdenv.base ->
  Eio.Switch.t ->
  State.t ->
  Event.t Mailbox.t ->
  t

val send_voice_state_update :
  guild_id:string ->
  ?channel_id:string ->
  self_mute:bool ->
  self_deaf:bool ->
  t ->
  unit
