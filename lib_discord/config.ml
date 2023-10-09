type t = { token : string; intents : int; voice_provider_endpoint : string }
[@@deriving make]

let token { token; _ } = token
let intents { intents; _ } = intents

let voice_provider_endpoint { voice_provider_endpoint; _ } =
  voice_provider_endpoint
