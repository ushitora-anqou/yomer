let random_string len = Mirage_crypto_rng.generate len |> Cstruct.to_string
