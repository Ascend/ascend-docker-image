FROM centos:7.6.1810

WORKDIR /tmp
COPY . ./

RUN yum update -y && \
    yum makecache && \
    yum install -y pciutils && \
    yum clean all && \
    rm -rf ./*
