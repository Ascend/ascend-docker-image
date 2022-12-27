#!/bin/bash

## 获取mindspore-modelzoo数据集和模型
function get_mindspore_modelzoo_dataset_model()
{
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
    wget https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz
    tar -xf cifar-10-binary.tar.gz && rm -f cifar-10-binary.tar.gz
    mv cifar-10-batches-bin Resnet50_Cifar_for_MindSpore/data/cifar10/
    cp -r Resnet50_Cifar_for_MindSpore ../mindspore-modelzoo/
}

## 获取pytorch1.8.1-modelzoo数据集和模型
function get_pytorch_modelzoo_dataset_model()
{
    if [ -d Resnet50_Cifar_for_PyTorch ] || [ -d ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/ ]; then
        rm -rf Resnet50_Cifar_for_PyTorch/
        rm -rf ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/
    fi
    git clone https://gitee.com/ascend/ModelZoo-PyTorch.git
    mv ModelZoo-PyTorch/PyTorch/built-in/cv/classification/Resnet50_Cifar_for_PyTorch .
    rm -rf ModelZoo-PyTorch
    mkdir -p Resnet50_Cifar_for_PyTorch/data/cifar100
    echo "download dataset cifar100"
    wget https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz
    tar -xf cifar-100-python.tar.gz && rm -f cifar-100-python.tar.gz
    mv cifar-100-python Resnet50_Cifar_for_PyTorch/data/cifar100/
    cp -r Resnet50_Cifar_for_PyTorch ../pytorch-modelzoo/
}

## 获取tensorflow2.6.5-modelzoo数据集和模型
function get_tensorflow265_modelzoo_dataset_model()
{
    if [ -d Keras-MnasNet_ID3518_for_TensorFlow2.X ] || [ -d ../tensorflow2.6.5-modelzoo/Keras-MnasNet_ID3518_for_TensorFlow2.X/ ]; then
        rm -rf Resnet50_Cifar_for_PyTorch/
        rm -rf ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/
    fi
    git clone https://gitee.com/ascend/ModelZoo-TensorFlow.git
    mv ModelZoo-TensorFlow/TensorFlow2/built-in/cv/image_classification/Keras-MnasNet_ID3518_for_TensorFlow2.X/ .
    rm -rf ModelZoo-TensorFlow
    wget http://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
    mkdir -p Keras-MnasNet_ID3518_for_TensorFlow2.X/data
    tar -xf cifar-10-python.tar.gz -C Keras-MnasNet_ID3518_for_TensorFlow2.X/data
    rm -f cifar-10-python.tar.gz
    cp -r Keras-MnasNet_ID3518_for_TensorFlow2.X ../tensorflow2.6.5-modelzoo/
}

## 生成mindspore-modelzoo镜像
function build_mindspore_modelzoo()
{
    ## 获取数据集和模型
    get_mindspore_modelzoo_dataset_model

    ## 构建镜像
    cd ../mindspore-modelzoo
    bash build.sh
    cd -
}

## 生成pytorch-modelzoo镜像
function build_pytorch_modelzoo()
{
    ## 获取数据集和模型
    get_pytorch_modelzoo_dataset_model

    ## 构建镜像
    cd ../pytorch-modelzoo
    bash build.sh
    cd -
}

## 生成pytorch1.5-modelzoo镜像
## 数据集需手动放置到pytorch1.5-modelzoo目录下
function build_pytorch15_modelzoo()
{
    ## 构建镜像
    cd ../pytorch1.5-modelzoo
    bash build.sh
    cd -
}

## 生成tensorflow1.15-modelzoo镜像
## 数据集需手动放置到docker-build下
function build_tensorflow_modelzoo()
{
    if [ -d ResNet50_ID0058_for_TensorFlow ] || [ -d ../tensorflow-modelzoo/Resnet50_Cifar_for_PyTorch/ ]; then
        rm -rf ResNet50_ID0058_for_TensorFlow/
        rm -rf ../tensorflow-modelzoo/ResNet50_ID0058_for_TensorFlow/
    fi
    mkdir data
    git clone https://gitee.com/ascend/ModelZoo-TensorFlow.git
    mv ModelZoo-TensorFlow/TensorFlow/built-in/cv/image_classification/ResNet50_ID0058_for_TensorFlow/ .
    rm -rf ModelZoo-TensorFlow
    mv imagenet2012 data
    # 将数据集放入模型代码目录，数据集存放到data目录
    mv data ResNet50_ID0058_for_TensorFlow/
    cp -r ResNet50_ID0058_for_TensorFlow ../tensorflow-modelzoo
    
    ## 构建镜像
    cd ../tensorflow-modelzoo
    bash build.sh
    cd -
}

## 生成tensorflow2.6.5-modelzoo镜像
function build_tensorflow265_modelzoo()
{
    ## 获取数据集和模型
    get_tensorflow265_modelzoo_dataset_model

    ## 构建镜像
    cd ../tensorflow2.6.5-modelzoo
    bash build.sh
    cd -
}

## 生成infer-modelzoo镜像
## 数据集需手动放置到infer-modelzoo目录下
function build_infer_modelzoo()
{
    cd ../infer-modelzoo
    bash build.sh
    cd -
}

## 生成infer-modelzoo-mxvision镜像
## 数据集需手动放置到infer-modelzoo-mxvision目录下
function build_infer_modelzoo_mxvision()
{
    cd ../infer-modelzoo-mxvision
    bash build.sh
    cd -
}

## 生成三合一镜像
function all_in_one()
{
    ## 获取mindspore-modelzoo数据集和模型
    get_mindspore_modelzoo_dataset_model
    
    ## 获取pytorch-modelzoo数据集和模型
    get_pytorch_modelzoo_dataset_model

    ## 获取tensorflow-modelzoo数据集和模型
    get_tensorflow265_modelzoo_dataset_model

    ## 构建镜像
    cd ../all-in-one
    bash build.sh
    cd -
}

main()
{
    if [ $1 = "mindspore-modelzoo" ]; then
        build_mindspore_modelzoo
    fi

    if [ $1 = "pytorch-modelzoo" ]; then
        build_pytorch_modelzoo
    fi

    if [ $1 = "pytorch1.5-modelzoo" ]; then
        build_pytorch15_modelzoo
    fi

    # if [ $1 = "tensorflow-modelzoo" ]; then
    #     build_tensorflow_modelzoo
    # fi

    if [ $1 = "tensorflow2.6.5-modelzoo" ]; then
        build_tensorflow265_modelzoo
    fi

    if [ $1 = "infer-modelzoo" ]; then
        build_infer_modelzoo
    fi

    if [ $1 = "infer-modelzoo-mxvision" ]; then
        build_infer_modelzoo_mxvision
    fi

    if [ $1 = "all-in-one" ]; then
        all_in_one
    fi

    if [ $1 = "all" ]; then
        build_mindspore_modelzoo
        build_pytorch_modelzoo
        build_pytorch15_modelzoo
        build_tensorflow_modelzoo
        build_tensorflow265_modelzoo
        build_infer_modelzoo
        build_infer_modelzoo_mxvision
    fi
}

main "$1"

## 启动镜像后，进行训练
# docker run -it --rm mindspore-modelzoo:4-ubuntu18.04-arm64 bash test_model.sh
