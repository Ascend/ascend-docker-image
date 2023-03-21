#!/bin/bash

## 获取mindspore-modelzoo数据集和模型
function get_mindspore_modelzoo_dataset_model()
{
    if [ -d ../mindspore-modelzoo/Resnet50_Cifar_for_MindSpore ]; then
        rm -rf ../mindspore-modelzoo/Resnet50_Cifar_for_MindSpore
    fi
    if [ -d ../mindspore-modelzoo/Resnet50_imagenet2012_for_MindSpore ]; then
        rm -rf ../mindspore-modelzoo/Resnet50_imagenet2012_for_MindSpore
    fi
    if [ -d ../mindspore-modelzoo/vpc_resnet50_imagenet_classification ]; then
        rm -rf ../mindspore-modelzoo/vpc_resnet50_imagenet_classification
    fi
    if [[ $1 = "all-in-one" ]]; then
        cp -r Resnet50_Cifar_for_MindSpore ../all-in-one/samples
        return
    fi
    cp -r Resnet50_Cifar_for_MindSpore ../mindspore-modelzoo/
    cp -r Resnet50_imagenet2012_for_MindSpore ../mindspore-modelzoo/
    cp -r vpc_resnet50_imagenet_classification ../mindspore-modelzoo/
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
    tar -xf cifar-100-python.tar.gz
    mv cifar-100-python Resnet50_Cifar_for_PyTorch/data/cifar100/
    if [[ $1 = "all-in-one" ]]; then
        cp -r Resnet50_Cifar_for_PyTorch ../all-in-one/samples
        return
    fi
    cp -r Resnet50_Cifar_for_PyTorch ../pytorch-modelzoo/
}

## 获取tensorflow2.6.5-modelzoo数据集和模型
function get_tensorflow265_modelzoo_dataset_model()
{
    if [ -d Keras-MnasNet_ID3518_for_TensorFlow2.X ] || [ -d ../tensorflow2.6.5-modelzoo/Keras-MnasNet_ID3518_for_TensorFlow2.X/ ]; then
        rm -rf Keras-MnasNet_ID3518_for_TensorFlow2.X/
        rm -rf ../tensorflow2.6.5-modelzoo/Keras-MnasNet_ID3518_for_TensorFlow2.X/
    fi
    git clone https://gitee.com/ascend/ModelZoo-TensorFlow.git
    mv ModelZoo-TensorFlow/TensorFlow2/built-in/cv/image_classification/Keras-MnasNet_ID3518_for_TensorFlow2.X/ .
    rm -rf ModelZoo-TensorFlow
    mkdir -p Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10
    tar -xf cifar-10-python.tar.gz -C Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/
    if [[ $1 = "all-in-one" ]]; then
        cp -r Keras-MnasNet_ID3518_for_TensorFlow2.X ../all-in-one/samples
        return
    fi
    cp -r Keras-MnasNet_ID3518_for_TensorFlow2.X ../tensorflow2.6.5-modelzoo/
    rm -rf ../tensorflow2.6.5-modelzoo/ResNet50_ID0360_for_TensorFlow2.X
    cp -rf /usr1/package/ResNet50_ID0360_for_TensorFlow2.X ../tensorflow2.6.5-modelzoo/
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
    if [ -d ResNet50_ID0058_for_TensorFlow ] || [ -d ../tensorflow-modelzoo/ResNet50_ID0058_for_TensorFlow/ ]; then
        rm -rf ResNet50_ID0058_for_TensorFlow/
        rm -rf ../tensorflow-modelzoo/ResNet50_ID0058_for_TensorFlow/
    fi
    cp -rf /usr1/package/ResNet50_ID0058_for_TensorFlow .
    mkdir data
    unzip imagenet2012.zip
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
    if [ -d ../all-in-one/samples ]; then
        rm -rf ../all-in-one/samples
    fi
    mkdir -p ../all-in-one/samples

    ## 获取mindspore-modelzoo数据集和模型
    get_mindspore_modelzoo_dataset_model all-in-one
    
    ## 获取pytorch-modelzoo数据集和模型
    get_pytorch_modelzoo_dataset_model all-in-one

    ## 获取tensorflow-modelzoo数据集和模型
    get_tensorflow265_modelzoo_dataset_model all-in-one

    ## 构建镜像
    cd ../all-in-one
    bash build.sh
    cd -
}

