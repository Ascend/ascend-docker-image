#!/bin/bash

arch=$(uname -m)

if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package630/tensorflow-1.15.0-cp37-cp37m-manylinux2010_$(arch).whl .
else
    cp -rf /usr1/package630/tensorflow-1.15.0-cp37-cp37m-manylinux2014_$(arch).whl .
fi

have_tensorflow=$(find . |grep "tensorflow"|grep $arch|wc -l)
if [ $have_tensorflow == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

cp -rf /usr1/package630/ResNet50_ID0058_for_TensorFlow .

echo "start build"
if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=1  docker build . -t tensorflow-modelzoo:ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t tensorflow-modelzoo:ubuntu18.04-arm64
fi