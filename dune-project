(lang dune 3.10)

(name yomer)

(generate_opam_files true)

(implicit_transitive_deps false)

(source
 (github ushitora-anqou/yomer))

(authors "Ushitora Anqou")

(maintainers "Ushitora Anqou")

(license LICENSE)

(documentation https://github.com/ushitora-anqou/yomer)

(package
 (name yomer)
 (synopsis "A Discord bot")
 (description "A Discord bot")
 (depends
  (cohttp
   (>= 6.0.0~alpha2))
  (cohttp-eio
   (>= 6.0.0~alpha2))
  eio_main
  (ocaml
   (>= 5.0.0)))
 (tags (discord)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
