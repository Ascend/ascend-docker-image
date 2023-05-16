#!/bin/bash

arch=$(uname -m)

cp -rf /usr1/package330/apex1.11/apex-0.1_ascend-cp37-cp37m-linux_$(arch).whl .
cp -rf /usr1/package330/torch-1.11.0*linux_$(arch).whl .
cp -rf /usr1/package330/torch_npu-1.11.0-cp37-cp37m-linux_$(arch).whl .

cp -rf /usr1/package330/Resnet50_Cifar_for_PyTorch .

have_apex=$(find . |grep apex|grep $arch|wc -l)
if [ $have_apex == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

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
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 .  || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:centos7.6-arm64 --build-arg BASE_VERSION=centos7.6-arm64 . || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-pytorch1.11.0:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . || exit 1
fi