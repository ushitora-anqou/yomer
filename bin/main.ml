let load_config config_path =
  let ic = open_in_bin config_path in
  let config_src = In_channel.input_all ic in
  close_in ic;
  let yaml =
    match Yaml.of_string config_src with
    | Error (`Msg msg) -> failwith ("Failed to load config: " ^ msg)
    | Ok yaml -> yaml
  in
  match Yomer.Config.of_yaml yaml with
  | Error (`Msg msg) -> failwith ("Failed to parse config: " ^ msg)
  | Ok yaml -> yaml

let () =
  Yomer.Logg.setup ();

  if Array.length Sys.argv < 2 then
    failwith (Printf.sprintf "Usage: %s CONFIG_PATH\n" Sys.argv.(0));

  let config_path = Sys.argv.(1) in
  let config = load_config config_path in

  Eio_main.run @@ fun env ->
  Mirage_crypto_rng_eio.run (module Mirage_crypto_rng.Fortuna) env @@ fun () ->
  Eio.Switch.run @@ fun sw -> Yomer.Consumer.start env ~sw ~config
