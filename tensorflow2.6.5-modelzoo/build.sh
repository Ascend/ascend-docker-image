#!/bin/bash

arch=$(uname -m)

if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package630/tensorflow-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl .
else
    cp -rf /usr1/package630/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl .
    cp -rf /usr1/package630/h5py-3.1.0-cp37-cp37m-manylinux2014_aarch64.whl .
fi

have_h5py=$(find . |grep "h5py"|grep $arch|wc -l)
if [ $(arch) == "aarch64" ] && [ have_h5py == 0 ]; then
    echo "please put h5py wheel package here"
    exit 1
fi

have_tensorflow=$(find . |grep "tensorflow"|grep $arch|wc -l)
if [ $have_tensorflow == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

cp -rf /usr1/package630/Keras-MnasNet_ID3518_for_TensorFlow2.X .
cp -rf /usr1/package630/ResNet50_ID0360_for_TensorFlow2.X .

echo "start build"
if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=1  docker build . -t tensorflow2.6.5-modelzoo:ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package630/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910_6.3.RC2_linux.run .
    cp -rf /usr1/package630/Ascend-cann-kernels-910b_6.3.RC2_linux.run .
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t tensorflow2.6.5-modelzoo:ubuntu18.04-arm64
fi