FROM centos:7.6.1810

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
    