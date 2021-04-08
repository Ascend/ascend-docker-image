FROM arm64v8/centos:7

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh

WORKDIR /tmp
COPY . ./

SHELL ["/bin/bash", "-c"]

RUN { source $SETPROXY || true; } && \
    yum makecache && \
    yum install -y pciutils && \
    yum clean all && \
    { source $UNSETPROXY || true; } && \
    rm -rf ./*
    