#!/bin/bash

arch=$(uname -m)

cp -rf /usr1/package330/apex1.8/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl .
cp -rf /usr1/package330/torch-1.8*linux_$(arch).whl .
cp -rf /usr1/package330/torch_npu-1.8.1.post1-cp37-cp37m-linux_$(arch).whl .
cp -rf /usr1/package330/Resnet50_Cifar_for_PyTorch .
cp -rf /usr1/package330/ResNet50_for_PyTorch .

if [ ! -d dllogger ];then
    git clone https://gitee.com/mirrors_NVIDIA/dllogger
fi

have_apex=$(find . |grep apex|grep $arch|wc -l)
if [ $have_apex == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

have_torch=$(find . |grep "torch-1.8"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put pytorch wheel package here"
    exit 1
fi

have_torch_npu=$(find . |grep torch_npu|grep $arch|wc -l)
if [ $have_torch_npu == 0 ]; then
    echo "please put torch_npu wheel package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1  docker build . -t pytorch-modelzoo:ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t pytorch-modelzoo:ubuntu18.04-arm64
fi
