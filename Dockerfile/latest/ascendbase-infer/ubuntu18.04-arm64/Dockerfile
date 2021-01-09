FROM ubuntu:18.04

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh

WORKDIR /tmp
COPY . ./

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && rm -f $SETPROXY && \
    apt update && \
    apt install --no-install-recommends pciutils -y && \
    apt clean && \
    if [ ! -d "/lib64" ]; \
    then \
        mkdir /lib64 && ln -sf /lib/ld-linux-aarch64.so.1 /lib64/ld-linux-aarch64.so.1; \
    fi && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true" && rm -f $UNSETPROXY
