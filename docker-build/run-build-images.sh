#!/bin/bash

if [ $1 = "mindspore-modelzoo" ]; then
    ## 获取数据集和模型
    if [ -d Resnet50_Cifar_for_MindSpore ] || [ -d ../mindspore-modelzoo/Resnet50_Cifar_for_MindSpore ]; then
        rm -rf Resnet50_Cifar_for_MindSpore
        rm -rf ../mindspore-modelzoo/Resnet50_Cifar_for_MindSpore
    fi
    export GIT_SSL_NO_VERIFY=1
    git clone https://gitee.com/mindspore/models.git
    cd models && git checkout r1.9
    mv official/cv/resnet/ ../Resnet50_Cifar_for_MindSpore
    cd .. && rm -rf models
    mkdir -p Resnet50_Cifar_for_MindSpore/data/cifar10
    curl -kO https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
    tar -xf cifar-10-binary.tar.gz && rm -f cifar-10-binary.tar.gz
    mv cifar-10-batches-bin Resnet50_Cifar_for_MindSpore/data/cifar10/
    cp -r Resnet50_Cifar_for_MindSpore ../mindspore-modelzoo/

    ## 构建、推送镜像
    cd ../mindspore-modelzoo
    bash build.sh
    cd -
fi

if [ $1 = "pytorch-modelzoo" ]; then
    if [ -d Resnet50_Cifar_for_PyTorch ] || [ -d ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/ ]; then
        rm -rf Resnet50_Cifar_for_PyTorch/
        rm -rf ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/
    fi
    git clone https://gitee.com/ascend/ModelZoo-PyTorch.git
    mv ModelZoo-PyTorch/PyTorch/built-in/cv/classification/Resnet50_Cifar_for_PyTorch .
    rm -rf ModelZoo-PyTorch
    mkdir -p Resnet50_Cifar_for_PyTorch/data/cifar100
    echo "download dataset cifar100"
    curl -kO https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz
    tar -xf cifar-100-python.tar.gz && rm -f cifar-100-python.tar.gz
    mv cifar-100-python Resnet50_Cifar_for_PyTorch/data/cifar100/
    cp -r Resnet50_Cifar_for_PyTorch ../pytorch-modelzoo/

    ## 构建、推送镜像
    cd ../pytorch-modelzoo
    bash build.sh
    cd -
fi

## 启动镜像后，进行训练
# docker run -it --rm mindspore-modelzoo:4-ubuntu18.04-arm64 bash test_model.sh
