#!/bin/bash

arch=$(uname -m)
if [ -d ./samples ]; then
    rm -rf ./samples
fi
mkdir -p ./samples/scripts

# 检查mindspore依赖文件
cp -rf /usr1/package330/mindspore-*linux_$(arch).whl .
cp -rf /usr1/package330/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl .

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

cp -rf /usr1/package330/mindspore-modelzoo-data-model/Resnet50_Cifar_for_MindSpore ./samples


# 检查pytorch依赖文件
cp -rf /usr1/package330/apex1.8/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl .
cp -rf /usr1/package330/torch-1.8*linux_$(arch).whl .
cp -rf /usr1/package330/torch_npu-1.8.1.post1-cp37-cp37m-linux_$(arch).whl .


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

cp -rf /usr1/package330/Resnet50_Cifar_for_PyTorch ./samples

# 检查tensorflow依赖文件
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package330/tensorflow-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl .
else
    cp -rf /usr1/package330/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl .
fi

have_tensorflow=$(find . | grep "tensorflow" | grep -c "$arch")
if [ "$have_tensorflow" == 0 ]; then
    echo "please put tensorflow wheel package here"
    exit 1
fi

cp -r /usr1/package330/Keras-MnasNet_ID3518_for_TensorFlow2.X ./samples

echo "start build"
if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1 docker build . -t all-in-one:ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-tfplugin_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1 docker build . -t all-in-one:ubuntu18.04-arm64
fi