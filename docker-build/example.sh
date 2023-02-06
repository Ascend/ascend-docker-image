# version=22.0.0
# # repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
# repository=swr.cn-north-4.myhuaweicloud.com/destiny
# if [[ $(arch) == "x86_64" ]]; then
#     # modelzoo x64
#     docker tag pytorch1.5-modelzoo:ubuntu18.04-x64 ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-x64
#     docker tag pytorch-modelzoo:ubuntu18.04-x64 ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64
#     docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-x64 ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64
#     docker tag tensorflow-modelzoo:ubuntu18.04-x64 ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64
#     docker tag infer-modelzoo-mxvision:ubuntu18.04-x64 ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-x64
#     docker tag infer-modelzoo:ubuntu18.04-x64 ${repository}/infer-modelzoo:${version}-ubuntu18.04-x64
#     docker tag mindspore-modelzoo:ubuntu18.04-x64 ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64
# else
#     # modelzoo arm64
#     docker tag pytorch1.5-modelzoo:ubuntu18.04-arm64 ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-arm64
#     docker tag pytorch-modelzoo:ubuntu18.04-arm64 ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
#     docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-arm64 ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
#     docker tag tensorflow-modelzoo:ubuntu18.04-arm64 ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
#     docker tag infer-modelzoo-mxvision:ubuntu18.04-arm64 ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-arm64
#     docker tag infer-modelzoo:ubuntu18.04-arm64 ${repository}/infer-modelzoo:${version}-ubuntu18.04-arm64
#     docker tag mindspore-modelzoo:ubuntu18.04-arm64 ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64
# fi

# docker login -u cn-north-4@RS2OKTYSLJBP36NDS2XC -p 1ed7757fa01b05bd23a089d29bb3b89d1b9ff985c8a1c45ea03ea5946acf79c0 swr.cn-north-4.myhuaweicloud.com

# if [[ $(arch) == "x86_64" ]]; then
#     # modelzoo x64
#     docker push ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-x64
#     docker push ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64
#     docker push ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64
#     docker push ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64
#     docker push ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-x64
#     docker push ${repository}/infer-modelzoo:${version}-ubuntu18.04-x64
#     docker push ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64
# else
#     # modelzoo arm64
#     docker push ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-arm64
#     docker push ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
#     docker push ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
#     docker push ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
#     docker push ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-arm64
#     docker push ${repository}/infer-modelzoo:${version}-ubuntu18.04-arm64
#     docker push ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64
# fi

version=22.0.0
# repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
repository=swr.cn-north-4.myhuaweicloud.com/destiny

docker login -u cn-north-4@RS2OKTYSLJBP36NDS2XC -p 1ed7757fa01b05bd23a089d29bb3b89d1b9ff985c8a1c45ea03ea5946acf79c0 swr.cn-north-4.myhuaweicloud.com

if [[ $(arch) == "x86_64" ]]; then
    # modelzoo x64
    docker pull ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-x64
    docker pull ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-x64
    docker pull ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-x64
    docker pull ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-x64
    docker pull ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-x64
    docker pull ${repository}/infer-modelzoo:${version}-ubuntu18.04-x64
    docker pull ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-x64
else
    # modelzoo arm64
    docker pull ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-arm64
    docker pull ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-arm64
    docker pull ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-arm64
    docker pull ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-arm64
    docker pull ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-arm64
    docker pull ${repository}/infer-modelzoo:${version}-ubuntu18.04-arm64
    docker pull ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-arm64
fi

