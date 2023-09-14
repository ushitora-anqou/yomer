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
