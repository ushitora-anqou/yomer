exception Empty

module type PFDS = sig
  type 'a t

  val empty : 'a t
  val is_empty : 'a t -> bool
  val snoc : 'a t -> 'a -> 'a t
  val head : 'a t -> 'a
  val tail : 'a t -> 'a t
end

module Stream = struct
  type 'a cell = Nil | Cons of 'a * 'a t
  and 'a t = 'a cell Lazy.t
end

module Batched_PFDS : PFDS = struct
  type 'a t = 'a list * 'a list

  let empty = ([], [])
  let is_empty (f, _) = f = []
  let check_f = function [], r -> (List.rev r, []) | q -> q
  let snoc (f, r) x = check_f (f, x :: r)
  let head = function [], _ -> raise Empty | x :: _, _ -> x
  let tail = function [], _ -> raise Empty | _ :: f, r -> check_f (f, r)
end

module Realtime_PFDS : PFDS = struct
  type 'a t = 'a Stream.t * 'a list * 'a Stream.t

  let empty = (lazy Stream.Nil, [], lazy Stream.Nil)
  let is_empty = function (lazy Stream.Nil), _, _ -> true | _ -> false

  let rec rotate = function
    | (lazy Stream.Nil), y :: _, a -> lazy (Stream.Cons (y, a))
    | (lazy (Stream.Cons (x, xs))), y :: ys, a ->
        lazy (Stream.Cons (x, rotate (xs, ys, lazy (Stream.Cons (y, a)))))
    | _ -> assert false

  let exec = function
    | f, r, (lazy (Stream.Cons (_, s))) -> (f, r, s)
    | f, r, (lazy Stream.Nil) ->
        let f' = rotate (f, r, lazy Stream.Nil) in
        (f', [], f')

  let snoc (f, r, s) x = exec (f, x :: r, s)

  let head = function
    | (lazy Stream.Nil), _, _ -> raise Empty
    | (lazy (Stream.Cons (x, _))), _, _ -> x

  let tail = function
    | (lazy Stream.Nil), _, _ -> raise Empty
    | (lazy (Stream.Cons (_, f))), r, s -> exec (f, r, s)
end

module Bootstrapped_PFDS : PFDS = struct
  type 'a t = E | Q of (int * 'a list * 'a list Lazy.t t * int * 'a list)

  let empty = E
  let is_empty = function E -> true | _ -> false

  let rec check_q : type a. int * a list * a list Lazy.t t * int * a list -> a t
      =
   fun ((lenfm, f, m, lenr, r) as q) ->
    if lenr <= lenfm then check_f q
    else check_f (lenfm + lenr, f, snoc m (lazy (List.rev r)), 0, [])

  and check_f : type a. int * a list * a list Lazy.t t * int * a list -> a t =
    function
    | _, [], E, _, _ -> E
    | lenfm, [], m, lenr, r -> Q (lenfm, Lazy.force (head m), tail m, lenr, r)
    | q -> Q q

  and snoc : type a. a t -> a -> a t =
   fun q x ->
    match q with
    | E -> Q (1, [ x ], E, 0, [])
    | Q (lenfm, f, m, lenr, r) -> check_q (lenfm, f, m, lenr + 1, x :: r)

  and head : type a. a t -> a = function
    | E -> raise Empty
    | Q (_, x :: _, _, _, _) -> x
    | _ -> assert false

  and tail : type a. a t -> a t = function
    | E -> raise Empty
    | Q (lenfm, _ :: f', m, lenr, r) -> check_q (lenfm - 1, f', m, lenr, r)
    | _ -> assert false
end

module type S = sig
  type 'a t

  exception Empty

  val create : unit -> 'a t
  val add : 'a t -> 'a -> 'a t
  val push : 'a t -> 'a -> 'a t
  val take : 'a t -> 'a * 'a t
  val take_opt : 'a t -> 'a option * 'a t
  val pop : 'a t -> 'a * 'a t
  val peek : 'a t -> 'a
  val peek_opt : 'a t -> 'a option
  val top : 'a t -> 'a
  val is_empty : 'a t -> bool
end

module Extend (Q : PFDS) : S = struct
  type 'a t = 'a Q.t

  exception Empty = Empty

  let create () = Q.empty
  let add = Q.snoc
  let push = Q.snoc
  let take q = (Q.head q, Q.tail q)
  let take_opt q = try (Some (Q.head q), Q.tail q) with Empty -> (None, q)
  let pop = take
  let peek = Q.head
  let peek_opt q = try Some (Q.head q) with Empty -> None
  let top = peek
  let is_empty = Q.is_empty
end

module Batched = Extend (Batched_PFDS)
module Realtime = Extend (Realtime_PFDS)
module Bootstrapped = Extend (Bootstrapped_PFDS)
