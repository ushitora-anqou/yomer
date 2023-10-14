let mention_id_regex = Regex.e {|<@!?([0-9]+)>|}

let replace_mention_with_display_name env config ~guild_id text =
  text
  |> Regex.replace mention_id_regex (function
       | [| Some whole; Some user_id |] ->
           let whole = Regex.substr whole in
           let user_id = Regex.substr user_id in
           let display_name =
             match
               Discord.Rest.get_guild_member env config ~guild_id ~user_id
             with
             | Ok { nick = Some nick; _ } -> nick
             | Ok { user = Some { username; _ }; _ } -> username
             | _ ->
                 Discord.Rest.get_user env config ~user_id
                 |> Result.map (fun (u : Discord.Object.user) -> u.username)
                 |> Result.value ~default:whole
           in
           "@" ^ display_name
       | _ -> assert false)

let sanitize env config ~guild_id ~text =
  text |> replace_mention_with_display_name env config ~guild_id |> String.trim
