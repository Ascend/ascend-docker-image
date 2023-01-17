FROM centos:7

WORKDIR /tmp
COPY . ./

RUN yum update -y && \
    yum makecache && \
    yum install -y wget && \
    ###指定yum源
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo && \
    yum clean all && \
    yum makecache

ARG PY_VERSION
##MindStudio依赖
RUN yum install -y gcc gcc-c++ make cmake unzip zlib-devel bzip2-devel sqlite-devel \
    libffi-devel openssl-devel pciutils net-tools lapack-devel gcc-gfortran xterm firefox \
    openssh xdg-utils dbus-glib-devel gdb

##cann toolkit依赖及python
RUN yum install -y gcc gcc-c++ make cmake unzip zlib-devel libffi-devel openssl-devel \
    pciutils net-tools sqlite-devel lapack-devel openblas-devel gcc-gfortran && \
    ##可选（如果报错）
    # yum install epel-release && \ 
    wget https://repo.huaweicloud.com/python/${PY_VERSION}/Python-${PY_VERSION}.tgz && \
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

##python库
RUN mkdir ~/.pip \
    && echo "[global]" >>~/.pip/pip.conf \
    && echo "index-url=https://mirrors.huaweicloud.com/repository/pypi/simple" >>~/.pip/pip.conf \
    && echo "trusted-host=mirrors.huaweicloud.com" >>~/.pip/pip.conf && \pip3 install --upgrade pip && \
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

###安装ascend-cann-toolkit
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
