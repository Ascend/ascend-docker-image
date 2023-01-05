ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE


ARG HOST_ASCEND_BASE=/usr/local/Ascend
WORKDIR /tmp
COPY . ./


# HwHiAiUser, hwMindX
# RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
#     useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
#     usermod -a -G HwHiAiUser hwMindX

ARG TORCH_PKG
ARG APEX_PKG

# Pytorch安装
RUN pip3 install $TORCH_PKG && \
    pip3 install torchvision==0.6.0
# 安装apex
RUN pip3 install $APEX_PKG


# 清理工作
RUN rm -f /etc/ascend_install.info
    # rm -rf /tmp/*

# USER hwMindX



# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

###启动ssh服务
ADD run.sh /run.sh
RUN chmod 755 /run.sh

##将root用户密码设置为root
RUN echo "root:root" | chpasswd
# 启动sshd服务并且暴露22端口
EXPOSE 22
CMD ["/run.sh"]