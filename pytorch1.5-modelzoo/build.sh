#!/bin/bash

arch=$(uname -m)

if [ ! -d dllogger ];then
    git clone https://gitee.com/mirrors_NVIDIA/dllogger
fi

have_apex=$(find . |grep apex|grep $arch|wc -l)
if [ $have_apex == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

have_torch=$(find . |grep "torch-1.5.0"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put pytorch wheel package here"
    exit 1
fi

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1  docker build . -t pytorch1.5-modelzoo:ubuntu18.04-x64
else
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t pytorch1.5-modelzoo:ubuntu18.04-arm64
fi
