include Websocket.Make (Cohttp_eio.Private.IO)

type conn = {
  id : string;
  read_frame : unit -> Websocket.Frame.t;
  write_frame : Websocket.Frame.t -> unit;
}

let drain_handshake req ic oc nonce =
  Request.write (fun _ -> ()) req oc;
  let resp =
    match Response.read ic with
    | `Ok r -> r
    | `Eof -> raise End_of_file
    | `Invalid s -> failwith s
  in
  let status = Cohttp.Response.status resp in
  let headers = Cohttp.Response.headers resp in
  if Cohttp.Code.(is_error (code_of_status status)) then
    failwith ("error status: " ^ Cohttp.Code.(string_of_status status));
  if Cohttp.Response.version resp <> `HTTP_1_1 then
    failwith "invalid HTTP version";
  if status <> `Switching_protocols then failwith "wrong status";
  (match Cohttp.Header.get headers "upgrade" with
  | Some a when String.lowercase_ascii a = "websocket" -> ()
  | _ -> failwith "wrong upgrade");
  if not (Websocket.upgrade_present headers) then
    failwith "upgrade header not present";
  (match Cohttp.Header.get headers "sec-websocket-accept" with
  | Some accept
    when accept
         = Websocket.b64_encoded_sha1sum (nonce ^ Websocket.websocket_uuid) ->
      ()
  | _ -> failwith "wrong accept");
  ()

let connect' env sw url nonce extra_headers =
  (* Make request *)
  let headers =
    Cohttp.Header.add_list extra_headers
      [
        ("Upgrade", "websocket");
        ("Connection", "Upgrade");
        ("Sec-WebSocket-Key", nonce);
        ("Sec-WebSocket-Version", "13");
      ]
  in
  let req = Cohttp.Request.make ~headers url in

  (* Make socket *)
  let host = Uri.host url |> Option.get in
  let service = Uri.scheme url |> Option.get in
  let addr =
    match Eio.Net.getaddrinfo_stream (Eio.Stdenv.net env) host ~service with
    | [] -> failwith "getaddrinfo failed"
    | addr :: _ -> addr
  in
  let socket = Eio.Net.connect ~sw (Eio.Stdenv.net env) addr in
  let flow =
    let authenticator =
      let null_auth ?ip:_ ~host:_ _ = Ok None in
      null_auth
    in
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

  (* Drain handshake *)
  let ic = Eio.Buf_read.of_flow ~max_size:max_int flow in
  Eio.Buf_write.with_flow flow (fun oc -> drain_handshake req ic oc nonce);

  (flow, ic)

let connect ?(extra_headers = Cohttp.Header.init ()) ~sw env url =
  let url = Uri.of_string url in

  let nonce = Base64.encode_exn (Csprng.random_string 16) in
  let flow, ic = connect' env sw url nonce extra_headers in

  (* Start writer fiber. All writes must be done in this fiber,
     because Eio.Flow.write is not thread-safe.
     c.f.: https://github.com/ocaml-multicore/eio/blob/v0.11/lib_eio/flow.mli#L73-L74
  *)
  let write_queue = Eio.Stream.create 10 in
  (let rec writer () =
     try
       let frame = Eio.Stream.take write_queue in
       let buf = Buffer.create 128 in
       write_frame_to_buf ~mode:(Client Csprng.random_string) buf frame;
       Eio.Buf_write.with_flow flow (fun oc ->
           Eio.Buf_write.string oc (Buffer.contents buf));
       writer ()
     with Eio.Io _ -> ()
   in
   Eio.Fiber.fork ~sw writer);

  let write_frame frame = Eio.Stream.add write_queue frame in
  let read_frame () =
    Eio.Buf_write.with_flow flow (fun oc ->
        make_read_frame ~mode:(Client Csprng.random_string) ic oc ())
  in

  { id = Csprng.random_string 10; read_frame; write_frame }

let id { id; _ } = id
let read { read_frame; _ } = read_frame ()
let write { write_frame; _ } frame = write_frame frame

module Process = struct
  type msg =
    [ `WSText of string * conn
    | `WSClose of [ `Status_code of int | `Unknown ] * conn ]

  let start ~sw conn (caster : [> msg ] Actaa.Process.t1) =
    Eio.Fiber.fork ~sw @@ fun () ->
    let rec loop () =
      try
        let frame = read conn in
        Logs.info (fun m -> m "Ws received: %a" Websocket.Frame.pp frame);
        match frame.opcode with
        | Text ->
            (try Actaa.Process.send caster (`WSText (frame.content, conn))
             with e ->
               Logs.err (fun m ->
                   m "Ws handling event failed: %s: %s" (Printexc.to_string e)
                     frame.content));
            loop ()
        | Close ->
            let status_code = String.get_int16_be frame.content 0 in
            Logs.warn (fun m ->
                m "Websocket connection closed: code %d" status_code);
            Actaa.Process.send caster
              (`WSClose (`Status_code status_code, conn))
        | _ ->
            Logs.info (fun m ->
                m "Received non-text ws frame: %a" Websocket.Frame.pp frame);
            loop ()
      with e ->
        Logs.err (fun m ->
            m "Ws receiving failed: %s: %s" (Printexc.to_string e)
              (Printexc.get_backtrace ()));
        Actaa.Process.send caster (`WSClose (`Unknown, conn))
    in
    loop ()
end
