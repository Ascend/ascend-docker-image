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








        
# 配置python pip源
# RUN mkdir -p ~/.pip \
# && echo '[global] \n\
# index-url=http://pypi.doubanio.com/simple/\n\
# trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# HwHiAiUser, hwMindX
# RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
#     useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
#     usermod -a -G HwHiAiUser hwMindX

# python包
# RUN pip3 install pip -U && \
#     pip3 install numpy && \
#     pip3 install decorator && \
#     pip3 install sympy==1.4 && \
#     pip3 install cffi==1.12.3 && \
#     pip3 install pyyaml && \
#     pip3 install pathlib2 && \
#     pip3 install grpcio && \
#     pip3 install grpcio-tools && \
#     pip3 install protobuf && \
#     pip3 install scipy && \
#     pip3 install requests && \
#     pip3 install attrs && \
#     pip3 install wheel && \
#     pip3 install Pillow==6.2.2 && \
#     # pip3 install torchvision==0.2.2.post3 && \
#     pip3 install wheel==0.32.1 && \
#     pip3 install setuptools==49.1.0 && \
#     pip3 install matplotlib==3.2.2 && \
#     pip3 install opencv-python==4.5.5.64 && \
#     pip3 install sklearn==0.0 && \
#     pip3 install pandas==1.0.5 && \
#     pip3 install pycocotools==2.0.1 && \
#     pip3 install tables==3.6.1 && \
#     pip3 install mmcv==0.2.14 && \
#     pip3 install lxml==4.5.2 && \
#     pip3 install easydict==1.9 && \
#     rm -rf /root/.cache/pip

ARG TORCH_PKG
ARG APEX_PKG

# Pytorch安装
RUN pip3 install $TORCH_PKG

# 安装apex
RUN pip3 install $APEX_PKG


# 清理工作
RUN rm -f /etc/ascend_install.info
    # rm -rf /tmp/*

# USER hwMindX
