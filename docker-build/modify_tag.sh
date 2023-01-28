if [[ $(arch) == "x86_64" ]]; then
    # modelzoo x64
    docker tag all-in-one:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/all-in-one:22.0.0-ubuntu18.04-x64
    docker tag pytorch1.5-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/pytorch1.5-modelzoo:22.0.0-ubuntu18.04-x64
    docker tag pytorch-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/pytorch-modelzoo:22.0.0-ubuntu18.04-x64
    docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/tensorflow2.6.5-modelzoo:22.0.0-ubuntu18.04-x64
    docker tag tensorflow-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/tensorflow-modelzoo:22.0.0-ubuntu18.04-x64
    docker tag infer-modelzoo-mxvision:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/infer-modelzoo-mxvision:22.0.0-ubuntu18.04-x64
    docker tag infer-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/infer-modelzoo:22.0.0-ubuntu18.04-x64
    docker tag mindspore-modelzoo:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/mindspore-modelzoo:22.0.0-ubuntu18.04-x64

    # common x64
    docker tag ascend-toolkit:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-toolkit:22.0.0-centos7.6-x64
    docker tag ascend-toolkit:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-toolkit:22.0.0-ubuntu18.04-x64
    docker tag ascend-mindspore:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-mindspore:22.0.0-centos7.6-x64
    docker tag ascend-mindspore:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-mindspore:22.0.0-ubuntu18.04-x64
    docker tag ascend-pytorch:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-pytorch:22.0.0-centos7.6-x64
    docker tag ascend-pytorch:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-pytorch:22.0.0-ubuntu18.04-x64
    docker tag ascend-tensorflow:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-tensorflow:22.0.0-centos7.6-x64
    docker tag ascend-tensorflow:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-tensorflow:22.0.0-ubuntu18.04-x64
    docker tag ascend-infer:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-infer:22.0.0-centos7.6-x64
    docker tag ascend-infer:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-infer:22.0.0-ubuntu18.04-x64
    docker tag ascend-algorithm:openeuler20.03-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-openeuler20.03-x64
    docker tag ascend-algorithm:ubuntu18.04-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-centos7.6-x64
    docker tag ascend-algorithm:centos7.6-x64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-ubuntu18.04-x64
else
    # modelzoo arm64
    docker tag all-in-one:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/all-in-one:22.0.0-ubuntu18.04-arm64
    docker tag pytorch1.5-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/pytorch1.5-modelzoo:22.0.0-ubuntu18.04-arm64
    docker tag pytorch-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/pytorch-modelzoo:22.0.0-ubuntu18.04-arm64
    docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/tensorflow2.6.5-modelzoo:22.0.0-ubuntu18.04-arm64
    docker tag tensorflow-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/tensorflow-modelzoo:22.0.0-ubuntu18.04-arm64
    docker tag infer-modelzoo-mxvision:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/infer-modelzoo-mxvision:22.0.0-ubuntu18.04-arm64
    docker tag infer-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/infer-modelzoo:22.0.0-ubuntu18.04-arm64
    docker tag mindspore-modelzoo:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/mindspore-modelzoo:22.0.0-ubuntu18.04-arm64

    # common arm64
    docker tag ascend-toolkit:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-toolkit:22.0.0-centos7.6-arm64
    docker tag ascend-toolkit:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-toolkit:22.0.0-ubuntu18.04-arm64
    docker tag ascend-mindspore:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-mindspore:22.0.0-centos7.6-arm64
    docker tag ascend-mindspore:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-mindspore:22.0.0-ubuntu18.04-arm64
    docker tag ascend-pytorch:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-pytorch:22.0.0-centos7.6-arm64
    docker tag ascend-pytorch:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-pytorch:22.0.0-ubuntu18.04-arm64
    docker tag ascend-tensorflow:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-tensorflow:22.0.0-centos7.6-arm64
    docker tag ascend-tensorflow:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-tensorflow:22.0.0-ubuntu18.04-arm64
    docker tag ascend-infer:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-infer:22.0.0-centos7.6-arm64
    docker tag ascend-infer:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-infer:22.0.0-ubuntu18.04-arm64
    docker tag ascend-algorithm:openeuler20.03-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-openeuler20.03-arm64
    docker tag ascend-algorithm:ubuntu18.04-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-centos7.6-arm64
    docker tag ascend-algorithm:centos7.6-arm64 swr.cn-north-4.myhuaweicloud.com/destiny/ascend-algorithm:22.0.0-ubuntu18.04-arm64
fi