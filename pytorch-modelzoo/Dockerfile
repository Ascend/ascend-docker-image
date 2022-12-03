# syntax = docker/dockerfile:experimental
FROM ubuntu:18.04 as buildtemp

WORKDIR /tmp
COPY . ./

FROM ubuntu:18.04
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest

RUN echo "deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse\n" > /etc/apt/sources.list && \
    apt-get -o "Acquire::https::Verify-Peer=false" update && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends ca-certificates && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends \
    wget vim-tiny sudo bzip2 wget make tar curl g++ pkg-config unzip numactl \
    libsqlite3-dev libzip-dev liblzma-dev zlib1g-dev libbz2-dev libopenblas-dev libblas3 liblapack3 \
    liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 \
    libxml2 libssl-dev git patch libfreetype6-dev libpng-dev libgl1-mesa-glx less htop bc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装python和pip
RUN curl -k https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz -o Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo '[global] \n\
    index-url=https://pypi.tuna.tsinghua.edu.cn/simple\n\
    trusted-host=pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf && \
    pip3 install pip -U

#安装pytorch
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    pip3 install pip -U && \
    pip3 install decorator && \
    pip3 install sympy==1.4 && \
    pip3 install cffi==1.12.3 && \
    pip3 install pyyaml && \
    pip3 install pathlib2 && \
    pip3 install grpcio && \
    pip3 install grpcio-tools && \
    pip3 install protobuf && \
    pip3 install scipy && \
    pip3 install requests && \
    pip3 install attrs && \
    pip3 install wheel && \
    pip3 install Pillow==7.2.0 && \
    pip3 install wheel && \
    pip3 install setuptools && \
    pip3 install matplotlib && \
    pip3 install opencv-python==4.5.5.64 && \
    pip3 install sklearn==0.0 && \
    pip3 install pandas && \
    pip3 install pycocotools==2.0.6 && \
    pip3 install tables==3.6.1 && \
    pip3 install mmcv==1.7.0 && \
    pip3 install lxml==4.5.2 && \
    pip3 install easydict==1.9 && \
    pip3 install pytest && \
    pip3 install xdoctest==1.1.0 && \
    pip3 install --upgrade /tmp/torch-1.8.1*.whl && \
    pip3 install torchvision==0.9.1 && \
    pip3 install /tmp/dllogger && \
    rm -rf /root/.cache/pip

#set env
ENV LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64/:/usr/local/python3.7.5/lib/python3.7/site-packages/torch/lib:/usr/local/Ascend/driver/lib64/:/usr/local/Ascend/driver/lib64/common/:/usr/local/Ascend/driver/lib64/driver/:/usr/local/Ascend/add-ons/:/usr/lib/aarch64_64-linux-gnu:$LD_LIBRARY_PATH \
PATH=$PATH:$NNAE_PATH/fwkacllib/ccec_compiler/bin/:$NNAE_PATH/toolkit/tools/ide_daemon/bin/ \
ASCEND_OPP_PATH=$NNAE_PATH/opp/ \
OPTION_EXEC_EXTERN_PLUGIN_PATH=$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libfe.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libaicpu_engine.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libge_local_engine.so \
PYTHONPATH=$NNAE_PATH/fwkacllib/python/site-packages/:$NNAE_PATH/fwkacllib/python/site-packages/auto_tune.egg/auto_tune:$NNAE_PATH/fwkacllib/python/site-packages/schedule_search.egg:$PYTHONPATH \
ASCEND_AICPU_PATH=$NNAE_PATH

# create user HwHiAiUser
RUN groupadd  HwHiAiUser -g 1000 && \
useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

#安装pytorch
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
bash /tmp/Ascend-cann-nnae*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
pip3 install --upgrade /tmp/torch_npu*.whl && \
pip3 install --upgrade /tmp/apex-0.1+ascend*.whl && \
rm -rf /root/.cache/pip

USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Resnet50_Cifar_for_PyTorch /home/HwHiAiUser/samples/Resnet50_Cifar_for_PyTorch
WORKDIR /home/HwHiAiUser/
