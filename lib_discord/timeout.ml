module Caster = struct
  type 'a msg = [ `Timeout of 'a ]

  let start clock ~sw timeout id (caster : [> 'a msg ] #Gen_server.caster) =
    Eio.Fiber.fork ~sw @@ fun () ->
    Eio.Time.sleep clock timeout;
    caster#cast (`Timeout id)
end
