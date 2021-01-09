FROM euleros:2.8

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh
ARG YUM_REPO=EulerOS.repo

WORKDIR /tmp
COPY . ./

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && rm -f $SETPROXY && \
    mv $YUM_REPO /etc/yum.repos.d/ && \
    yum makecache && \
    yum install -y shadow-utils tar pciutils && \
    yum clean all && \
    rm -f /etc/yum.repos.d/$YUM_REPO && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true" && rm -f $UNSETPROXY
