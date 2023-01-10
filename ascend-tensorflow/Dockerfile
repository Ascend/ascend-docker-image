ARG BASE_VERSION
ARG BASE=ascend-toolkit:$BASE_VERSION
FROM $BASE

WORKDIR /tmp
COPY . ./

# TF相关安装
ARG TFPLUGIN_PKG=Ascend-cann-tfplugin*.run
ARG TF_PKG=tensorflow*.whl
ARG ASCEND_BASE=/usr/local/Ascend
ARG TF_PLUGIN_PATH=$ASCEND_BASE/tfplugin/latest

SHELL ["/bin/bash","-c"]

# 安装TFPLUGIN包和TF
RUN umask 0022 && \
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    chmod +x ./$TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --quiet --install \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    pip3 install $TF_PKG && \
    pip3 install -U protobuf==3.20.0 && \
    rm -rf /root/.cache/pip && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

# 环境变量
ENV TF_PLUGIN_PKG=$TF_PLUGIN_PATH/tfplugin/python/site-packages
ENV PYTHONPATH=$TF_PLUGIN_PKG:$PYTHONPATH

# 清理临时目录
RUN rm -rf ./*

USER HwHiAiUser
COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Keras-MnasNet_ID3518_for_TensorFlow2.X /home/HwHiAiUser/Keras-MnasNet_ID3518_for_TensorFlow2.X
COPY --chown=HwHiAiUser:HwHiAiUser test_model.sh /home/HwHiAiUser/test_model.sh
WORKDIR /home/HwHiAiUser/
