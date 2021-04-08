ARG BASE_VERSION
ARG BASE=ascend-train:$BASE_VERSION
FROM $BASE

ARG PREINSTALL=preinstall.sh
ARG POSTINSTALL=postinstall.sh
WORKDIR /tmp
COPY . ./

# TF相关安装
ARG TFPLUGIN_PKG
ARG TF_PKG=tensorflow==1.15.0
ARG ASCEND_BASE=/usr/local/Ascend
ARG TF_PLUGIN_PATH=$ASCEND_BASE/tfplugin/latest

# 安装TFPLUGIN包和TF
SHELL ["/bin/bash", "-c"]

RUN umask 0022 && \
    { source $PREINSTALL || true; } && \
    chmod +x ./$TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --quiet --install  --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    pip3.7 install $TF_PKG && \
    rm -rf /root/.cache/pip && \
    { source $POSTINSTALL || true; }

# 环境变量
ENV TF_PLUGIN_PKG=$TF_PLUGIN_PATH/tfplugin/python/site-packages
ENV PYTHONPATH=$TF_PLUGIN_PKG:$PYTHONPATH

# 清理临时目录
RUN rm -rf ./*
