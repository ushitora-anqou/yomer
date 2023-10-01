let get env url =
  let url = Uri.of_string url in
  let host = Uri.host url |> Option.get in
  let service = Uri.scheme url |> Option.get in
  let addr =
    match Eio.Net.getaddrinfo_stream (Eio.Stdenv.net env) host ~service with
    | [] -> failwith "getaddrinfo failed"
    | addr :: _ -> addr
  in
  let path = Uri.path url in

  let net = Eio.Stdenv.net env in
  let authenticator =
    let null_auth ?ip:_ ~host:_ _ = Ok None in
    null_auth
  in
  Eio.Switch.run @@ fun sw ->
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
  Cohttp_eio.Client.get env ~conn:flow ~host path
