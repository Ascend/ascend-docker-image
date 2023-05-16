#!/bin/bash

arch=$(uname -m)

cp -rf /usr1/package330/mindspore-*linux_$(arch).whl .

have_mindspore=$(find . |grep "mindspore"|grep $arch|wc -l)
if [ $have_mindspore == 0 ]; then
    echo "please put mindspore wheel package here"
    exit 1
fi

cp -r /usr1/package330/mindspore-modelzoo-data-model/Resnet50_Cifar_for_MindSpore .

if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=0 docker build -t ascend-mindspore:centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 . || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-mindspore:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    DOCKER_BUILDKIT=0 docker build -t ascend-mindspore:centos7.6-arm64 --build-arg BASE_VERSION=centos7.6-arm64 . || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-mindspore:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . || exit 1
fi