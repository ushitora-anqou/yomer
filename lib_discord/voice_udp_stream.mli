type t

type connection_param = {
  vgw_conn : Ws.conn;
  ip : string;
  port : int;
  ssrc : int;
  modes : string list;
}

val frame_size : int
val num_burst_frames : int
val create : unit -> t

val connect :
  Eio_unix.Stdenv.base -> Eio.Switch.t -> t -> connection_param -> unit

val send_frame_source : t -> Eio.Flow.source -> unit
val attach_secret_key : t -> int list -> unit
val close : t -> unit
val discover_ip : t -> string * int
