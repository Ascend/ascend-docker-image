ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE


ARG HOST_ASCEND_BASE=/usr/local/Ascend
WORKDIR /tmp
COPY . ./

RUN OS_ID=$(grep -oP "^ID=\"?\K\w+" /etc/os-release) && \
    if [ "$OS_ID" == "ubuntu" ]; then \
        apt-get install -y patch build-essential libbz2-dev libreadline-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev liblzma-dev m4 dos2unix git \
        && apt-get install -y gcc==7.3.0 cmake==3.12.0 ; \
    elif [ "$OS_ID" == "centos" ]; then \
        yum install -y patch libjpeg-turbo-devel dos2unix git \
        && yum install -y gcc==7.3.0 cmake==3.12.0 ; \
    fi

ARG TORCH_PKG
ARG TV_VERSION

### pytorch v1.5.0对应torchvision==0.6.0，PyTorch 1.8.1需安装0.9.1版本，PyTorch 1.11.0需安装0.12.0版本
RUN pip3 install --upgrade ${TORCH_PKG} && \
    pip3 install torchvision==${TV_VERSION} 

RUN echo 'source env.sh'>>~/.bashrc


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


