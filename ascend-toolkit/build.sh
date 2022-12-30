#!/bin/bash

arch=$(uname -m)
version=$1

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build -t ascend-toolkit:${version}-centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 . || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-toolkit:${version}-ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=1 docker build -t ascend-toolkit:${version}-centos7.6-arm64 --build-arg BASE_VERSION=centos7.6-arm64 . || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-toolkit:${version}-ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . || exit 1
fi