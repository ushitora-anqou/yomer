module Tests (Q : Fqueue.S) = struct
  open Q

  let does_raise_empty f x =
    try
      f x |> ignore;
      false
    with Empty -> true

  let test_basics () =
    let q = empty in
    assert (is_empty q);
    assert (does_raise_empty take q);
    assert (does_raise_empty pop q);
    assert (does_raise_empty peek q);
    assert (does_raise_empty top q);
    assert (peek_opt q = None);

    let q = add q 1 in
    assert (not (is_empty q));
    assert (peek q = 1);
    assert (peek_opt q = Some 1);
    assert (top q = 1);

    let q = push q 2 in
    assert (not (is_empty q));
    assert (peek q = 1);

    let x, q = take q in
    assert (x = 1);
    assert (not (is_empty q));
    assert (peek q = 2);

    let x, q = pop q in
    assert (x = 2);
    assert (is_empty q);
    ()

  let test_persistency () =
    let q1 = empty in
    let q2 = add q1 1 in
    let q3 = add q2 2 in
    let x, q3' = take_opt q3 in
    assert (x = Some 1);
    let x, _ = take_opt q3' in
    assert (x = Some 2);
    let x, q2' = take_opt q2 in
    assert (x = Some 1);
    let x, _ = take_opt q2' in
    assert (x = None);
    ()

  let tests =
    [
      Alcotest.test_case "basics" `Quick test_basics;
      Alcotest.test_case "persistency" `Quick test_persistency;
    ]
end

module Batched = Tests (Fqueue.Batched)
module Realtime = Tests (Fqueue.Realtime)
module Bootstrapped = Tests (Fqueue.Bootstrapped)

let () =
  Alcotest.run "fqueue"
    [
      ("batched", Batched.tests);
      ("realtime", Realtime.tests);
      ("bootstrapped", Bootstrapped.tests);
    ]
