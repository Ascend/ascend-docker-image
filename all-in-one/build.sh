#!/bin/bash

arch=$(uname -m)

# 检查mindspore依赖文件
have_mindspore=$(find . | grep "mindspore" | grep -c "$arch")
if [ "$have_mindspore" == 0 ]; then
    echo "please put mindspore wheel package here"
    exit 1
fi

have_elastic=$(find . | grep "mindx_elastic" | grep -c "$arch")
if [ "$have_elastic" == 0 ]; then
    echo "please put mindx_elastic wheel package here"
    exit 1
fi

if [ ! -d samples/Resnet50_Cifar_for_MindSpore ]; then
    echo "please put Resnet50_Cifar_for_MindSpore here"
    echo "it can be download from https://gitee.com/mindspore/models/tree/master/official/cv/ResNet"
    exit 1
fi

if [ ! -d samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin ]; then
    mkdir -p samples/Resnet50_Cifar_for_MindSpore/data/cifar10
    echo "download dataset cifar10"
    wget --no-check-certificate https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
    tar -xf cifar-10-binary.tar.gz -C samples/Resnet50_Cifar_for_MindSpore/data/cifar10
fi

have_toolkit=$(find . | grep cann | grep toolkit | grep -c "$arch")
if [ "$have_toolkit" == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

# 检查pytorch依赖文件
if [ ! -d dllogger ]; then
    git clone https://gitee.com/mirrors_NVIDIA/dllogger
fi

have_apex=$(find . | grep apex | grep -c "$arch")
if [ "$have_apex" == 0 ]; then
    echo "please put apex package here"
    exit 1
fi

have_torch=$(find . | grep "torch-1.8" | grep -c "$arch")
if [ "$have_torch" == 0 ]; then
    echo "please put pytorch wheel package here"
    exit 1
fi

have_torch_npu=$(find . | grep torch_npu | grep -c "$arch")
if [ "$have_torch_npu" == 0 ]; then
    echo "please put torch_npu wheel package here"
    exit 1
fi

if [ ! -d samples/Resnet50_Cifar_for_PyTorch ]; then
    echo "please put Resnet50_Cifar_for_PyTorch here"
    echo "it can be download from https://gitee.com/ascend/ModelZoo-PyTorch/tree/master/PyTorch/built-in/cv/classification/Resnet50_Cifar_for_PyTorch"
    exit 1
fi

if [ ! -d samples/Resnet50_Cifar_for_PyTorch/data/cifar100/cifar-100-python ]; then
    mkdir -p samples/Resnet50_Cifar_for_PyTorch/data/cifar100
    echo "download dataset cifar100"
    wget --no-check-certificate https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz
    tar -xf cifar-100-python.tar.gz -C samples/Resnet50_Cifar_for_PyTorch/data/cifar100
fi

# 检查tensorflow依赖文件
have_tfplugin=$(find . | grep cann | grep tfplugin | grep -c "$arch")
if [ "$have_tfplugin" == 0 ]; then
    echo "please put tfplugin package here"
    exit 1
fi

have_tensorflow=$(find . | grep "tensorflow" | grep -c "$arch")
if [ "$have_tensorflow" == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

if [ ! -d samples/Keras-MnasNet_ID3518_for_TensorFlow2.X ]; then
    echo "please put Keras-MnasNet_ID3518_for_TensorFlow2.X here"
    echo "it can be download from https://gitee.com/ascend/ModelZoo-TensorFlow/tree/master/TensorFlow2/built-in/cv/image_classification/Keras-MnasNet_ID3518_for_TensorFlow2.X"
    exit 1
fi

if [ ! -d samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/cifar-10-batches-py ]; then
    mkdir -p samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10
    echo "download dataset cifar10"
    wget --no-check-certificate https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    tar -xf cifar-10-python.tar.gz -C samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10
fi

echo "start build"
if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build . -t all-in-one:ubuntu18.04-x64
else
    DOCKER_BUILDKIT=1 docker build . -t all-in-one:ubuntu18.04-arm64
fi