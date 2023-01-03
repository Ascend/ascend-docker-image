#!/bin/bash

arch=$(uname -m)

have_libstdc=$(find centos7.6* |grep "libstdc++.so"|wc -l)
if [ $have_libstdc == 0 ]; then
    echo "please put libstdc++.so wheel package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    cd ubuntu18.04-x64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:ubuntu18.04-x64 . || exit 1
    cd ../centos7.6-x64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:centos7.6-x64 . || exit 1
    cd ../openeuler20.03-x64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:openeuler20.03-x64 . || exit 1
else
    cd ubuntu18.04-arm64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:ubuntu18.04-arm64 . || exit 1
    cd ../centos7.6-arm64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:centos7.6-arm64 . || exit 1
    cd ../openeuler20.03-arm64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-toolkit:openeuler20.03-arm64 . || exit 1
fi
