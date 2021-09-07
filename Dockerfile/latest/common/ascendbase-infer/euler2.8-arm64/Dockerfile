FROM euleros:2.8

ARG YUM_REPO=EulerOS.repo

WORKDIR /tmp
COPY . ./

RUN mv $YUM_REPO /etc/yum.repos.d/ && \
    yum update -y && \
    yum makecache && \
    yum install -y shadow-utils tar pciutils && \
    yum clean all && \
    rm -f /etc/yum.repos.d/$YUM_REPO && \
    rm -rf ./*
