FROM ubuntu:18.04

WORKDIR /tmp
COPY . ./

###添加apt的源
RUN  sed -i "s@http://.*ports.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
     && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
     && apt-get clean

RUN apt-get update && \
    apt install wget -y && \
    apt clean 

ARG PY_VERSION

##MindStudio依赖
RUN apt-get install -y gcc g++ make cmake zlib1g-dev libbz2-dev libsqlite3-dev libssl-dev \
    libffi-dev unzip pciutils net-tools libblas-dev gfortran libblas3 liblapack-dev openssh-server \
    xterm firefox xdg-utils libdbus-glib-1-dev gdb

##安装Ascend-cann-toolkit及依赖
##(1)依赖
RUN apt-get install -y gcc g++ make cmake zlib1g zlib1g-dev openssl libsqlite3-dev libssl-dev libffi-dev \
    unzip pciutils net-tools libblas-dev gfortran libblas3 libopenblas-dev && \
    wget https://repo.huaweicloud.com/python/${PY_VERSION}/Python-${PY_VERSION}.tgz --no-check-certificate && \
    tar -zxvf Python-${PY_VERSION}.tgz && cd Python-${PY_VERSION} && \
    ./configure --prefix=/usr/local/python${PY_VERSION} --enable-loadable-sqlite-extensions --enable-shared && \
    make && \
    make install && \
    rm -rf ./Python*

ENV LD_LIBRARY_PATH=/usr/local/python${PY_VERSION}/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python${PY_VERSION}/bin:$PATH

SHELL [ "/bin/bash","-c" ]
RUN echo 'export PY_VERSION='${PY_VERSION}>>~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/usr/local/python'${PY_VERSION}'/lib'>>~/.bashrc \
    && echo 'export PATH=/usr/local/python'${PY_VERSION}'/bin:${PATH}'>>~/.bashrc \
    && echo 'export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:${PATH}'>>~/.bashrc  

###(2)安装python库
RUN mkdir ~/.pip \
    && echo "[global]" >>~/.pip/pip.conf \
    && echo "index-url=https://mirrors.huaweicloud.com/repository/pypi/simple" >>~/.pip/pip.conf \
    && echo "trusted-host=mirrors.huaweicloud.com" >>~/.pip/pip.conf && \
    pip3 install --upgrade pip && \
    pip3 install attrs && \
    pip3 install numpy && \
    pip3 install decorator && \
    pip3 install sympy && \
    pip3 install cffi && \
    pip3 install pyyaml && \
    pip3 install pathlib2 && \
    pip3 install psutil && \
    pip3 install protobuf==3.20.0 && \
    pip3 install scipy && \
    pip3 install requests && \
    pip3 install absl-py && \
    pip3 install grpcio && \
    pip3 install pylint && \
    pip3 install wheel && \
    rm -rf /root/.cache/pip

###链接python和python3命令为安装的python版本
RUN rm -rf /usr/bin/python3 \
    && ln -s /usr/local/python${PY_VERSION}/bin/python${PY_VERSION: 0: 3} /usr/bin/python3 \
    && rm -rf /usr/bin/pip3 \
    && ln -s /usr/local/python${PY_VERSION}/bin/pip${PY_VERSION: 0: 3} /usr/bin/pip3 \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/python${PY_VERSION}/bin/python${PY_VERSION: 0: 3} /usr/bin/python \
    && rm -rf /usr/bin/pip \
    && ln -s /usr/local/python${PY_VERSION}/bin/pip${PY_VERSION: 0: 3} /usr/bin/pip 

###(3)安装ascend-cann-toolkit
ARG CANN_TOOLKIT_PKG

RUN umask 0022 && \ 
    chmod +x $CANN_TOOLKIT_PKG && \
    ./$CANN_TOOLKIT_PKG --check && \
    ./$CANN_TOOLKIT_PKG --install 

###配置canntoolkit环境变量
RUN echo 'source /usr/local/Ascend/ascend-toolkit/set_env.sh'>>~/.bashrc

##npu-smi 命令
RUN echo 'export LD_LIBRARY_PATH=/usr/local/Ascend/driver/lib64/driver:$LD_LIBRARY_PATH'>>~/.bashrc

# ###安装mindstudio及依赖
ARG MINDSTUDIO_PKG

RUN umask 0022 && \ 
    chmod +x $MINDSTUDIO_PKG && \ 
    tar -zxvf $MINDSTUDIO_PKG 

###清理工作
RUN rm -rf ./$MINDSTUDIO_PKG \
    && rm -rf ./Python* \
    && rm -rf ./$CANN_TOOLKIT_PKG 
