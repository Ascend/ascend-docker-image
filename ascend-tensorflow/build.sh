#!/bin/bash

arch=$(uname -m)
version=$1

have_tensorflow=$(find . |grep "tensorflow"|grep $arch|wc -l)
if [ $arch == "aarch64" ] && [ $have_tensorflow == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

have_tfplugin=$(find . |grep "tfplugin"|grep $arch|wc -l)
if [ $have_tfplugin == 0 ]; then
    echo "please put tfplugin wheel package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build -t ascend-tensorflow:${version}-centos7.6-x64 --build-arg BASE_VERSION=${version}-centos7.6-x64 .  || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-tensorflow:${version}-ubuntu18.04-x64 --build-arg BASE_VERSION=${version}-ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=1 docker build -t ascend-tensorflow:${version}-centos7.6-arm64 --build-arg BASE_VERSION=${version}-centos7.6-arm64 . || exit 1
    DOCKER_BUILDKIT=1 docker build -t ascend-tensorflow:${version}-ubuntu18.04-arm64 --build-arg BASE_VERSION=${version}-ubuntu18.04-arm64 . || exit 1
fi