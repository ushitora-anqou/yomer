type ('a, 'state) call_result = [ `Reply of 'a * 'state | `Stop ]
type 'state cast_result = [ `NoReply of 'state | `Stop ]

class type ['init_arg, 'call_msg, 'call_reply, 'cast_msg] intf = object
  val m :
    [ `Call of 'call_msg * 'call_reply Eio.Stream.t
    | `Cast of 'cast_msg
    | `Stop of unit Eio.Stream.t ]
    Mailbox.t

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
          | `Stop of unit Eio.Stream.t ]
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
        (_ : 'state) =
      ()

    method start env ~sw (args : 'init_arg) =
      let already_running =
        not (Atomic.compare_and_set running Stopped Running)
      in
      if already_running then ()
      else
        Eio.Fiber.fork ~sw @@ fun () ->
        let state = self#init env ~sw args in
        let rec loop state =
          match Mailbox.receive m with
          | `Call (msg, reply_stream) -> (
              match self#handle_call env ~sw state msg with
              | `Reply (reply, state) ->
                  Eio.Stream.add reply_stream reply;
                  loop state
              | `Stop -> ())
          | `Cast msg -> (
              match self#handle_cast env ~sw state msg with
              | `NoReply state -> loop state
              | `Stop -> ())
          | `Stop reply_stream ->
              self#terminate env ~sw state;
              Eio.Stream.add reply_stream ();
              ()
        in
        loop state;
        Atomic.set running Stopped

    method stop =
      let not_running = not (Atomic.compare_and_set running Running Stopping) in
      if not_running then ()
      else
        let stream = Eio.Stream.create 0 in
        Mailbox.send m (`Stop stream);
        Eio.Stream.take stream

    method call (msg : 'call_msg) : 'call_reply =
      let stream = Eio.Stream.create 0 in
      Mailbox.send m (`Call (msg, stream));
      Eio.Stream.take stream

    method cast (msg : 'cast_msg) : unit = Mailbox.send m (`Cast msg)
  end

class type ['cast_msg] caster = object
  method cast : 'cast_msg -> unit
end

(*
  class type ['call_msg] caller = object
    method call : 'call_msg -> unit
  end
*)

let start_timeout clock ~sw timeout id (caster : _ #caster) =
  Eio.Fiber.fork ~sw @@ fun () ->
  Eio.Time.sleep clock timeout;
  caster#cast (`Timeout id)

type ws_cast_msg =
  [ `WSText of string | `WSClose of [ `Status_code of int | `Unknown ] ]

let start_ws_receiving ~sw conn (caster : [> ws_cast_msg ] #caster) =
  Eio.Fiber.fork ~sw @@ fun () ->
  let rec loop () =
    try
      let frame = Ws.read conn in
      Logs.info (fun m -> m "Ws received: %a" Websocket.Frame.pp frame);
      match frame.opcode with
      | Text ->
          (try caster#cast (`WSText frame.content)
           with e ->
             Logs.err (fun m ->
                 m "Ws handling event failed: %s: %s" (Printexc.to_string e)
                   frame.content));
          loop ()
      | Close ->
          let status_code = String.get_int16_be frame.content 0 in
          Logs.warn (fun m ->
              m "Websocket connection closed: code %d" status_code);
          caster#cast (`WSClose (`Status_code status_code))
      | _ ->
          Logs.info (fun m ->
              m "Received non-text ws frame: %a" Websocket.Frame.pp frame);
          loop ()
    with e ->
      Logs.err (fun m -> m "Ws receiving failed: %s" (Printexc.to_string e));
      caster#cast (`WSClose `Unknown)
  in
  loop ()

let cast t msg = t#cast msg
let call t msg = t#call msg
let start t env ~sw args = t#start env ~sw args
