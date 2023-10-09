let request ~meth ?body env config path =
  let headers =
    [
      ("authorization", "Bot " ^ config.Config.token);
      ("user-agent", "DiscordBot (https://github.com/ushitora-anqou/yomer, 0.1)");
      ("content-Type", "application/json");
      ("accept", "*/*");
    ]
  in
  let url = "https://discord.com/api/v10" ^ path in
  Logs.info (fun m ->
      m "REST request: %s %s [%s]"
        (Cohttp.Code.string_of_method meth)
        url
        (body |> Option.fold ~none:"" ~some:Yojson.Safe.to_string));
  let body = body |> Option.map (fun x -> `Fixed (Yojson.Safe.to_string x)) in
  Eio.Switch.run @@ fun sw ->
  let resp = Https.request ~meth ~headers ?body env ~sw url in
  let body =
    let body = ref [] in
    match
      Cohttp_eio.Client.read_chunked resp (function
        | Chunk { data; _ } -> body := data :: !body
        | Last_chunk _ -> ())
    with
    | None -> Cohttp_eio.Client.read_fixed resp
    | Some _ -> String.concat "" !body
  in
  let body =
    try body |> Yojson.Safe.from_string |> Option.some with _ -> None
  in
  (Cohttp.Response.status (fst resp), body)

open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type create_message_param = { content : string } [@@deriving make, yojson]

let create_message (env : Eio_unix.Stdenv.base) config channel_id p =
  match
    request env config ~meth:`POST
      ~body:(yojson_of_create_message_param p)
      ("/channels/" ^ channel_id ^ "/messages")
  with
  | code, Some body when Cohttp.Code.(code |> code_of_status |> is_success) ->
      Logs.info (fun m -> m "create_message: %s" (Yojson.Safe.to_string body));
      Ok (Object.message_of_yojson body)
  | code, body ->
      Error
        (Printf.sprintf "create_message: %s: %s"
           (Cohttp.Code.string_of_status code)
           (body |> Option.fold ~none:"" ~some:Yojson.Safe.to_string))
  | exception exn ->
      Error
        (Printf.sprintf "create_message failed: %s" (Printexc.to_string exn))