## 生成ascend-algorithm镜像
function build_ascend_algorithm()
{
    cd ../ascend-algorithm
    bash build.sh
    cd -
}

## 生成ascend-infer镜像
function build_ascend_infer()
{
    cd ../ascend-infer
    bash build.sh
    cd -
}

## 生成ascend-mindspore镜像
function build_ascend_mindspore()
{
    ## 获取数据集和模型
    if [ -d Resnet50_Cifar_for_MindSpore ] || [ -d ../ascend-mindspore/Resnet50_Cifar_for_MindSpore ]; then
        rm -rf Resnet50_Cifar_for_MindSpore
        rm -rf ../ascend-mindspore/Resnet50_Cifar_for_MindSpore
    fi
    export GIT_SSL_NO_VERIFY=1
    git clone https://gitee.com/mindspore/models.git
    cd models && git checkout r1.9
    mv official/cv/resnet/ ../Resnet50_Cifar_for_MindSpore
    cd .. && rm -rf models
    mkdir -p Resnet50_Cifar_for_MindSpore/data/cifar10
    tar -xf cifar-10-binary.tar.gz
    mv cifar-10-batches-bin Resnet50_Cifar_for_MindSpore/data/cifar10/
    cp -r Resnet50_Cifar_for_MindSpore ../ascend-mindspore/

    ## 构建镜像
    cd ../ascend-mindspore
    bash build.sh
    cd -
}

## 生成ascend-tensorflow镜像
function build_ascend_tensorflow()
{
    ## 获取数据集和模型
    if [ -d Keras-MnasNet_ID3518_for_TensorFlow2.X ] || [ -d ../ascend-tensorflow/Keras-MnasNet_ID3518_for_TensorFlow2.X/ ]; then
        rm -rf Keras-MnasNet_ID3518_for_TensorFlow2.X/
        rm -rf ../ascend-tensorflow/Keras-MnasNet_ID3518_for_TensorFlow2.X/
    fi
    git clone https://gitee.com/ascend/ModelZoo-TensorFlow.git
    mv ModelZoo-TensorFlow/TensorFlow2/built-in/cv/image_classification/Keras-MnasNet_ID3518_for_TensorFlow2.X/ .
    rm -rf ModelZoo-TensorFlow
    mkdir -p Keras-MnasNet_ID3518_for_TensorFlow2.X/data
    tar -xf cifar-10-python.tar.gz -C Keras-MnasNet_ID3518_for_TensorFlow2.X/data
    cp -r Keras-MnasNet_ID3518_for_TensorFlow2.X ../ascend-tensorflow/

    ## 构建镜像
    cd ../ascend-tensorflow
    bash build.sh
    cd -
}

## 生成ascend-pytorch镜像
function build_ascend_pytorch()
{
    ## 获取数据集和模型
    if [ -d Resnet50_Cifar_for_PyTorch ] || [ -d ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/ ]; then
        rm -rf Resnet50_Cifar_for_PyTorch/
        rm -rf ../pytorch-modelzoo/Resnet50_Cifar_for_PyTorch/
    fi
    git clone https://gitee.com/ascend/ModelZoo-PyTorch.git
    mv ModelZoo-PyTorch/PyTorch/built-in/cv/classification/Resnet50_Cifar_for_PyTorch .
    rm -rf ModelZoo-PyTorch
    mkdir -p Resnet50_Cifar_for_PyTorch/data/cifar100
    echo "download dataset cifar100"
    tar -xf cifar-100-python.tar.gz
    mv cifar-100-python Resnet50_Cifar_for_PyTorch/data/cifar100/
    cp -r Resnet50_Cifar_for_PyTorch ../ascend-pytorch/

    ## 构建镜像
    cd ../ascend-pytorch
    bash build.sh
    cd -
}

## 生成ascend-toolkit镜像
function build_ascend_toolkit()
{
    cd ../ascend-toolkit
    bash build.sh
    cd -
}

