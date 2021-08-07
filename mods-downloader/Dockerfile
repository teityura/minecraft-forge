FROM alpine:latest

WORKDIR /
COPY ./mods-download.sh ./mods-download.sh

WORKDIR /mods
ENTRYPOINT ["/mods-download.sh"]
