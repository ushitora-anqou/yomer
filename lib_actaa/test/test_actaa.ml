open Actaa

let spawn env ~sw args s = Process.spawn ~raise_exn:true env ~sw args s

class p1 =
  object (self)
    inherit [unit, unit] Process.t

    method on_spawn _env ~sw:_ () =
      let () = self#receive in
      Process.Stop_reason.Normal
  end

class p2 =
  object (self)
    inherit [p1, [ `EXIT of Process.t0 * Process.Stop_reason.t ]] Process.t

    method on_spawn env ~sw p1 =
      Process.link p1 (self :> Process.monitor);
      spawn env ~sw () p1;
      Process.send p1 ();
      match self#receive with
      | `EXIT (proc, reason) ->
          assert (proc = (p1 :> Process.t0));
          assert (reason = Process.Stop_reason.Normal);
          Process.Stop_reason.Normal
  end

let test_actaa_process () =
  Eio_main.run @@ fun env ->
  Eio.Switch.run @@ fun sw ->
  let p1 = new p1 in
  let p2 = new p2 in
  spawn env ~sw p1 p2;
  ()

class p3 =
  object (self)
    inherit [Registry.t * unit Registry.key, unit] Process.t

    method on_spawn _env ~sw:_ (reg, key) =
      assert (Registry.register reg key (self :> _ Process.t2));
      assert (not (Registry.register reg key (self :> _ Process.t2)));
      let () = self#receive in
      Process.Stop_reason.Normal
  end

class p4 =
  object
    inherit [unit, unit] Process.t

    method on_spawn env ~sw () =
      let reg = new Registry.t in
      spawn env ~sw () reg;
      let key = Registry.create_key () in
      spawn env ~sw (reg, key) (new p3);
      let rec loop () = if Registry.send reg key () then () else loop () in
      loop ();
      let rec loop () = if Registry.send reg key () then loop () else () in
      loop ();
      Registry.stop reg;
      Process.Stop_reason.Normal
  end

let test_actaa_registry () =
  Eio_main.run @@ fun env ->
  Eio.Switch.run @@ fun sw ->
  spawn env ~sw () (new p4);
  ()

class p5 =
  object (self)
    inherit [Registry.t * int Registry.key, int] Process.t

    method on_spawn _env ~sw:_ (reg, key) =
      assert (Registry.register reg key (self :> _ Process.t2));
      match self#receive with
      | 0 -> Process.Stop_reason.Normal
      | _ -> failwith "fail"
  end

class p6 =
  object
    inherit
      [Registry.t * int Registry.key, Registry.t * int Registry.key, int] Supervisor
                                                                          .t

    method init (reg, key) =
      {
        process_factory = (fun () -> new p5);
        process_arg = (reg, key);
        max_restarts = 3;
        max_seconds = 5.0;
      }
  end

class p7 =
  object
    inherit [unit, unit] Process.t

    method on_spawn env ~sw () =
      let reg = new Registry.t in
      spawn env ~sw () reg;
      let key = Registry.create_key () in
      spawn env ~sw (reg, key) (new p6);
      let rec loop () = if Registry.send reg key 1 then () else loop () in
      loop ();
      let rec loop () = if Registry.send reg key 0 then () else loop () in
      loop ();
      let rec loop () = if Registry.send reg key 0 then loop () else () in
      loop ();
      Registry.stop reg;
      Process.Stop_reason.Normal
  end

let test_actaa_supervisor () =
  Eio_main.run @@ fun env ->
  Eio.Switch.run @@ fun sw ->
  spawn env ~sw () (new p7);
  ()

module Gen_server_case1 = struct
  type init_arg = unit
  type call_msg = [ `Set of int | `Get ]
  type call_reply = [ `Set of int | `Get of int ]
  type cast_msg = [ `Set of int ]
  type state = int
  type basic_msg = (call_msg, call_reply, cast_msg) Gen_server.basic_msg
  type msg = [ basic_msg | `Info of int ]

  class t =
    object
      inherit [init_arg, msg, state] Gen_server.t
      method private init _env ~sw:_ () = 0

      method! private handle_call _env ~sw:_ x =
        function `Set y -> `Reply (`Set x, y) | `Get -> `Reply (`Get x, x)

      method! private handle_cast _env ~sw:_ _ = function `Set x -> `NoReply x

      method! private handle_info _env ~sw:_ _ =
        function #basic_msg -> assert false | `Info x -> `NoReply x
    end

  let get (t : t) =
    match Gen_server.call t `Get with `Get x -> x | _ -> assert false

  let call_set (t : t) x =
    match Gen_server.call t (`Set x) with `Set x -> x | _ -> assert false

  let cast_set (t : t) x = Gen_server.cast t (`Set x)

  let expect_eventually (t : t) x =
    let rec loop () = if get t = x then () else loop () in
    loop ();
    true

  let test () =
    Eio_main.run @@ fun env ->
    Eio.Switch.run @@ fun sw ->
    let t = new t in
    t |> spawn env ~sw ();
    assert (get t = 0);
    assert (call_set t 1 = 0);
    assert (get t = 1);
    cast_set t 2;
    assert (expect_eventually t 2);
    Process.send t (`Info 3);
    assert (expect_eventually t 3);
    Gen_server.stop t;
    ()
end

let () =
  Alcotest.run "actaa"
    [
      ( "actaa",
        [
          Alcotest.test_case "process" `Quick test_actaa_process;
          Alcotest.test_case "registry" `Quick test_actaa_registry;
          Alcotest.test_case "supervisor" `Quick test_actaa_supervisor;
        ] );
      ("gen_server", [ Alcotest.test_case "case1" `Quick Gen_server_case1.test ]);
    ]
