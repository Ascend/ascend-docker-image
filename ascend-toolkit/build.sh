#!/bin/bash

arch=$(uname -m)

if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=0 docker build -t ascend-toolkit:centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 . || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-toolkit:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=0 docker build -t ascend-toolkit:centos7.9-arm64 --build-arg BASE_VERSION=centos7.9-arm64 . -f Dockerfile_aarch64|| exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-toolkit:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . -f Dockerfile_aarch64|| exit 1
fi