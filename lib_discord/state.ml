open Util

module Voice_states = struct
  type init_arg = unit
  type guild_id = string
  type user_id = string
  type call_msg = [ `Get of guild_id * user_id | `GetAll of guild_id ]

  type call_reply =
    [ `Get of Event.dispatch_voice_state_update option
    | `GetAll of Event.dispatch_voice_state_update StringMap.t ]

  type cast_msg =
    [ `Set of guild_id * user_id * Event.dispatch_voice_state_update
    | `SetAll of guild_id * Event.dispatch_voice_state_update list ]

  type basic_msg = (call_msg, call_reply, cast_msg) Actaa.Gen_server.basic_msg
  type msg = basic_msg

  type state = {
    store : Event.dispatch_voice_state_update StringMap.t StringMap.t;
  }

  class t =
    object
      inherit [init_arg, msg, state] Actaa.Gen_server.behaviour
      method private init _env ~sw:_ () = { store = StringMap.empty }

      method! private handle_call _env ~sw:_ state =
        function
        | `Get (guild_id, user_id) ->
            let vstate =
              let ( >>= ) = Option.bind in
              StringMap.find_opt guild_id state.store
              >>= StringMap.find_opt user_id
            in
            `Reply (`Get vstate, state)
        | `GetAll guild_id ->
            let result =
              StringMap.find_opt guild_id state.store
              |> Option.value ~default:StringMap.empty
            in
            `Reply (`GetAll result, state)

      method! private handle_cast _env ~sw:_ state =
        function
        | `Set (guild_id, user_id, vstate) ->
            let store =
              StringMap.update guild_id
                (function
                  | None -> Some (StringMap.singleton user_id vstate)
                  | Some m -> Some (StringMap.add user_id vstate m))
                state.store
            in
            `NoReply { store }
        | `SetAll (guild_id, src) ->
            let store =
              state.store
              |> StringMap.update guild_id @@ function
                 | None ->
                     src
                     |> List.map
                          (fun (vstate : Event.dispatch_voice_state_update) ->
                            (vstate.user_id, vstate))
                     |> List.to_seq |> StringMap.of_seq |> Option.some
                 | Some m ->
                     src
                     |> List.fold_left
                          (fun m (vstate : Event.dispatch_voice_state_update) ->
                            StringMap.add vstate.user_id vstate m)
                          m
                     |> Option.some
            in
            `NoReply { store }
    end
end

module Voice = Actaa.Registry.Make (struct
  type key = string (* guild_id *)
  type process = Voice_gateway.t

  let compare = String.compare
end)

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
  type basic_msg = (call_msg, call_reply, cast_msg) Actaa.Gen_server.basic_msg
  type msg = basic_msg
  type state = { store : S.value Map.t }

  class t =
    object
      inherit [init_arg, msg, state] Actaa.Gen_server.behaviour
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
  type value = Object.user

  let compare () () = 0
end

module Me = Make (Me_kv)

type t = { me : Me.t; voice_states : Voice_states.t; voice : Voice.t }

let start env ~sw =
  let me = new Me.t in
  let voice_states = new Voice_states.t in
  let voice = new Voice.t in
  Actaa.Gen_server.start env ~sw () me;
  Actaa.Gen_server.start env ~sw () voice_states;
  Actaa.Gen_server.start env ~sw () voice;
  { me; voice_states; voice }

let me { me; _ } =
  match Actaa.Gen_server.call me (`Get ()) with
  | `Get me -> me
  | _ -> assert false

let set_me { me; _ } user = Actaa.Gen_server.cast me (`Set ((), user))

let voice { voice; _ } guild_id =
  match Actaa.Gen_server.call voice (`Lookup guild_id) with
  | `Lookup voice -> voice
  | _ -> assert false

let set_voice_if_not_exists { voice; _ } ~guild_id ~channel_id:_ ~gateway =
  Voice.register voice guild_id gateway

let voice_states { voice_states; _ } ~guild_id ~user_id =
  match Actaa.Gen_server.call voice_states (`Get (guild_id, user_id)) with
  | `Get voice_state -> voice_state
  | _ -> assert false

let all_voice_states { voice_states; _ } ~guild_id =
  match Actaa.Gen_server.call voice_states (`GetAll guild_id) with
  | `GetAll voice_states -> voice_states
  | _ -> assert false

let set_voice_states { voice_states; _ } ~guild_id ~user_id voice_state =
  Actaa.Gen_server.cast voice_states (`Set (guild_id, user_id, voice_state))

let initialize_guild_voice_states { voice_states; _ } ~guild_id src =
  Actaa.Gen_server.cast voice_states (`SetAll (guild_id, src))
