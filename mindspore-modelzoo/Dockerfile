# syntax = docker/dockerfile:experimental
FROM ubuntu:18.04 as buildtemp

WORKDIR /tmp
COPY . ./

FROM ubuntu:18.04
# 系统包,增加libfreetype6-dev pkg-config libpng-dev，否则安装matplotlib报错
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
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends wget vim sudo openssl \
    libnuma1 curl g++ libfreetype6-dev pkg-config libpng-dev unzip libblas3 liblapack3 liblapack-dev libblas-dev \
    gfortran libhdf5-dev libffi-dev libicu60 libxml2 2to3 python3-lib2to3 python3-toolz libgl1-mesa-glx \
    libsqlite3-dev libbz2-dev libssl-dev less htop liblzma-dev && apt clean && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装python和pip
RUN umask 0022  && \
    curl -k https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz -o Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo '[global] \n\
    index-url=http://mirrors.aliyun.com/pypi/simple/\n\
    trusted-host=mirrors.aliyun.com' >> ~/.pip/pip.conf && \
    pip3 install pip -U

# HwHiAiUser
RUN groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

# python包
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    mkdir -p /job/code /home/HwHiAiUser/samples/scripts && \
    chown HwHiAiUser:HwHiAiUser -R /job /home/HwHiAiUser/samples && \
    pip3 install pip -U && \
    pip3 install -r /tmp/requirements.txt && \
    pip3 install /tmp/mindx_elastic*.whl && \
    rm -rf /root/.cache/pip

# 环境变量
ENV GLOG_v=2
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest
ENV TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe
ENV PYTHONPATH=$TBE_IMPL_PATH:$PYTHONPATH
ENV PATH=$TOOLKIT_PATH/ccec_compiler/bin/:/usr/local/Ascend/toolbox/latest/Ascend-DMI/bin:$PATH
ENV ASCEND_OPP_PATH=$TOOLKIT_PATH/opp
ENV ASCEND_AICPU_PATH=$TOOLKIT_PATH
ENV LD_LIBRARY_PATH=$TOOLKIT_PATH/lib64:\
/usr/local/Ascend/driver/lib64/:\
/usr/local/Ascend/driver/lib64/common/:\
/usr/local/Ascend/driver/lib64/driver/:\
/usr/local/Ascend/driver/tools/hccn_tool/:\
$TOOLKIT_PATH/opp/built-in/op_impl/ai_core/tbe/op_tiling/lib/linux/x86_64/:\
/usr/local/Ascend/toolbox/latest/Ascend-DMI/lib64:\
/user/local/dcmi:\
$LD_LIBRARY_PATH

# CANN包
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    chmod +x /tmp/*.run && \
    bash /tmp/Ascend-cann-toolkit*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
    bash /tmp/Ascend-cann-kernels-910b_*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
    bash /tmp/Ascend-mindx-toolbox*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
# TRAIN_FRAMEWORK安装
    pip3 install /tmp/mindspore*.whl && \
    pip3 install $TOOLKIT_PATH/fwkacllib/lib64/te-*.whl && \
    pip3 install $TOOLKIT_PATH/fwkacllib/lib64/hccl-*.whl && \ 

# 清理工作
    rm -rf /tmp/*  && \
    rm -rf /root/.cache/pip

RUN mkdir -p /user/serverid/devindex/config  && \
    chown -R HwHiAiUser:HwHiAiUser /user/serverid/devindex/config && \
    chmod -R o+x /user
USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/samples/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Resnet50_Cifar_for_MindSpore /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore
COPY --chown=HwHiAiUser:HwHiAiUser Resnet50_imagenet2012_for_MindSpore /home/HwHiAiUser/samples/Resnet50_imagenet2012_for_MindSpore
COPY --chown=HwHiAiUser:HwHiAiUser vpc_resnet50_imagenet_classification /home/HwHiAiUser/samples/vpc_resnet50_imagenet_classification
COPY --chown=HwHiAiUser:HwHiAiUser test_model.sh /home/HwHiAiUser/samples/scripts/test_model.sh
COPY --chown=HwHiAiUser:HwHiAiUser hccl.json /user/serverid/devindex/config/hccl.json 
COPY --chown=HwHiAiUser:HwHiAiUser run_ais.py /home/HwHiAiUser/samples/scripts/run_ais.py
COPY --chown=HwHiAiUser:HwHiAiUser train_huawei_train_mindspore_bert-Ais-Benchmark-Stubs-x86_64-1.0-r2.2 /home/HwHiAiUser/samples/train_huawei_train_mindspore_bert-Ais-Benchmark-Stubs-x86_64-1.0-r2.2
COPY --chown=HwHiAiUser:HwHiAiUser train_huawei_train_mindspore_resnet-Ais-Benchmark-Stubs-x86_64-1.0-r2.2 /home/HwHiAiUser/samples/train_huawei_train_mindspore_resnet-Ais-Benchmark-Stubs-x86_64-1.0-r2.2

WORKDIR /home/HwHiAiUser/