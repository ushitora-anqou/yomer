type vgw_cast_msg = [ `Speaking of int (* ssrc *) * bool (* speaking *) ]

type init_arg = {
  ip : string;
  port : int;
  ssrc : int;
  vgw : vgw_cast_msg Gen_server.caster;
}

type call_msg = [ `DiscoverIP ]
type call_reply = [ `DiscoverIP of string (* ip *) * int (* port *) ]

type cast_msg =
  [ `SecretKey of int list | `Frame of string | `Timeout of string ]

class type t = [init_arg, call_msg, call_reply, cast_msg] Gen_server.intf

type connection_param = {
  vgw_conn : Ws.conn;
  ip : string;
  port : int;
  ssrc : int;
  modes : string list;
}

val frame_size : int
val create : unit -> t

val connect :
  Eio_unix.Stdenv.base -> Eio.Switch.t -> t -> connection_param -> unit

val send_frame : t -> string -> unit
val attach_secret_key : t -> int list -> unit
val close : t -> unit
val discover_ip : t -> string * int
