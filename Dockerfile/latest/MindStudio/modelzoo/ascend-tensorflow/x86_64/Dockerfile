ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE

WORKDIR /tmp
COPY . ./

ARG TF_VERSION
ARG TF_PKG=tensorflow-cpu==$TF_VERSION
ARG TFPLUGIN_PKG
ARG ASCEND_BASE=/usr/local/Ascend
# 安装TFplugin 和安装tensorflow
RUN umask 0022 && \ 
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    chmod +x $TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --check && \
    ./$TFPLUGIN_PKG --quiet --install \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    pip3 install $TF_PKG && \
    rm -rf /root/.cache/pip && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

###配置tfplugin环境变量
RUN echo 'source /usr/local/Ascend/tfplugin/set_env.sh'>>~/.bashrc 

###清理工作
RUN rm -rf ./$TF_PKG \
    && rm -rf ./$TFPLUGIN_PKG 

# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

# 暴露22端口
EXPOSE 22