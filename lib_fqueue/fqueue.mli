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

module Batched : S
module Realtime : S
module Bootstrapped : S
