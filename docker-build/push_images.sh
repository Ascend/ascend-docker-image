version=22.0.0
# repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
repository=swr.cn-north-4.myhuaweicloud.com/destiny
if [[ $(arch) == "x86_64" ]]; then
    # modelzoo x64
    docker push ${repository}/all-in-one:${version}-ubuntu18.04-x64
    docker push ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-x64
    docker push ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64
    docker push ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64
    docker push ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64
    docker push ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-x64
    docker push ${repository}/infer-modelzoo:${version}-ubuntu18.04-x64
    docker push ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64

    # common x64
    docker push ${repository}/ascend-toolkit:${version}-centos7.6-x64
    docker push ${repository}/ascend-toolkit:${version}-ubuntu18.04-x64
    docker push ${repository}/ascend-mindspore:${version}-centos7.6-x64
    docker push ${repository}/ascend-mindspore:${version}-ubuntu18.04-x64
    docker push ${repository}/ascend-pytorch:${version}-centos7.6-x64
    docker push ${repository}/ascend-pytorch:${version}-ubuntu18.04-x64
    docker push ${repository}/ascend-tensorflow:${version}-centos7.6-x64
    docker push ${repository}/ascend-tensorflow:${version}-ubuntu18.04-x64
    docker push ${repository}/ascend-infer:${version}-centos7.6-x64
    docker push ${repository}/ascend-infer:${version}-ubuntu18.04-x64
    docker push ${repository}/ascend-algorithm:${version}-openeuler20.03-x64
    docker push ${repository}/ascend-algorithm:${version}-centos7.6-x64
    docker push ${repository}/ascend-algorithm:${version}-ubuntu18.04-x64
else
    # modelzoo arm64
    docker push ${repository}/all-in-one:${version}-ubuntu18.04-arm64
    docker push ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-arm64
    docker push ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
    docker push ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
    docker push ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
    docker push ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-arm64
    docker push ${repository}/infer-modelzoo:${version}-ubuntu18.04-arm64
    docker push ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64

    # common arm64
    docker push ${repository}/ascend-toolkit:${version}-centos7.6-arm64
    docker push ${repository}/ascend-toolkit:${version}-ubuntu18.04-arm64
    docker push ${repository}/ascend-mindspore:${version}-centos7.6-arm64
    docker push ${repository}/ascend-mindspore:${version}-ubuntu18.04-arm64
    docker push ${repository}/ascend-pytorch:${version}-centos7.6-arm64
    docker push ${repository}/ascend-pytorch:${version}-ubuntu18.04-arm64
    docker push ${repository}/ascend-tensorflow:${version}-centos7.6-arm64
    docker push ${repository}/ascend-tensorflow:${version}-ubuntu18.04-arm64
    docker push ${repository}/ascend-infer:${version}-centos7.6-arm64
    docker push ${repository}/ascend-infer:${version}-ubuntu18.04-arm64
    docker push ${repository}/ascend-algorithm:${version}-openeuler20.03-arm64
    docker push ${repository}/ascend-algorithm:${version}-centos7.6-arm64
    docker push ${repository}/ascend-algorithm:${version}-ubuntu18.04-arm64
fi