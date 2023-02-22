#!/bin/bash

arch=$(uname -m)

have_mindspore=$(find . |grep "mindspore"|grep $arch|wc -l)
if [ $have_mindspore == 0 ]; then
    echo "please put mindspore wheel package here"
    exit 1
fi

have_elastic=$(find . |grep "mindx_elastic"|grep $arch|wc -l)
if [ $have_elastic == 0 ]; then
    echo "please put mindx_elastic wheel package here"
    exit 1
fi

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

have_toolbox=$(find . |grep cann|grep toolbox|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolbox package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1  docker build . -t mindspore-modelzoo:ubuntu18.04-x64
else
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t mindspore-modelzoo:ubuntu18.04-arm64
fi
