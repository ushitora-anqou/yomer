let dummy_text = "ちくわ大明神。"

let replace_mention_with_display_name =
  let mention_user_id_regex = Regex.e {|<@!?([0-9]+)>|} in
  fun env config ~guild_id text ->
    text
    |> Regex.replace mention_user_id_regex (function
         | [| Some whole; Some user_id |] -> (
             let whole = Regex.substr whole in
             let user_id = Regex.substr user_id in
             match
               Discord.Rest.get_guild_member env config ~guild_id ~user_id
             with
             | Ok { nick = Some nick; _ } -> "@" ^ nick
             | Ok { user = Some { username; _ }; _ } -> "@" ^ username
             | _ ->
                 Discord.Rest.get_user env config ~user_id
                 |> Result.map (fun (u : Discord.Object.user) ->
                        "@" ^ u.username)
                 |> Result.value ~default:whole)
         | _ -> assert false)

let replace_mention_with_role =
  let mention_role_id_regex = Regex.e {|<@&([0-9]+)>|} in
  fun env config ~guild_id text ->
    text
    |> Regex.replace mention_role_id_regex (function
         | [| Some whole; Some role_id |] -> (
             let whole = Regex.substr whole in
             let role_id = Regex.substr role_id in
             match
               Discord.Rest.get_guild_roles env config ~guild_id
               |> Result.map
                    (List.find_opt (fun (r : Discord.Object.role) ->
                         r.id = role_id))
             with
             | Ok (Some { name; _ }) -> "@" ^ name
             | _ -> whole)
         | _ -> assert false)

let replace_channel_id_with_its_name =
  let mention_channel_id_regex = Regex.e {|<#!?([0-9]+)>|} in
  fun env config ~guild_id text ->
    text
    |> Regex.replace mention_channel_id_regex (function
         | [| Some whole; Some channel_id |] -> (
             let whole = Regex.substr whole in
             let channel_id = Regex.substr channel_id in
             match
               Discord.Rest.get_guild_channels env config ~guild_id
               |> Result.map
                    (List.find_opt (fun (c : Discord.Object.channel) ->
                         c.id = channel_id))
             with
             | Ok (Some { name = Some name; _ }) -> "#" ^ name
             | _ -> whole)
         | _ -> assert false)

let replace_with_alternatives =
  let table =
    [
      (Regex.e "ゔ", "ヴ");
      (Regex.e "ゕ", "ヵ");
      (Regex.e "ゖ", "ヶ");
      (Regex.e "ヷ", "ヴァ");
      (Regex.e "〜", "ー");
      (* FIXME: The following regexes need unicode support of PCRE2
         (Regex.e "[,、]+", "、");
         (Regex.e "[.。]+", "。");
         (Regex.e "[!！][!！?？]+", "！");
         (Regex.e "[?？][!！?？]+", "？");
      *)
    ]
  in
  fun text ->
    table
    |> List.fold_left
         (fun text (regex, replacement) ->
           Regex.replace regex (fun _ -> replacement) text)
         text

let replace_url_with_dummy =
  let re =
    Regex.e
      {|(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:\/?#[\]@!\$%&'\(\)\*\+,;=.]+|}
  in
  fun text -> Regex.replace re (fun _ -> dummy_text) text

let replace_code_block_with_dummy =
  let re = Regex.e ~flags:[ `DOTALL ] {|```.+```|} in
  fun text -> Regex.replace re (fun _ -> dummy_text) text

let replace_custom_emoji_with_name =
  let re = {|<:([^:]+):[0-9]+>|} in
  Regex.replace (Regex.e re) (function
    | [| Some _; Some name |] -> Regex.substr name
    | _ -> assert false)

let replace_emoji_with_name text =
  let to_codepoints s =
    let rec loop d acc =
      match Uutf.decode d with
      | `Uchar u -> loop d (Uchar.to_int u :: acc)
      | _ -> List.rev acc
    in
    let d = Uutf.decoder (`String s) in
    loop d []
  in
  let of_codepoints codes =
    let buf = Buffer.create 0 in
    let rec loop e = function
      | [] ->
          Uutf.encode e `End |> ignore;
          Buffer.contents buf
      | x :: xs ->
          Uutf.encode e (`Uchar (Uchar.of_int x)) |> ignore;
          loop e xs
    in
    let e = Uutf.encoder `UTF_8 (`Buffer buf) in
    loop e codes
  in
  let rec aux acc = function
    | [] -> acc |> List.rev |> List.flatten
    | hd :: tl as codepoints -> (
        match Joypixels.step codepoints with
        | None -> aux ([ hd ] :: acc) tl
        | Some (name, tl) -> aux (to_codepoints name :: acc) tl)
  in
  text |> to_codepoints |> aux [] |> of_codepoints

let replace_non_sjis_with_empty text =
  let to_codepoints s =
    let rec loop d acc =
      match Uutf.decode d with
      | `Uchar u -> loop d (Uchar.to_int u :: acc)
      | _ -> List.rev acc
    in
    let d = Uutf.decoder (`String s) in
    loop d []
  in
  let of_codepoints codes =
    let buf = Buffer.create 0 in
    let rec loop e = function
      | [] ->
          Uutf.encode e `End |> ignore;
          Buffer.contents buf
      | x :: xs ->
          Uutf.encode e (`Uchar (Uchar.of_int x)) |> ignore;
          loop e xs
    in
    let e = Uutf.encoder `UTF_8 (`Buffer buf) in
    loop e codes
  in
  text |> to_codepoints |> List.filter Shift_jis.check |> of_codepoints

let omit_if_too_long ~max_length text =
  let fold_utf8 x y = Uuseg_string.fold_utf_8 `Grapheme_cluster x y in
  let utf8_length = fold_utf8 (fun x _ -> x + 1) 0 in
  let utf8_sub length s =
    s
    |> fold_utf8
         (fun (i, acc) seg ->
           if i < length then (i + 1, acc ^ seg) else (i, acc))
         (0, "")
    |> snd
  in

  if utf8_length text <= max_length then text
  else
    let text = utf8_sub max_length text in
    text ^ "。以下ちくわ大明神。"

let sanitize env config ~guild_id ~text =
  text
  |> replace_mention_with_display_name env config ~guild_id
  |> replace_mention_with_role env config ~guild_id
  |> replace_channel_id_with_its_name env config ~guild_id
  |> replace_with_alternatives |> replace_url_with_dummy
  |> replace_code_block_with_dummy |> replace_custom_emoji_with_name
  |> replace_emoji_with_name |> replace_non_sjis_with_empty
  |> omit_if_too_long ~max_length:100
  |> String.trim
