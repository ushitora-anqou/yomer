type group = { offset : int; length : int; substr : string } [@@deriving make]

let groups_of_substrings sub =
  Pcre2.get_substrings sub
  |> Array.mapi (fun i s ->
         (try Some (Pcre2.get_substring_ofs sub i) with Not_found -> None)
         |> Option.map (fun (off1, off2) ->
                make_group ~offset:off1 ~length:(off2 - off1) ~substr:s))

let e ?flags ptn = Pcre2.regexp ?flags ptn

let match_ rex s =
  (try Pcre2.exec_all ~rex s with Not_found -> [||])
  |> Array.map groups_of_substrings
  |> Array.to_list

let replace rex f s =
  let subst sub = f (groups_of_substrings sub) in
  Pcre2.substitute_substrings ~rex ~subst s

let substr r = r.substr
