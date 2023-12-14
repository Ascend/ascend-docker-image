version=23.0.RC3
repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub

#modelzoo
#all-in-one
docker manifest rm ${repository}/all-in-one:${version}
docker manifest create ${repository}/all-in-one:${version} --amend ${repository}/all-in-one:${version}-ubuntu18.04-x64 --amend ${repository}/all-in-one:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/all-in-one:${version}
#pytorch1.8.1-modelzoo
docker manifest rm ${repository}/pytorch-modelzoo:${version}-1.8.1
docker manifest create ${repository}/pytorch-modelzoo:${version}-1.8.1 --amend ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64 --amend ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
docker manifest push ${repository}/pytorch-modelzoo:${version}-1.8.1
#pytorch1.11.0-modelzoo
docker manifest rm ${repository}/pytorch-modelzoo:${version}-1.11.0
docker manifest create ${repository}/pytorch-modelzoo:${version}-1.11.0 --amend ${repository}/pytorch-modelzoo:${version}-1.11.0-ubuntu18.04-x64 --amend ${repository}/pytorch-modelzoo:${version}-1.11.0-ubuntu18.04-arm64
docker manifest push ${repository}/pytorch-modelzoo:${version}-1.11.0
#mindspore-modelzoo
docker manifest rm ${repository}/mindspore-modelzoo:${version}
docker manifest create ${repository}/mindspore-modelzoo:${version} --amend ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64 --amend ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/mindspore-modelzoo:${version}
#tensorflow-modelzoo
docker manifest rm ${repository}/tensorflow-modelzoo:${version}
docker manifest create ${repository}/tensorflow-modelzoo:${version} --amend ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64 --amend ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/tensorflow-modelzoo:${version}
#tensorflow2.6.5-modelzoo
docker manifest rm ${repository}/tensorflow-modelzoo:${version}-2.6.5
docker manifest create ${repository}/tensorflow-modelzoo:${version}-2.6.5 --amend ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64 --amend ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
docker manifest push ${repository}/tensorflow-modelzoo:${version}-2.6.5
#infer-modelzoo-mxvision
docker manifest rm ${repository}/infer-modelzoo:${version}-mxvision
docker manifest create ${repository}/infer-modelzoo:${version}-mxvision --amend ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-x64 --amend ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-arm64
docker manifest push ${repository}/infer-modelzoo:${version}-mxvision

