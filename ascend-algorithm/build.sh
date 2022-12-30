#!/bin/bash

arch=$(uname -m)
version=$1

have_nnrt=$(find . |grep cann|grep nnrt|grep $arch|wc -l)
if [ $have_nnrt == 0 ]; then
    echo "please put nnrt package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    docker build -t ascend-algorithm:${version}-centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 . || exit 1
    docker build -t ascend-algorithm:${version}-ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
    docker build -t ascend-algorithm:${version}-openeuler20.03-x64 --build-arg BASE_VERSION=openeuler20.03-x64 . || exit 1
else
    docker build -t ascend-algorithm:${version}-centos7.6-arm64 --build-arg BASE_VERSION=centos7.6-arm64 . || exit 1
    docker build -t ascend-algorithm:${version}-ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . || exit 1
    docker build -t ascend-algorithm:${version}-openeuler20.03-arm64 --build-arg BASE_VERSION=openeuler20.03-arm64 . || exit 1
fi