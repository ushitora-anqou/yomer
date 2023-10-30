module IO = struct
  (* Thanks to: https://github.com/vbmithr/ocaml-websocket/pull/130 *)
  open Websocket
  open Astring
  open Eio

  type mode = Client of (int -> string) | Server

  let is_client mode = mode <> Server

  let xor mask msg =
    for i = 0 to Bytes.length msg - 1 do
      (* masking msg to send *)
      Bytes.set msg i
        Char.(to_int mask.[i mod 4] lxor to_int (Bytes.get msg i) |> of_byte)
    done

  let is_bit_set idx v = (v lsr idx) land 1 = 1
  let set_bit v idx b = if b then v lor (1 lsl idx) else v land lnot (1 lsl idx)
  let int_value shift len v = (v lsr shift) land ((1 lsl len) - 1)

  let read_exactly src remaining =
    try Some (Buf_read.take remaining src) with End_of_file -> None

  let read_uint16 ic =
    match read_exactly ic 2 with
    | None -> None
    | Some s -> Some (EndianString.BigEndian.get_uint16 s 0)

  let read_int64 ic =
    match read_exactly ic 8 with
    | None -> None
    | Some s -> Some (Int64.to_int @@ EndianString.BigEndian.get_int64 s 0)

  let write_frame_to_buf ~mode buf fr =
    let open Frame in
    let content = Bytes.unsafe_of_string fr.content in
    let len = Bytes.length content in
    let opcode = Opcode.to_enum fr.opcode in
    let payload_len =
      match len with
      | n when n < 126 -> len
      | n when n < 1 lsl 16 -> 126
      | _ -> 127
    in
    let hdr = set_bit 0 15 fr.final in
    (* We do not support extensions for now *)
    let hdr = hdr lor (opcode lsl 8) in
    let hdr = set_bit hdr 7 (is_client mode) in
    let hdr = hdr lor payload_len in
    (* Payload len is guaranteed to fit in 7 bits *)
    Buf_write.BE.uint16 buf hdr;
    (match len with
    | n when n < 126 -> ()
    | n when n < 1 lsl 16 -> Buf_write.BE.uint16 buf n
    | n -> Buf_write.BE.uint64 buf Int64.(of_int n));
    (match mode with
    | Server -> ()
    | Client random_string ->
        let mask = random_string 4 in
        Buf_write.string buf mask;
        if len > 0 then xor mask content);
    Buf_write.bytes buf content

  let read_frame ic write_frame hdr =
    let hdr_part1 = EndianString.BigEndian.get_int8 hdr 0 in
    let hdr_part2 = EndianString.BigEndian.get_int8 hdr 1 in
    let final = is_bit_set 7 hdr_part1 in
    let extension = int_value 4 3 hdr_part1 in
    let opcode = int_value 0 4 hdr_part1 in
    let frame_masked = is_bit_set 7 hdr_part2 in
    let length = int_value 0 7 hdr_part2 in
    let opcode = Frame.Opcode.of_enum opcode in
    let payload_len =
      match length with
      | i when i < 126 -> i
      | 126 -> ( match read_uint16 ic with Some i -> i | None -> -1)
      | 127 -> ( match read_int64 ic with Some i -> i | None -> -1)
      | _ -> -1
    in
    if payload_len = -1 then proto_error "payload len = %d" length
    else if extension <> 0 then (
      write_frame (Frame.close 1002);
      proto_error "unsupported extension")
    else if Frame.Opcode.is_ctrl opcode && payload_len > 125 then (
      write_frame (Frame.close 1002);
      proto_error "control frame too big")
    else
      let mask =
        if frame_masked then
          match read_exactly ic 4 with
          | None -> proto_error "could not read mask"
          | Some mask -> mask
        else String.empty
      in
      if payload_len = 0 then Frame.create ~opcode ~extension ~final ()
      else
        match read_exactly ic payload_len with
        | None -> proto_error "could not read payload (len=%d)" payload_len
        | Some payload ->
            let payload = Bytes.unsafe_of_string payload in
            if frame_masked then xor mask payload;
            let frame = Frame.of_bytes ~opcode ~extension ~final payload in
            frame

  let make_read_frame ic write_frame () =
    match read_exactly ic 2 with
    | None -> raise End_of_file
    | Some hdr -> read_frame ic write_frame hdr
end

(*
let set_tcp_nodelay (ssock : Eio.Net.stream_socket) =
  let _ = Eio_unix.Resource.fd ssock in
  let _ = match ssock with Eio.Resource.T (fd, _) -> () in

  (* Thanks to: https://github.com/ocaml-multicore/eio/issues/322#issuecomment-1256943979 *)
  Eio_unix.Fd.use_exn "set_tcp_nodelay" (Eio_unix.Resource.fd ssock) Fun.id
  |> ignore;

  Unix.setsockopt
    (Eio.Eio_unix.FD.peek_opt ssock |> Option.get)
    Unix.TCP_NODELAY true
    *)

let drain_handshake env host path flow nonce headers =
  let resp, buf = Cohttp_eio.Client.call ~headers ~conn:flow env ~host path in
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
  buf

let connect' env sw addr host path nonce extra_headers =
  (* FIXME https://github.com/vbmithr/ocaml-websocket/blob/master/lwt/websocket_lwt_unix.ml#L72 *)
  let headers =
    Cohttp.Header.add_list extra_headers
      [
        ("Upgrade", "websocket");
        ("Connection", "Upgrade");
        ("Sec-WebSocket-Key", nonce);
        ("Sec-WebSocket-Version", "13");
      ]
  in
  let socket = Eio.Net.connect ~sw (Eio.Stdenv.net env) addr in
  let authenticator =
    let null_auth ?ip:_ ~host:_ _ = Ok None in
    null_auth
  in
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
  (* set_tcp_nodelay socket; *)
  let read_buf : Eio.Buf_read.t =
    drain_handshake env host path flow nonce headers
  in
  (flow, read_buf)

type conn = {
  id : string;
  read_frame : unit -> Websocket.Frame.t;
  write_frame : Websocket.Frame.t -> unit;
}

let connect ?(extra_headers = Cohttp.Header.init ()) ~sw env url =
  let url = Uri.of_string url in
  let host = Uri.host url |> Option.get in
  let service = Uri.scheme url |> Option.get in
  let addr =
    match Eio.Net.getaddrinfo_stream (Eio.Stdenv.net env) host ~service with
    | [] -> failwith "getaddrinfo failed"
    | addr :: _ -> addr
  in
  let path = Uri.path_and_query url in

  let nonce = Base64.encode_exn (Csprng.random_string 16) in
  let flow, ic = connect' env sw addr host path nonce extra_headers in

  (* Start writer fiber. All writes must be done in this fiber,
     because Eio.Flow.write is not thread-safe.
     c.f.: https://github.com/ocaml-multicore/eio/blob/v0.11/lib_eio/flow.mli#L73-L74
  *)
  let write_queue = Eio.Stream.create 10 in
  (let rec writer () =
     try
       let frame = Eio.Stream.take write_queue in
       Eio.Buf_write.with_flow flow (fun oc ->
           IO.write_frame_to_buf ~mode:(Client Csprng.random_string) oc frame);
       writer ()
     with Eio.Io _ -> ()
   in
   Eio.Fiber.fork ~sw writer);

  let write_frame frame = Eio.Stream.add write_queue frame in
  let read_frame () = IO.make_read_frame ic write_frame () in

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
        Logs.err (fun m -> m "Ws receiving failed: %s" (Printexc.to_string e));
        Actaa.Process.send caster (`WSClose (`Unknown, conn))
    in
    loop ()
end
