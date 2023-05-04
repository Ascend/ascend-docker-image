#!/bin/bash

arch=$(uname -m)

#准备依赖包
cp -rf /usr1/package330/mindspore-*linux_$(arch).whl .
cp -rf /usr1/package330/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl .
cp -rf /usr1/package330/Ascend-mindx-toolbox*-$(arch).run .

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

cp -r /usr1/package330/mindspore-modelzoo-data-model/Resnet50_Cifar_for_MindSpore .
cp -r /usr1/package330/mindspore-modelzoo-data-model/Resnet50_imagenet2012_for_MindSpore .
cp -r /usr1/package330/mindspore-modelzoo-data-model/vpc_resnet50_imagenet_classification .

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
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1  docker build . -t mindspore-modelzoo:ubuntu18.04-x64
    # rm -f Ascend-cann-*-$(arch).run
    # cp -rf /usr1/package330/Ascend-cann-toolkit_6.1*-$(arch).run .
    # DOCKER_BUILDKIT=1  docker build . -t mindspore-modelzoo:910b-ubuntu18.04-x64
else
    rm -f Ascend-cann-*-$(arch).run
    cp -rf /usr1/package330/Ascend-cann-toolkit_6.3*-$(arch).run .
    cp -rf /usr1/package330/Ascend-cann-kernels-910_6.3.RC1_linux.run .
    DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t mindspore-modelzoo:ubuntu18.04-arm64
    # rm -f Ascend-cann-*-$(arch).run
    # cp -rf /usr1/package330/Ascend-cann-toolkit_6.1*-$(arch).run .
    # DOCKER_BUILDKIT=1  docker build . -f Dockerfile_aarch64 -t mindspore-modelzoo:910b-ubuntu18.04-arm64
fi
