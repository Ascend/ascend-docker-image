FROM ubuntu:18.04

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh

WORKDIR /tmp
COPY . ./

SHELL ["/bin/bash", "-c"]

RUN { source $SETPROXY || true; } && \
    apt update && \
    apt install --no-install-recommends pciutils -y && \
    apt clean && \
    { source $UNSETPROXY || true; } && \
    rm -rf ./*
    