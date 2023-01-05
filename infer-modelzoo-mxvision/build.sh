#!/bin/bash

arch=$(uname -m)

have_mxvision=$(find . |grep "mxvision"|grep $arch|wc -l)
if [ $have_mxvision == 0 ]; then
    echo "please put mxvision wheel package here"
    exit 1
fi

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build . -t infer-modelzoo-mxvision:ubuntu18.04-x64
else
    DOCKER_BUILDKIT=1 docker build . -f Dockerfile_aarch64 -t infer-modelzoo-mxvision:ubuntu18.04-arm64
fi
