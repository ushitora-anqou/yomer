open Util

let authenticator =
  (* FIXME *)
  let null_auth ?ip:_ ~host:_ _ = Ok None in
  null_auth

let request_https socket host =
  let host =
    Result.(host |> Domain_name.of_string >>= Domain_name.host |> to_option)
  in
  let client =
    let open Tls.Config in
    client ~version:(`TLS_1_0, `TLS_1_3) ~authenticator
      ~ciphers:Ciphers.supported ()
  in
  Tls_eio.client_of_flow client ?host socket

let request ?headers ?body ~meth env ~sw url =
  let url = Uri.of_string url in
  let host = Uri.host url |> Option.get in
  let port = Uri.port url in
  let service = Uri.scheme url |> Option.get in
  let path = Uri.path_and_query url in
  let headers = headers |> Option.map Cohttp.Header.of_list in
  let body =
    body |> Option.map (function `Fixed src -> Cohttp_eio.Body.Fixed src)
  in
  let addr =
    match Eio.Net.getaddrinfo_stream (Eio.Stdenv.net env) host ~service with
    | [] -> failwith "getaddrinfo failed"
    | addr :: _ -> (
        match (addr, port) with
        | `Tcp (ip, _), Some port -> `Tcp (ip, port)
        | _ -> addr)
  in
  let net = Eio.Stdenv.net env in
  let socket = Eio.Net.connect ~sw net addr in
  let conn : Eio.Flow.two_way =
    match service with
    | "https" -> (request_https socket host :> Eio.Flow.two_way)
    | "http" -> (socket :> Eio.Flow.two_way)
    | _ -> failwith "unsupported scheme"
  in
  Cohttp_eio.Client.call ~meth env ~host ?port ?headers ?body ~conn path

let get = request ~meth:`GET
let post = request ~meth:`POST
let put = request ~meth:`PUT
let delete = request ~meth:`DELETE

let drain_resp_body resp =
  let body = ref [] in
  match
    Cohttp_eio.Client.read_chunked resp (function
      | Chunk { data; _ } -> body := data :: !body
      | Last_chunk _ -> ())
  with
  | None -> Cohttp_eio.Client.read_fixed resp
  | Some _ -> String.concat "" (List.rev !body)
