module Make (S : sig
  type key
  type value

  val compare : key -> key -> int
end) =
struct
  module Map = Stdlib.Map.Make (struct
    type t = S.key

    let compare = S.compare
  end)

  type init_arg = unit
  type call_msg = [ `Set of S.key * S.value | `Get of S.key ]
  type call_reply = [ `Set of bool * S.value | `Get of S.value option ]
  type cast_msg = [ `Set of S.key * S.value | `Unset of S.key ]
  type state = { store : S.value Map.t }

  class t =
    object
      inherit [init_arg, call_msg, call_reply, cast_msg, state] Gen_server.t
      method private init _env ~sw:_ () = { store = Map.empty }
      method! private terminate _ ~sw:_ _state _reason = ()

      method! private handle_call _env ~sw:_ state =
        function
        | `Get key -> `Reply (`Get (Map.find_opt key state.store), state)
        | `Set (key, value) -> (
            match Map.find_opt key state.store with
            | None ->
                let store = Map.add key value state.store in
                `Reply (`Set (true, value), { store })
            | Some value -> `Reply (`Set (false, value), state))

      method! private handle_cast _env ~sw:_ state =
        function
        | `Set (key, value) ->
            let store = Map.add key value state.store in
            `NoReply { store }
        | `Unset key ->
            let store = Map.remove key state.store in
            `NoReply { store }
    end
end

module Me_kv = struct
  type key = unit
  type value = User.t

  let compare () () = 0
end

module Me = Make (Me_kv)

module Voice_states_kv = struct
  type key = string (* guild_id *) * string (* user_id *)
  type value = Voice_state.t

  let compare = compare
end

module Voice_states = Make (Voice_states_kv)

module Voice_value_kv = struct
  type key = string (* guild_id *)
  type value = { channel_id : string; gateway : Voice_gateway.t }

  let compare = String.compare
end

module Voice = Make (Voice_value_kv)

type t = { me : Me.t; voice_states : Voice_states.t; voice : Voice.t }

let start env ~sw =
  let me = new Me.t in
  let voice_states = new Voice_states.t in
  let voice = new Voice.t in
  Gen_server.start me env ~sw ();
  Gen_server.start voice_states env ~sw ();
  Gen_server.start voice env ~sw ();
  { me; voice_states; voice }

let me { me; _ } =
  match Gen_server.call me (`Get ()) with `Get me -> me | _ -> assert false

let set_me { me; _ } user = Gen_server.cast me (`Set ((), user))

let voice_states { voice_states; _ } ~guild_id ~user_id =
  match Gen_server.call voice_states (`Get (guild_id, user_id)) with
  | `Get voice_state -> voice_state
  | _ -> assert false

let set_voice_states { voice_states; _ } ~guild_id ~user_id voice_state =
  Gen_server.cast voice_states (`Set ((guild_id, user_id), voice_state))

let voice { voice; _ } guild_id =
  match Gen_server.call voice (`Get guild_id) with
  | `Get voice -> voice
  | _ -> assert false

let set_voice { voice; _ } ~guild_id ~channel_id ~gateway =
  Gen_server.cast voice (`Set (guild_id, { channel_id; gateway }))

let unset_voice { voice; _ } ~guild_id = Gen_server.cast voice (`Unset guild_id)

let set_voice_if_not_exists { voice; _ } ~guild_id ~channel_id ~gateway =
  match Gen_server.call voice (`Set (guild_id, { channel_id; gateway })) with
  | `Set x -> x
  | _ -> assert false
