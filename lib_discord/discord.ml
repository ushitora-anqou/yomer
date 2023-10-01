(*
  Architecture of Discord module:
    - Fiber Gateway (x 1)
    - Fiber VoiceGateway (x # of guilds with voice)
    - Fiber VoiceUDPStream (x # of guilds with voice)
    - Fiber EventConsumer (x 1)

  Each fiber has a mailbox to interact with other fibers.

  Each fiber consists of a module with the following interface:

  ```ocaml
  module M = struct
    type msg = ...
    type t = { m : msg Mailbox.t; ... }

    let main config env sw ... m () =
      let rec loop () =
        match Mailbox.receive m with
        | ... -> ...
      in
      loop ()

    let spawn config env ... =
      let m = Mailbox.create () in
      Eio.Fiber.fork ~sw (main config env ... m);
      { m; ... }

    let send_message { m; _ } msg = Mailbox.send m msg
  end
  ```
*)

(*open Ppx_yojson_conv_lib.Yojson_conv.Primitives*)

module Agent = Agent
module Config = Config
module Event = Event
module Intent = Intent
module Message = Message
module StringMap = Util.StringMap