## 生成ascendbase-infer镜像
function build_ascendbase_infer()
{
    cd ../ascendbase-infer
    bash build.sh
    cd -
}

## 生成ascendbase-toolkit镜像
function build_ascendbase_toolkit()
{
    cd ../ascendbase-toolkit
    bash build.sh
    cd -
}

## 生成hccl-test镜像
function build_hccl_test()
{
    cd ../hccl-test
    bash build.sh
    cd -
}

function parse_script_args()
{
    while true; do
        case "$1" in
        --help | -h)
            NEED_HELP=yes
            shift
            ;;
        --modelzoo=*)
            image=$(echo "$1" | cut -d"=" -f2)
            if [[ "${image}" = "mindspore" ]]; then
                build_mindspore_modelzoo
            elif [[ "${image}" = "pytorch" ]]; then
                build_pytorch_modelzoo
            elif [[ "${image}" = "pytorch15" ]]; then
                build_pytorch15_modelzoo
            elif [[ "${image}" = "tensorflow" ]]; then
                build_tensorflow_modelzoo
            elif [[ "${image}" = "tensorflow265" ]]; then
                build_tensorflow265_modelzoo
            elif [[ "${image}" = "infer" ]]; then
                build_infer_modelzoo
            elif [[ "${image}" = "infer-mxvision" ]]; then
                build_infer_modelzoo_mxvision
            elif [[ "${image}" = "all-in-one" ]]; then
                all_in_one
            elif [[ "${image}" = "all" ]]; then
                build_mindspore_modelzoo
                build_pytorch_modelzoo
                build_pytorch15_modelzoo
                build_tensorflow_modelzoo
                build_tensorflow265_modelzoo
                build_infer_modelzoo
                build_infer_modelzoo_mxvision
                all_in_one
            else
                echo "Please check the parameter of --modelzoo"
                exit 1
            fi
            shift
            ;;
        --common=*)
            image=$(echo "$1" | cut -d"=" -f2)
            if [[ "${image}" = "algorithm" ]]; then
                build_ascend_algorithm
            elif [[ "${image}" = "infer" ]]; then
                build_ascend_infer
            elif [[ "${image}" = "mindspore" ]]; then
                build_ascend_mindspore
            elif [[ "${image}" = "pytorch" ]]; then
                build_ascend_pytorch
            elif [[ "${image}" = "tensorflow" ]]; then
                build_ascend_tensorflow
            elif [[ "${image}" = "toolkit" ]]; then
                build_ascend_toolkit
            elif [[ "${image}" = "base-infer" ]]; then
                build_ascendbase_infer
            elif [[ "${image}" = "base-toolkit" ]]; then
                build_ascendbase_toolkit
            elif [[ "${image}" = "hccl-test" ]]; then
                build_hccl_test
            elif [[ "${image}" = "all" ]]; then
                build_ascendbase_toolkit
                build_ascendbase_infer
                build_ascend_algorithm
                build_ascend_infer
                build_ascend_toolkit
                build_ascend_mindspore
                build_ascend_pytorch
                build_ascend_tensorflow
                build_hccl_test
            else
                echo "Please check the parameter of --common"
                exit 1
            fi
            shift
            ;;
        -*)
            echo "Unsupported parameters: $1"
            exit 1
            ;;
        *)
            if [ "x$1" != "x" ]; then
                echo "Unsupported parameters: $1"
                exit 1
            fi
            break
            ;;
        esac
    done
}

main()
{
    parse_script_args $@
    if [[ "${NEED_HELP}" = yes ]]; then
    cat <<EOF
run-build-images.sh is used to build images

Command: run-build-images.sh [OPTIONS]...

Options:
    -h, --help                    Displays the help information.
    --modelzoo= mindspore         Specifies the modelzoo image to be created.
                pytorch
                pytorch15
                tensorflow
                tensorflow265
                infer
                infer-mxvision
                all-in-one
                all
    --common=   algorithm          Specifies the common image to be created. 
                infer
                modelzoo
                pytorch
                tensorflow
                toolkit
                base-infer
                base-toolkit
                hccl-test
                all
EOF
        exit 0
    fi
}

main "$@"