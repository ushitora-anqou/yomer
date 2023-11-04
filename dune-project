(lang dune 3.10)

(name yomer)

(generate_opam_files true)

(implicit_transitive_deps false)

(source
 (github ushitora-anqou/yomer))

(authors "Ushitora Anqou")

(maintainers "Ushitora Anqou")

(license MIT)

(documentation https://github.com/ushitora-anqou/yomer)

(package
 (name yomer)
 (synopsis "A Discord bot")
 (description "A Discord bot")
 (depends
  alcotest
  ctypes
  ctypes-foreign
  (eio_main
   (>= 0.12))
  jingoo
  mirage-clock-unix
  mirage-crypto-rng-eio
  (ocaml
   (>= 5.0.0))
  ppx_yojson_conv
  tls-eio
  uuseg
  websocket
  x509
  yaml
  yojson
  ;
  ; vvv pinned packages vvv
  ;
  ;cohttp
  ;cohttp-eio
  )
 (tags (discord)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
