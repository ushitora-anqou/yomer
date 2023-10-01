open Util

type guild_data_t = {
  guild_id : string;
  voice_states : Voice_state.t StringMap.t (* user_id -> Voice_state.t *);
  voice : (string (* channel_id *) * Voice_gateway.t) option;
}

let empty_guild_data guild_id =
  { guild_id; voice_states = StringMap.empty; voice = None }

type t = {
  s : int Atomic.t;
  guild_data : (string (* guild id *), guild_data_t) Hashtbl.t With_mutex.t;
  me : User.t option Atomic.t;
}

let create () =
  {
    s = Atomic.make 0;
    guild_data = Hashtbl.create 0 |> With_mutex.make;
    me = Atomic.make None;
  }

let s { s; _ } = Atomic.get s
let set_s { s; _ } = Atomic.set s
let me { me; _ } = Atomic.get me
let set_me { me; _ } = Atomic.set me

let guild_data { guild_data; _ } guild_id =
  With_mutex.ro_lock guild_data @@ fun h -> Hashtbl.find_opt h guild_id

let update_guild_data { guild_data; _ } guild_id f =
  With_mutex.rw_lock ~protect:true guild_data @@ fun h ->
  Hashtbl.find_opt h guild_id
  |> Option.value ~default:(empty_guild_data guild_id)
  |> f |> Hashtbl.replace h guild_id
