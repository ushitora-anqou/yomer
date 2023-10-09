let request ?headers ?body ~meth env ~sw url =
  let url = Uri.of_string url in
  let host = Uri.host url |> Option.get in
  let service = Uri.scheme url |> Option.get in
  let addr =
    match Eio.Net.getaddrinfo_stream (Eio.Stdenv.net env) host ~service with
    | [] -> failwith "getaddrinfo failed"
    | addr :: _ -> addr
  in
  let path = Uri.path_and_query url in

  let net = Eio.Stdenv.net env in
  let authenticator =
    let null_auth ?ip:_ ~host:_ _ = Ok None in
    null_auth
  in
  let socket = Eio.Net.connect ~sw net addr in
  let flow =
    let host =
      Result.to_option
        (Result.bind (Domain_name.of_string host) Domain_name.host)
    in
    Tls_eio.client_of_flow
      Tls.Config.(
        client ~version:(`TLS_1_0, `TLS_1_3) ~authenticator
          ~ciphers:Ciphers.supported ())
      ?host socket
  in
  let headers = headers |> Option.map Cohttp.Header.of_list in
  let body =
    body |> Option.map (function `Fixed src -> Cohttp_eio.Body.Fixed src)
  in
  Cohttp_eio.Client.call ~meth env ~conn:flow ~host ?headers ?body path

let get = request ~meth:`GET
let post = request ~meth:`POST
let put = request ~meth:`PUT
let delete = request ~meth:`DELETE
