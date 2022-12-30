FROM centos:7

ARG LIBSTDCXX=libstdc++.so.6.0.24
WORKDIR /tmp
COPY . ./

RUN yum update -y && \
    yum makecache && \
    yum install -y pciutils && \
    yum clean all && \
    rm -rf /var/cache/yum/* && \
    cp -f ./$LIBSTDCXX /lib64/ && \
    chmod +x /lib64/$LIBSTDCXX && \
    ldconfig && \
    rm -rf ./*
