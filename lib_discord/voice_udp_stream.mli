type t

type connection_param = {
  vgw_conn : Ws.conn;
  ip : string;
  port : int;
  ssrc : int;
  modes : string list;
}

val frame_size : int
val spawn : Config.t -> Eio_unix.Stdenv.base -> Eio.Switch.t -> t
val connect : t -> connection_param -> unit
val send_frame : t -> string -> unit
val attach_secret_key : t -> int list -> unit
val close : t -> unit
