#!/bin/bash

arch=$(uname -m)

have_tfplugin=$(find . |grep cann|grep tfplugin|grep $arch|wc -l)
if [ $have_tfplugin == 0 ]; then
    echo "please put tfplugin package here"
    exit 1
fi

have_tensorflow=$(find . |grep "tensorflow"|grep $arch|wc -l)
if [ $have_tensorflow == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1  docker build . -t tensorflow-modelzoo:ubuntu18.04-x64
else
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t tensorflow-modelzoo:ubuntu18.04-arm64
fi