FROM debian:10.0

WORKDIR /tmp
COPY . ./

# 1. 驱动路径环境变量设置
ARG ASCEND_BASE=/usr/local/Ascend
ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$LD_LIBRARY_PATH

# Python 3.7.5
RUN apt update && \
    apt install --no-install-recommends wget unzip zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
    libreadline-dev libffi-dev curl libbz2-dev libhdf5-dev pciutils -y && \
    apt install --no-install-recommends  xz-utils -y && \
    apt install --no-install-recommends gcc -y && \
    apt install --no-install-recommends make -y && \
    apt install --no-install-recommends procps -y && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    wget --no-check-certificate  https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig

# python包
RUN pip3.7 install -U pip && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    pip3.7 install attrs && \
    pip3.7 install psutil && \
    rm -rf /root/.cache/pip

# 环境变量
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# 训练引擎安装
ARG CHIP=all

# 2. 训练引擎NNAE安装
ARG NNAE_PKG
ARG NNAE_PATH=$ASCEND_BASE/nnae/latest

# 安装NNAE
RUN umask 0022 && \
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $NNAE_PKG && \
    ./$NNAE_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm -f $NNAE_PKG

# NNAE环境变量
ENV GLOG_v=2 \
    LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64:$LD_LIBRARY_PATH \
    TBE_IMPL_PATH=$NNAE_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$NNAE_PATH/fwkacllib/python/site-packages \
    PATH=$NNAE_PATH/fwkacllib/ccec_compiler/bin:$NNAE_PATH/fwkacllib/bin:$PATH \
    ASCEND_OPP_PATH=$NNAE_PATH/opp \
    ASCEND_AICPU_PATH=$NNAE_PATH

ENV PYTHONPATH=\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH


# TensorFlow框架安装
# TF相关安装
ARG TFPLUGIN_PKG
ARG TF_PKG=tensorflow==2.4.1
ARG ASCEND_BASE=/usr/local/Ascend
ARG TF_PLUGIN_PATH=$ASCEND_BASE/tfplugin/latest

# 安装TFPLUGIN包和TF
RUN umask 0022 && \
    chmod +x ./$TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --quiet --install  \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    pip3.7 install $TF_PKG && \
    rm -rf /root/.cache/pip && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

# 环境变量
ENV TF_PLUGIN_PKG=$TF_PLUGIN_PATH/tfplugin/python/site-packages
ENV PYTHONPATH=$TF_PLUGIN_PKG:$PYTHONPATH

# 清理临时目录
RUN rm -rf ./*
