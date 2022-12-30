FROM ubuntu:18.04

WORKDIR /tmp
COPY . ./

RUN apt update && \
    apt install --no-install-recommends pciutils -y && \
    apt clean && \
    rm -rf ./*
