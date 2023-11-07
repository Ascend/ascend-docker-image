#!/bin/bash

version=23.0.RC3

cp -r /usr1/package930/Ascend-cann-nnrt_*_linux-aarch64.run .
cp -r /usr1/package930/Ascend-cann-toolkit_*_linux-aarch64.run .

#检查cann
have_nnrt=$(find . | grep "nnrt" | grep "linux-aarch64" | wc -l )
if [ $have_nnrt == 0 ]; then
    echo "please put nnrt package here"
    exit 1
fi
have_toolkit=$(find . | grep "toolkit" | grep "linux-aarch64" | wc -l )
if [ $have_toolkit == 0 ]; then
    echo "please put toolkit package here"
    exit 1
fi

DOCKER_BUILDKIT=1 docker build -t ascend-infer-310b:${version}-arm64 . || exit 1
DOCKER_BUILDKIT=1 docker build -t ascend-infer-310b:${version}-dev-arm64 . -f Dockerfile_toolkit || exit 1
