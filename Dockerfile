FROM ocaml/opam:debian-11-ocaml-5.0

ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && apt-get install -y \
    libssl-dev libpcre2-dev pkg-config libgmp-dev libffi-dev libsodium-dev libopus-dev \
    && rm -rf /var/lib/apt/lists/*

USER opam
WORKDIR /home/opam/yomer
RUN opam-2.1 update && \
    opam-2.1 pin websocket "https://github.com/ushitora-anqou/ocaml-websocket.git#eio" && \
    opam-2.1 pin websocket-eio "https://github.com/ushitora-anqou/ocaml-websocket.git#eio" && \
    opam-2.1 pin sodium "https://github.com/ushitora-anqou/ocaml-sodium.git#yomer"

COPY --chown=opam yomer.opam .
RUN opam-2.1 install . --deps-only
COPY --chown=opam . .
RUN eval $(opam-2.1 env) && opam-2.1 install . --deps-only && dune build bin/main.exe

FROM debian:11-slim

RUN apt-get update && apt-get install -y \
    libpq5 libgmp10 netbase ca-certificates libsodium23 libopus0 ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/
COPY --from=0 /home/opam/yomer/_build/default/bin/main.exe ./yomer

CMD /root/yomer /config.yaml