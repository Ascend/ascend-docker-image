#!/bin/bash

arch=$(uname -m)

if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package630/tensorflow-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl .
else
    cp -rf /usr1/package630/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl .
    cp -rf /usr1/package630/h5py-3.1.0-cp37-cp37m-manylinux2014_aarch64.whl .
fi

cp -r /usr1/package630/Keras-MnasNet_ID3518_for_TensorFlow2.X .

have_tensorflow=$(find . |grep "tensorflow"|grep $arch|wc -l)
if [ $arch == "aarch64" ] && [ $have_tensorflow == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-tfplugin*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    DOCKER_BUILDKIT=0 docker build -t ascend-tensorflow:centos7.6-x64 --build-arg BASE_VERSION=centos7.6-x64 .  || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-tensorflow:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 . || exit 1
else
    rm -f Ascend-cann-tfplugin*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    DOCKER_BUILDKIT=0 docker build -t ascend-tensorflow:centos7.9-arm64 --build-arg BASE_VERSION=centos7.9-arm64 . -f Dockerfile_aarch64 || exit 1
    DOCKER_BUILDKIT=0 docker build -t ascend-tensorflow:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . -f Dockerfile_aarch64 || exit 1
fi