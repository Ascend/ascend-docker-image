#!/bin/bash

arch=$(uname -m)
version=$1

have_apex=$(find . |grep apex|grep $arch|wc -l)
if [ $have_apex == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

have_torch=$(find . |grep "torch-1.8.1"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put pytorch wheel package here"
    exit 1
fi

have_torch_npu=$(find . |grep torch_npu|grep $arch|wc -l)
if [ $have_torch_npu == 0 ]; then
    echo "please put torch_npu wheel package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build -t ascend-pytorch:${version}-centos7.6-x64 --build-arg BASE_VERSION=${version}-centos7.6-x64 .  || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-pytorch:${version}-ubuntu18.04-x64 --build-arg BASE_VERSION=${version}-ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=1 docker build -t ascend-pytorch:${version}-centos7.6-arm64 --build-arg BASE_VERSION=${version}-centos7.6-arm64 . || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-pytorch:${version}-ubuntu18.04-arm64 --build-arg BASE_VERSION=${version}-ubuntu18.04-arm64 . || exit 1
fi