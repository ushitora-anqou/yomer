# Yomer

Yomer is a Discord voice bot to speak out text messages sent to text channels.

## Deploy

The easiest way is to use Docker Compose.

TBD

## Usage

Text `!ymr join` to join Yomer to your voice channel. Yomer will then read all text messages aloud. Use `!ymr leave` to make Yomer leave your channel.

## Build locally

Set up [OPAM](https://opam.ocaml.org/) first. Then, run the following steps:

```
opam switch create --no-install . 5.1.0
opam pin cohttp https://github.com/mirage/ocaml-cohttp.git#v6.0.0_beta1
opam pin cohttp-eio https://github.com/mirage/ocaml-cohttp.git#v6.0.0_beta1
opam pin sodium https://github.com/ahrefs/ocaml-sodium.git#734eccbb47e7545a459a504188f1da8dc0bd018e
opam install . --deps-only
dune build bin/main.exe
```
