type t = { token : string; intents : int } [@@deriving make]

let token { token; _ } = token
let intents { intents; _ } = intents
