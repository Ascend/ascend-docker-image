#!/bin/bash

arch=$(uname -m)

if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package930/lib-$(arch)/libstdc++.so.6.0.24 ./centos7.6-x64/
else
    cp -rf /usr1/package930/lib-$(arch)/libstdc++.so.6.0.24 ./centos7.9-arm64/
fi

have_libstdc=$(find centos7* |grep "libstdc++.so"|wc -l)
if [ $have_libstdc == 0 ]; then
    echo "please put libstdc++.so wheel package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    cd ubuntu18.04-x64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-infer:ubuntu18.04-x64 . || exit 1
    cd ../centos7.6-x64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-infer:centos7.6-x64 . || exit 1
else
    cd ubuntu18.04-arm64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-infer:ubuntu18.04-arm64 . || exit 1
    cd ../centos7.9-arm64
    DOCKER_BUILDKIT=1  docker build -t ascendbase-infer:centos7.9-arm64 . || exit 1
fi
