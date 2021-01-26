FROM euleros:2.8

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh
ARG YUM_REPO=EulerOS.repo

WORKDIR /tmp
COPY . ./

SHELL ["/bin/bash", "-c"]

RUN { source $SETPROXY || true; } && \
    mv $YUM_REPO /etc/yum.repos.d/ && \
    yum makecache && \
    yum install -y shadow-utils tar pciutils && \
    yum clean all && \
    rm -f /etc/yum.repos.d/$YUM_REPO && \
    { source $UNSETPROXY || true; } && \
    rm -rf ./*