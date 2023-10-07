type conn

val connect :
  ?random_string:(int -> string) ->
  ?extra_headers:Cohttp.Header.t ->
  sw:Eio.Switch.t ->
  Eio_unix.Stdenv.base ->
  string ->
  conn

val read : conn -> Websocket.Frame.t
val write : conn -> Websocket.Frame.t -> unit

module Process : sig
  type msg =
    [ `WSText of string | `WSClose of [ `Status_code of int | `Unknown ] ]

  val start : sw:Eio.Switch.t -> conn -> [> msg ] #Gen_server.process -> unit
end
