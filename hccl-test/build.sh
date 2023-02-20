#!/bin/bash

arch=$(uname -m)

if [ $arch == "x86_64" ];then
    docker build -t hccl-test:ubuntu18.04-x64 --build-arg BASE_VERSION=ubuntu18.04-x64 .
else
    docker build -t hccl-test:ubuntu18.04-arm64 --build-arg BASE_VERSION=ubuntu18.04-arm64 . -f Dockerfile_aarch64
fi