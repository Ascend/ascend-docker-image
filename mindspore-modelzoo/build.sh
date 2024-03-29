#!/bin/bash

arch=$(uname -m)

#准备依赖包
cp -rf /usr1/package930/mindspore-*linux_$(arch).whl .
cp -rf /usr1/package930/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl .
cp -rf /usr1/package930/Ascend-mindx-toolbox*-$(arch).run .
if [ $arch == "x86_64" ];then
    cp -rf /usr1/package930/train_huawei_train_mindspore_bert-Ais-Benchmark-Stubs-x86_64-1.0-r2.2 .
    cp -rf /usr1/package930/train_huawei_train_mindspore_resnet-Ais-Benchmark-Stubs-x86_64-1.0-r2.2 .
else
    cp -rf /usr1/package930/train_huawei_train_mindspore_bert-Ais-Benchmark-Stubs-aarch64-1.0-r2.2 .
    cp -rf /usr1/package930/train_huawei_train_mindspore_resnet-Ais-Benchmark-Stubs-aarch64-1.0-r2.2 .
fi

#准备模型和数据集
if [ -d Resnet50_Cifar_for_MindSpore ]; then
    rm -rf Resnet50_Cifar_for_MindSpore
fi
if [ -d Resnet50_imagenet2012_for_MindSpore ]; then
    rm -rf Resnet50_imagenet2012_for_MindSpore
fi
if [ -d vpc_resnet50_imagenet_classification ]; then
    rm -rf vpc_resnet50_imagenet_classification
fi

cp -r /usr1/package930/mindspore-modelzoo-data-model/Resnet50_Cifar_for_MindSpore .
cp -r /usr1/package930/mindspore-modelzoo-data-model/Resnet50_imagenet2012_for_MindSpore .
cp -r /usr1/package930/mindspore-modelzoo-data-model/vpc_resnet50_imagenet_classification .

#检查依赖包
have_mindspore=$(find . |grep "mindspore"|grep $arch|wc -l)
if [ $have_mindspore == 0 ]; then
    echo "please put mindspore wheel package here"
    exit 1
fi
have_elastic=$(find . |grep "mindx_elastic"|grep $arch|wc -l)
if [ $have_elastic == 0 ]; then
    echo "please put mindx_elastic wheel package here"
    exit 1
fi
have_toolbox=$(find . |grep toolbox|grep $arch|wc -l)
if [ $have_toolbox == 0 ]; then
    echo "please put toolbox package here"
    exit 1
fi

echo "start build"
if [ $arch == "x86_64" ];then
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package930/Ascend-cann-toolkit_7.0*-$(arch).run .
    cp -rf /usr1/package930/Ascend-cann-kernels-910b_*.run .
    DOCKER_BUILDKIT=1  docker build . -t mindspore-modelzoo:ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package930/Ascend-cann-toolkit_7.0*-$(arch).run .
    cp -rf /usr1/package930/Ascend-cann-kernels-910b_*.run .
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t mindspore-modelzoo:ubuntu18.04-arm64
fi