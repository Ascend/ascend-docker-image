#!/bin/bash

arch=$(uname -m)

if [ ! -d dllogger ];then
    git clone https://github.com/NVIDIA/dllogger.git	
fi

have_apex=$(find . |grep apex|grep $arch|wc -l)
if [ $have_apex == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

have_torch=$(find . |grep "torch-1.8.1"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put pytorch wheel package here"
    exit 1
fi

have_torch_npu=$(find . |grep torch_npu|grep $arch|wc -l)
if [ $have_torch_npu == 0 ]; then
    echo "please put torch_npu wheel package here"
    exit 1
fi

have_toolkit=$(find . |grep cann|grep toolkit|grep $arch|wc -l)
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

if [ ! -d  Resnet50_Cifar_for_PyTorch ];then
    echo "please put Resnet50_Cifar_for_PyTorch here"
    echo "it can be download from https://gitee.com/ascend/ModelZoo-PyTorch/tree/master/PyTorch/built-in/cv/classification/Resnet50_Cifar_for_PyTorch"
fi

if [ ! -f Resnet50_Cifar_for_PyTorch/data/cifar100/cifar-100-python.tar.gz ];then
    mkdir -p Resnet50_Cifar_for_PyTorch/data/cifar100
    echo "download dataset cifar100"
    curl https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz -o Resnet50_Cifar_for_PyTorch/data/cifar100/cifar-100-python.tar.gz
fi


echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1  docker build . -t pytorch-modelzoo
else
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t pytorch-modelzoo
fi
