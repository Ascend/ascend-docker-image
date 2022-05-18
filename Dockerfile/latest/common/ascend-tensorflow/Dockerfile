ARG BASE_VERSION
ARG BASE=ascend-train:$BASE_VERSION
FROM $BASE

WORKDIR /tmp
COPY . ./

# TF相关安装
ARG TFPLUGIN_PKG
# arm的镜像TF_PKG需自行准备，tensorflow-1.15.0-cp37-cp37m-linux_aarch64.whl
ARG TF_PKG=tensorflow-cpu==1.15.0
ARG ASCEND_BASE=/usr/local/Ascend
ARG TF_PLUGIN_PATH=$ASCEND_BASE/tfplugin/latest

# 注：centos7需激活SHELL，ubuntu18.04需注释
SHELL ["/usr/bin/scl", "enable", "devtoolset-7"]

# 安装TFPLUGIN包和TF
RUN umask 0022 && \
    useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX && \
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    chmod +x ./$TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --quiet --install \
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

USER hwMindX
