let () =
  Eio_main.run @@ fun env ->
  let res = Cohttp_eio.Client.get env ~host:"www.example.org" "/" in
  print_string @@ Cohttp_eio.Client.read_fixed res
