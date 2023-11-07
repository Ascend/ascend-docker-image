#!/bin/bash

arch=$(uname -m)

cp -rf /usr1/package930/Ascend-cann-nnrt*-$(arch).run .
cp -rf /usr1/package930/Ascend-mindx-toolbox*-$(arch).run .

have_nnrt=$(find . |grep cann|grep nnrt|grep $arch|wc -l)
if [ $have_nnrt == 0 ]; then
    echo "please put nnrt package here"
    exit 1
fi

have_toolbox=$(find . |grep toolbox|grep $arch|wc -l)
if [ $have_toolbox == 0 ]; then
    echo "please put toolbox package here"
    exit 1
fi

if [ $arch == "x86_64" ];then
    DOCKER_BUILDKIT=1 docker build -t cluster-flops-test:x64 --build-arg NNRT_PKG=Ascend-cann-nnrt*-$(arch).run --build-arg TOOLBOX_PKG=Ascend-mindx-toolbox*-$(arch).run .|| exit 1
else
    DOCKER_BUILDKIT=1 docker build -t cluster-flops-test:arm64 --build-arg NNRT_PKG=Ascend-cann-nnrt*-$(arch).run --build-arg TOOLBOX_PKG=Ascend-mindx-toolbox*-$(arch).run .|| exit 1
fi