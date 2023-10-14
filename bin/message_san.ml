let mention_user_id_regex = Regex.e {|<@!?([0-9]+)>|}
let mention_role_id_regex = Regex.e {|<@&([0-9]+)>|}
let mention_channel_id_regex = Regex.e {|<#!?([0-9]+)>|}

let replace_mention_with_display_name env config ~guild_id text =
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
               |> Result.map (fun (u : Discord.Object.user) -> "@" ^ u.username)
               |> Result.value ~default:whole)
       | _ -> assert false)

let replace_mention_with_role env config ~guild_id text =
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

let replace_channel_id_with_its_name env config ~guild_id text =
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

let sanitize env config ~guild_id ~text =
  text
  |> replace_mention_with_display_name env config ~guild_id
  |> replace_mention_with_role env config ~guild_id
  |> replace_channel_id_with_its_name env config ~guild_id
  |> String.trim
