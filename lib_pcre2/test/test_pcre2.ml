let test_exec_case1 () =
  let pattern = "あい(うえ)お(なも)?" in
  let subject = "かきあいうえおくけこ" in
  let rex = Pcre2.regexp pattern in
  let m = Pcre2.exec ~rex subject in
  assert (Pcre2.get_substrings m = [| "あいうえお"; "うえ"; "" |]);
  ()

let test_exec_case2 () =
  let pattern = "^(.)(.)Ω$" in
  let subject = "あいω" in
  let rex = Pcre2.regexp ~flags:[ `UTF; `CASELESS ] pattern in
  let m = Pcre2.exec ~rex subject in
  assert (Pcre2.get_substrings m = [| subject; "あ"; "い" |]);

  let pattern = {|\w|} in
  let subject = "あ" in
  let rex = Pcre2.regexp ~flags:[ `UTF; `UCP ] pattern in
  let m = Pcre2.exec ~rex subject in
  assert (Pcre2.get_substrings m = [| subject |]);
  ()

let test_exec_all_case1 () =
  let pattern = "あい(う)?" in
  let subject = "あいうあいあい" in
  let rex = Pcre2.regexp pattern in
  let m = Pcre2.exec_all ~rex subject in
  assert (Array.length m = 3);
  assert (Pcre2.get_substrings m.(0) = [| "あいう"; "う" |]);
  assert (Pcre2.get_substrings m.(1) = [| "あい"; "" |]);
  assert (Pcre2.get_substrings m.(2) = [| "あい"; "" |]);
  ()

let test_exec_all_case2 () =
  let pattern = "ほげ" in
  let subject = "あいうあいあい" in
  let rex = Pcre2.regexp pattern in
  let m = try Some (Pcre2.exec_all ~rex subject) with Not_found -> None in
  assert (m = None);
  ()

let test_substitute_substrings_first_case1 () =
  let pattern = "ほげ(い)?" in
  let subject = "あほげいう" in
  let rex = Pcre2.regexp pattern in
  let subst ss =
    let s = (Pcre2.get_substrings ss).(1) in
    s ^ "ぴよ"
  in
  assert (Pcre2.substitute_substrings_first ~rex ~subst subject = "あいぴよう");
  ()

let test_substitute_substrings_first_case2 () =
  let pattern = "^..(Ω)$" in
  let subject = "あいω" in
  let rex = Pcre2.regexp ~flags:[ `UTF; `CASELESS ] pattern in
  let subst ss =
    let s = (Pcre2.get_substrings ss).(1) in
    s
  in
  assert (Pcre2.substitute_substrings_first ~rex ~subst subject = "ω");
  ()

let test_substitute_substrings_case1 () =
  let pattern = "ほげ(い)?" in
  let subject = "あほげいほげいう" in
  let rex = Pcre2.regexp pattern in
  let subst ss =
    let s = (Pcre2.get_substrings ss).(1) in
    s ^ "ぴよ"
  in
  assert (Pcre2.substitute_substrings ~rex ~subst subject = "あいぴよいぴよう");
  ()

let () =
  Alcotest.run "pcre2"
    [
      ( "exec",
        [
          Alcotest.test_case "case1" `Quick test_exec_case1;
          Alcotest.test_case "case2" `Quick test_exec_case2;
        ] );
      ( "exec_all",
        [
          Alcotest.test_case "case1" `Quick test_exec_all_case1;
          Alcotest.test_case "case2" `Quick test_exec_all_case2;
        ] );
      ( "substitute_substrings_first",
        [
          Alcotest.test_case "case1" `Quick
            test_substitute_substrings_first_case1;
          Alcotest.test_case "case1" `Quick
            test_substitute_substrings_first_case2;
        ] );
      ( "substitute_substrings",
        [ Alcotest.test_case "case1" `Quick test_substitute_substrings_case1 ]
      );
    ]
