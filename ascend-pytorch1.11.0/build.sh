#!/bin/bash

arch=$(uname -m)

cp -rf /usr1/package930/torch-1.11.0*linux_$(arch).whl .
cp -rf /usr1/package930/torch_npu-1.11.0.post4-cp37-cp37m-linux_$(arch).whl .

have_torch=$(find . |grep "torch-1.11"|grep $arch|wc -l)
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
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:centos7-x64 --build-arg BASE_VERSION=centos7-x64 .  || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:centos7-arm64 --build-arg BASE_VERSION=centos7-arm64 . || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . || exit 1
fi