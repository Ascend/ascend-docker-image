ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE

ARG HOST_ASCEND_BASE=/usr/local/Ascend
WORKDIR /tmp
COPY . ./

ARG TORCH_PKG
ARG APEX_PKG
ARG TV_VERSION

# Pytorch安装
RUN pip3 install $TORCH_PKG && \
    pip3 install torchvision==${TV_VERSION} 
# 安装apex
RUN pip3 install $APEX_PKG

###清理工作
RUN rm -rf ./$TORCH_PKG \
    && rm -rf ./$APEX_PKG 

# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

# 暴露22端口
EXPOSE 22
