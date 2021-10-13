FROM centos:7

WORKDIR /tmp
COPY . ./

RUN yum update -y && \
    yum makecache && \
    yum install -y pciutils && \
    yum clean all && \
    rm -rf ./*
