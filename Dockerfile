FROM ocaml/opam:debian-11-ocaml-5.0

ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && apt-get install -y \
    libssl-dev libpcre2-dev pkg-config libgmp-dev libffi-dev libsodium-dev libopus-dev \
    && rm -rf /var/lib/apt/lists/*

USER opam
WORKDIR /home/opam/yomer
RUN opam-2.1 update && \
    opam-2.1 pin cohttp "https://github.com/mirage/ocaml-cohttp.git#v6.0.0_beta1" && \
    opam-2.1 pin cohttp-eio "https://github.com/mirage/ocaml-cohttp.git#v6.0.0_beta1" && \
    opam-2.1 pin sodium "https://github.com/ahrefs/ocaml-sodium.git#734eccbb47e7545a459a504188f1da8dc0bd018e" && \
    opam-2.1 pin discord "https://github.com/ushitora-anqou/discordml.git#master"

COPY --chown=opam yomer.opam .
RUN opam-2.1 install . --deps-only
COPY --chown=opam . .
RUN opam-2.1 install . --deps-only

ARG YOMER_VERSION
ARG YOMER_REVISION
RUN eval $(opam-2.1 env) && REVISION="REVISION $YOMER_REVISION" VERSION="VERSION $YOMER_VERSION" dune build bin/main.exe

FROM debian:11-slim

RUN apt-get update && apt-get install -y \
    libpq5 libgmp10 netbase ca-certificates libsodium23 libopus0 ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/
COPY --from=0 /home/opam/yomer/_build/default/bin/main.exe ./yomer

CMD /root/yomer /config.yaml
