module StringMap = Map.Make (String)

module With_mutex = struct
  type 'a t = { mtx : Eio.Mutex.t; v : 'a }

  let make v = { mtx = Eio.Mutex.create (); v }
  let ro_lock { mtx; v } f = Eio.Mutex.use_ro mtx (fun () -> f v)
  let rw_lock { mtx; v } f = Eio.Mutex.use_rw mtx (fun () -> f v)
end

type json_any = Yojson.Safe.t [@@deriving show]

let json_any_of_yojson = Fun.id
let yojson_of_json_any = Fun.id