#common
#algorithm
docker manifest rm ${repository}/algorithm:${version}-ubuntu18.04
docker manifest create ${repository}/algorithm:${version}-ubuntu18.04 --amend ${repository}/algorithm:${version}-ubuntu18.04-x64 --amend ${repository}/algorithm:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/algorithm:${version}-ubuntu18.04
docker manifest rm ${repository}/algorithm:${version}-centos7
docker manifest create ${repository}/algorithm:${version}-centos7 --amend ${repository}/algorithm:${version}-centos7-x64 --amend ${repository}/algorithm:${version}-centos7-arm64
docker manifest push ${repository}/algorithm:${version}-centos7
docker manifest rm ${repository}/algorithm:${version}-openeuler20.03
docker manifest create ${repository}/algorithm:${version}-openeuler20.03 --amend ${repository}/algorithm:${version}-openeuler20.03-x64 --amend ${repository}/algorithm:${version}-openeuler20.03-arm64
docker manifest push ${repository}/algorithm:${version}-openeuler20.03
#ascend-infer
docker manifest rm ${repository}/ascend-infer:${version}-ubuntu18.04
docker manifest create ${repository}/ascend-infer:${version}-ubuntu18.04 --amend ${repository}/ascend-infer:${version}-ubuntu18.04-x64 --amend ${repository}/ascend-infer:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-infer:${version}-ubuntu18.04
docker manifest rm ${repository}/ascend-infer:${version}-centos7
docker manifest create ${repository}/ascend-infer:${version}-centos7 --amend ${repository}/ascend-infer:${version}-centos7-x64 --amend ${repository}/ascend-infer:${version}-centos7-arm64
docker manifest push ${repository}/ascend-infer:${version}-centos7
#ascend-toolkit
docker manifest rm ${repository}/ascend-toolkit:${version}-ubuntu18.04
docker manifest create ${repository}/ascend-toolkit:${version}-ubuntu18.04 --amend ${repository}/ascend-toolkit:${version}-ubuntu18.04-x64 --amend ${repository}/ascend-toolkit:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-toolkit:${version}-ubuntu18.04
docker manifest rm ${repository}/ascend-toolkit:${version}-centos7
docker manifest create ${repository}/ascend-toolkit:${version}-centos7 --amend ${repository}/ascend-toolkit:${version}-centos7-x64 --amend ${repository}/ascend-toolkit:${version}-centos7-arm64
docker manifest push ${repository}/ascend-toolkit:${version}-centos7
#ascend-mindspore
docker manifest rm ${repository}/ascend-mindspore:${version}-ubuntu18.04
docker manifest create ${repository}/ascend-mindspore:${version}-ubuntu18.04 --amend ${repository}/ascend-mindspore:${version}-ubuntu18.04-x64 --amend ${repository}/ascend-mindspore:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-mindspore:${version}-ubuntu18.04
docker manifest rm ${repository}/ascend-mindspore:${version}-centos7
docker manifest create ${repository}/ascend-mindspore:${version}-centos7 --amend ${repository}/ascend-mindspore:${version}-centos7-x64 --amend ${repository}/ascend-mindspore:${version}-centos7-arm64
docker manifest push ${repository}/ascend-mindspore:${version}-centos7
#ascend-pytorch
docker manifest rm ${repository}/ascend-pytorch:${version}-ubuntu18.04
docker manifest create ${repository}/ascend-pytorch:${version}-ubuntu18.04 --amend ${repository}/ascend-pytorch:${version}-ubuntu18.04-x64 --amend ${repository}/ascend-pytorch:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-pytorch:${version}-ubuntu18.04
docker manifest rm ${repository}/ascend-pytorch:${version}-centos7
docker manifest create ${repository}/ascend-pytorch:${version}-centos7 --amend ${repository}/ascend-pytorch:${version}-centos7-x64 --amend ${repository}/ascend-pytorch:${version}-centos7-arm64
docker manifest push ${repository}/ascend-pytorch:${version}-centos7
#ascend-pytorch1.11.0
docker manifest rm ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04
docker manifest create ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04 --amend ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04-x64 --amend ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04
docker manifest rm ${repository}/ascend-pytorch:${version}-1.11.0-centos7
docker manifest create ${repository}/ascend-pytorch:${version}-1.11.0-centos7 --amend ${repository}/ascend-pytorch:${version}-1.11.0-centos7-x64 --amend ${repository}/ascend-pytorch:${version}-1.11.0-centos7-arm64
docker manifest push ${repository}/ascend-pytorch:${version}-1.11.0-centos7
#ascend-tensorflow
docker manifest rm ${repository}/ascend-tensorflow:${version}-ubuntu18.04
docker manifest create ${repository}/ascend-tensorflow:${version}-ubuntu18.04 --amend ${repository}/ascend-tensorflow:${version}-ubuntu18.04-x64 --amend ${repository}/ascend-tensorflow:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/ascend-tensorflow:${version}-ubuntu18.04
docker manifest rm ${repository}/ascend-tensorflow:${version}-centos7
docker manifest create ${repository}/ascend-tensorflow:${version}-centos7 --amend ${repository}/ascend-tensorflow:${version}-centos7-x64 --amend ${repository}/ascend-tensorflow:${version}-centos7-arm64
docker manifest push ${repository}/ascend-tensorflow:${version}-centos7
#hccl-test
docker manifest rm ${repository}/hccl-test:${version}-ubuntu18.04
docker manifest create ${repository}/hccl-test:${version}-ubuntu18.04 --amend ${repository}/hccl-test:${version}-ubuntu18.04-x64 --amend ${repository}/hccl-test:${version}-ubuntu18.04-arm64
docker manifest push ${repository}/hccl-test:${version}-ubuntu18.04
