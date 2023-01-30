version=22.0.0
repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
# repository=swr.cn-north-4.myhuaweicloud.com/destiny
if [[ $(arch) == "x86_64" ]]; then
    # modelzoo x64
    docker tag all-in-one:ubuntu18.04-x64 ${repository}/all-in-one:${version}-ubuntu18.04-x64
    docker tag pytorch1.5-modelzoo:ubuntu18.04-x64 ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-x64
    docker tag pytorch-modelzoo:ubuntu18.04-x64 ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64
    docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-x64 ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64
    docker tag tensorflow-modelzoo:ubuntu18.04-x64 ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64
    docker tag infer-modelzoo-mxvision:ubuntu18.04-x64 ${repository}/infer-modelzoo-mxvision:${version}-ubuntu18.04-x64
    docker tag infer-modelzoo:ubuntu18.04-x64 ${repository}/infer-modelzoo:${version}-ubuntu18.04-x64
    docker tag mindspore-modelzoo:ubuntu18.04-x64 ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64

    # common x64
    docker tag ascend-toolkit:centos7.6-x64 ${repository}/ascend-toolkit:${version}-centos7.6-x64
    docker tag ascend-toolkit:ubuntu18.04-x64 ${repository}/ascend-toolkit:${version}-ubuntu18.04-x64
    docker tag ascend-mindspore:centos7.6-x64 ${repository}/ascend-mindspore:${version}-centos7.6-x64
    docker tag ascend-mindspore:ubuntu18.04-x64 ${repository}/ascend-mindspore:${version}-ubuntu18.04-x64
    docker tag ascend-pytorch:centos7.6-x64 ${repository}/ascend-pytorch:${version}-centos7.6-x64
    docker tag ascend-pytorch:ubuntu18.04-x64 ${repository}/ascend-pytorch:${version}-ubuntu18.04-x64
    docker tag ascend-tensorflow:centos7.6-x64 ${repository}/ascend-tensorflow:${version}-centos7.6-x64
    docker tag ascend-tensorflow:ubuntu18.04-x64 ${repository}/ascend-tensorflow:${version}-ubuntu18.04-x64
    docker tag ascend-infer:centos7.6-x64 ${repository}/ascend-infer:${version}-centos7.6-x64
    docker tag ascend-infer:ubuntu18.04-x64 ${repository}/ascend-infer:${version}-ubuntu18.04-x64
    docker tag ascend-algorithm:openeuler20.03-x64 ${repository}/ascend-algorithm:${version}-openeuler20.03-x64
    docker tag ascend-algorithm:ubuntu18.04-x64 ${repository}/ascend-algorithm:${version}-centos7.6-x64
    docker tag ascend-algorithm:centos7.6-x64 ${repository}/ascend-algorithm:${version}-ubuntu18.04-x64
else
    # modelzoo arm64
    docker tag all-in-one:ubuntu18.04-arm64 ${repository}/all-in-one:${version}-ubuntu18.04-arm64
    docker tag pytorch1.5-modelzoo:ubuntu18.04-arm64 ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-arm64
    docker tag pytorch-modelzoo:ubuntu18.04-arm64 ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
    docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-arm64 ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
    docker tag tensorflow-modelzoo:ubuntu18.04-arm64 ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
    docker tag infer-modelzoo-mxvision:ubuntu18.04-arm64 ${repository}/infer-modelzoo-mxvision:${version}-ubuntu18.04-arm64
    docker tag infer-modelzoo:ubuntu18.04-arm64 ${repository}/infer-modelzoo:${version}-ubuntu18.04-arm64
    docker tag mindspore-modelzoo:ubuntu18.04-arm64 ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64

    # common arm64
    docker tag ascend-toolkit:centos7.6-arm64 ${repository}/ascend-toolkit:${version}-centos7.6-arm64
    docker tag ascend-toolkit:ubuntu18.04-arm64 ${repository}/ascend-toolkit:${version}-ubuntu18.04-arm64
    docker tag ascend-mindspore:centos7.6-arm64 ${repository}/ascend-mindspore:${version}-centos7.6-arm64
    docker tag ascend-mindspore:ubuntu18.04-arm64 ${repository}/ascend-mindspore:${version}-ubuntu18.04-arm64
    docker tag ascend-pytorch:centos7.6-arm64 ${repository}/ascend-pytorch:${version}-centos7.6-arm64
    docker tag ascend-pytorch:ubuntu18.04-arm64 ${repository}/ascend-pytorch:${version}-ubuntu18.04-arm64
    docker tag ascend-tensorflow:centos7.6-arm64 ${repository}/ascend-tensorflow:${version}-centos7.6-arm64
    docker tag ascend-tensorflow:ubuntu18.04-arm64 ${repository}/ascend-tensorflow:${version}-ubuntu18.04-arm64
    docker tag ascend-infer:centos7.6-arm64 ${repository}/ascend-infer:${version}-centos7.6-arm64
    docker tag ascend-infer:ubuntu18.04-arm64 ${repository}/ascend-infer:${version}-ubuntu18.04-arm64
    docker tag ascend-algorithm:openeuler20.03-arm64 ${repository}/ascend-algorithm:${version}-openeuler20.03-arm64
    docker tag ascend-algorithm:ubuntu18.04-arm64 ${repository}/ascend-algorithm:${version}-centos7.6-arm64
    docker tag ascend-algorithm:centos7.6-arm64 ${repository}/ascend-algorithm:${version}-ubuntu18.04-arm64
fi