let log_structured formatter args =
  `Assoc args |> Yojson.Safe.to_string |> Format.fprintf formatter "%s@."

let now () = Ptime.to_float_s (Ptime.v (Pclock.now_d_ps ()))

let to_rfc3339 unix_time =
  let time = Option.get (Ptime.of_float_s unix_time) in
  let fraction = fst (modf unix_time) *. 1000. in
  let clamped_fraction = if fraction > 999. then 999. else fraction in
  let (y, m, d), ((hh, mm, ss), _tz_offset_s) = Ptime.to_date_time time in
  Printf.sprintf "%04d-%02d-%02dT%02d:%02d:%02d.%03.0fZ" y m d hh mm ss
    clamped_fraction

let json_reporter ~formatter =
  (* Thanks to: https://github.com/aantron/dream/blob/8140a600e4f9401e28f77fee3e4328abdc8246ef/src/server/log.ml#L110 *)
  let report src level ~over k user's_callback =
    let level =
      match level with
      | Logs.App -> ""
      | Logs.Error -> "ERROR"
      | Logs.Warning -> "WARN"
      | Logs.Info -> "INFO"
      | Logs.Debug -> "DEBUG"
    in
    user's_callback @@ fun ?header ?tags format_and_arguments ->
    ignore header;
    ignore tags;
    let time = now () |> to_rfc3339 in
    let source = Logs.Src.name src in

    let buffer = Buffer.create 512 in
    let f = Fmt.with_buffer ~like:Fmt.stderr buffer in
    Format.kfprintf
      (fun _ ->
        let msg = Buffer.contents buffer in
        Buffer.reset buffer;
        log_structured formatter
          [
            ("t", `String time);
            ("s", `String source);
            ("l", `String level);
            ("m", `String msg);
          ];

        over ();
        k ())
      f format_and_arguments
  in
  { Logs.report }

let pretty_reporter ~formatter ?(src_width = 5) () =
  (* Thanks to: https://github.com/aantron/dream/blob/8140a600e4f9401e28f77fee3e4328abdc8246ef/src/server/log.ml#L110 *)
  let report src level ~over k user's_callback =
    let level_style, level =
      match level with
      | Logs.App -> (`Fg `White, "     ")
      | Logs.Error -> (`Fg `Red, "ERROR")
      | Logs.Warning -> (`Fg `Yellow, "WARN ")
      | Logs.Info -> (`Fg `Green, "INFO ")
      | Logs.Debug -> (`Fg `Blue, "DEBUG")
    in
    user's_callback @@ fun ?header ?tags format_and_arguments ->
    ignore header;
    ignore tags;
    let time = now () |> to_rfc3339 in
    let source =
      let width = src_width in
      if Logs.Src.name src = Logs.Src.name Logs.default then
        String.make width ' '
      else
        let name = Logs.Src.name src in
        if String.length name > width then
          String.sub name (String.length name - width) width
        else String.make (width - String.length name) ' ' ^ name
    in
    let source_prefix, source =
      try
        let dot_index = String.rindex source '.' + 1 in
        ( String.sub source 0 dot_index,
          String.sub source dot_index (String.length source - dot_index) )
      with Not_found -> ("", source)
    in
    Format.kfprintf
      (fun _ ->
        over ();
        k ())
      formatter
      ("%a %a%s %a @[" ^^ format_and_arguments ^^ "@]@.")
      Fmt.(styled `Faint string)
      time
      Fmt.(styled `White string)
      source_prefix source
      Fmt.(styled level_style string)
      level
  in
  { Logs.report }

let setup () =
  let formatter = Fmt.stdout in
  Fmt.set_style_renderer formatter `Ansi_tty;
  Logs.set_reporter (pretty_reporter ~formatter ());
  (*
  Logs.set_reporter (json_reporter ~formatter);
  *)
  Logs.set_level (Some Logs.Info)
