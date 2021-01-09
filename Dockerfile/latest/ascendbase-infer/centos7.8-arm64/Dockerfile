FROM arm64v8/centos:7

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh

WORKDIR /tmp
COPY . ./

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && rm -f $SETPROXY && \
    yum makecache && \
    yum install -y pciutils && \
    yum clean all && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true" && rm -f $UNSETPROXY
