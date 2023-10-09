open Util

type stop_reason = ..
type stop_reason += Normal | Exn of string

type ('a, 'state) call_result =
  [ `Reply of 'a * 'state | `Stop of stop_reason * 'a * 'state ]

type 'state cast_result = [ `NoReply of 'state | `Stop of stop_reason * 'state ]

class type ['init_arg, 'call_msg, 'call_reply, 'cast_msg] intf = object
  method call : 'call_msg -> 'call_reply
  method cast : 'cast_msg -> unit

  method start :
    Eio_unix.Stdenv.base -> sw:Eio__core.Switch.t -> 'init_arg -> unit

  method stop : unit
end

type process_state = Running | Stopping | Stopped

class virtual ['init_arg, 'call_msg, 'call_reply, 'cast_msg, 'state] t =
  object (self)
    val running = Atomic.make Stopped

    val m
        : [ `Cast of 'cast_msg
          | `Call of 'call_msg * 'call_reply Eio.Stream.t
          | `Stop of stop_reason * unit Eio.Stream.t ]
          Mailbox.t =
      Mailbox.create ()

    method private virtual init
        : Eio_unix.Stdenv.base -> sw:Eio.Switch.t -> 'init_arg -> 'state

    method private handle_call (_ : Eio_unix.Stdenv.base) ~sw:(_ : Eio.Switch.t)
        (_ : 'state) (_ : 'call_msg) : ('call_reply, 'state) call_result =
      failwith "not implemented"

    method private handle_cast (_ : Eio_unix.Stdenv.base) ~sw:(_ : Eio.Switch.t)
        (_ : 'state) (_ : 'cast_msg) : 'state cast_result =
      failwith "not implemented"

    method private terminate (_ : Eio_unix.Stdenv.base) ~sw:(_ : Eio.Switch.t)
        (_ : 'state) (_ : stop_reason) =
      ()

    method private run (env : Eio_unix.Stdenv.base) ~(sw : Eio.Switch.t)
        (args : 'init_arg) : stop_reason =
      let state = self#init env ~sw args in
      let rec loop state =
        match Mailbox.receive m with
        | `Call (msg, reply_stream) -> (
            match self#handle_call env ~sw state msg with
            | exception e ->
                let reason =
                  Exn
                    (Printf.sprintf "handle_call raised exception: %s\n%s"
                       (Printexc.to_string e)
                       (Printexc.get_backtrace ()))
                in
                (* NOTE: reply_stream will be dead locked *)
                (reason, state)
            | `Reply (reply, state) ->
                Eio.Stream.add reply_stream reply;
                loop state
            | `Stop (reason, reply, state) ->
                Eio.Stream.add reply_stream reply;
                (reason, state))
        | `Cast msg -> (
            match self#handle_cast env ~sw state msg with
            | exception e ->
                let reason =
                  Exn
                    (Printf.sprintf "handle_cast raised exception: %s\n%s"
                       (Printexc.to_string e)
                       (Printexc.get_backtrace ()))
                in
                (reason, state)
            | `NoReply state -> loop state
            | `Stop (reason, state) -> (reason, state))
        | `Stop (reason, reply_stream) ->
            Eio.Stream.add reply_stream ();
            (reason, state)
      in
      let reason, state = loop state in
      self#terminate env ~sw state reason;
      reason

    method private supervise ?(max_restarts = 3) ?(max_seconds = 5.0)
        (env : Eio_unix.Stdenv.base) ~(sw : Eio.Switch.t) (args : 'init_arg)
        : unit =
      let rec loop restarts =
        let reason = self#run env ~sw args in
        match reason with
        | Normal -> ()
        | _ ->
            Logs.warn (fun m ->
                m "A gen server died: %s"
                  (match reason with Exn s -> s | _ -> "unknown reason"));
            (* Check if we have reached the maximum number of restarts *)
            let restarts, _ =
              List.take_at_most max_restarts (now () :: restarts)
            in
            let duration = List.hd restarts -. List.hd (List.rev restarts) in
            if List.length restarts = max_restarts && duration < max_seconds
            then ()
            else (
              Logs.warn (fun m -> m "Restarting a gen server");
              loop restarts)
      in
      loop []

    method start env ~sw (args : 'init_arg) =
      let already_running =
        not (Atomic.compare_and_set running Stopped Running)
      in
      if already_running then ()
      else
        Eio.Fiber.fork ~sw @@ fun () ->
        self#supervise env ~sw args;
        Atomic.set running Stopped

    method stop =
      let not_running = not (Atomic.compare_and_set running Running Stopping) in
      if not_running then ()
      else
        let stream = Eio.Stream.create 0 in
        Mailbox.send m (`Stop (Normal, stream));
        Eio.Stream.take stream

    method call (msg : 'call_msg) : 'call_reply =
      let stream = Eio.Stream.create 0 in
      Mailbox.send m (`Call (msg, stream));
      Eio.Stream.take stream

    method cast (msg : 'cast_msg) : unit = Mailbox.send m (`Cast msg)
  end

class type ['cast_msg] process = object
  method cast : 'cast_msg -> unit
end

(*
  class type ['call_msg] caller = object
    method call : 'call_msg -> unit
  end
*)

let cast t msg = t#cast msg
let call t msg = t#call msg
let start t env ~sw args = t#start env ~sw args
