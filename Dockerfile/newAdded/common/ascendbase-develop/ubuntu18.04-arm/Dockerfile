FROM ubuntu:18.04

WORKDIR /tmp
COPY . ./

###黄区必须打开这三条注释，不然apt-get命令会报错
ENV http_proxy="http://p_atlas:proxy%40123@proxycn2.huawei.com:8080"
ENV https_proxy="http://p_atlas:proxy%40123@proxycn2.huawei.com:8080"
ENV no_proxy=127.0.0.1,*.huawei.com,localhost,local,.local

RUN apt-get update && \
    apt install wget -y && \
    apt clean 

ARG PY_VERSION

##底层依赖及python
# RUN apt-get install -y libbz2-dev liblapack-dev openssh-server xterm firefox xdg-utils \
#     libdbus-glib-1-dev gdb haveged x11-apps libxext-dev libxtst-dev libxrender-dev libgbm1

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
    && echo 'export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:${PATH}'>>~/.bashrc \
    && ln -s /usr/local/python${PY_VERSION}/bin/python${PY_VERSION: 0: 3} /usr/bin/python3


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


###(3)安装ascend-cann-toolkit
ARG CANN_TOOLKIT_PKG

RUN umask 0022 && \ 
    chmod +x $CANN_TOOLKIT_PKG && \
    ./$CANN_TOOLKIT_PKG --check && \
    ./$CANN_TOOLKIT_PKG --install 

###配置canntoolkit环境变量
RUN echo 'source /usr/local/Ascend/ascend-toolkit/set_env.sh'>>~/.bashrc
# ENV ASCEND_TOOLKIT_HOME=/usr/local/Ascend/ascend-toolkit/latest
# ENV LD_LIBRARY_PATH=${ASCEND_TOOLKIT_HOME}/lib64:${ASCEND_TOOLKIT_HOME}/lib64/plugin/opskernel:${ASCEND_TOOLKIT_HOME}/lib64/plugin/nnengine:$LD_LIBRARY_PATH
# ENV PYTHONPATH=${ASCEND_TOOLKIT_HOME}/python/site-packages:${ASCEND_TOOLKIT_HOME}/opp/op_impl/built-in/ai_core/tbe:$PYTHONPATH
# ENV PATH=${ASCEND_TOOLKIT_HOME}/bin:${ASCEND_TOOLKIT_HOME}/compiler/ccec_compiler/bin:$PATH
# ENV ASCEND_AICPU_PATH=${ASCEND_TOOLKIT_HOME}
# ENV ASCEND_OPP_PATH=${ASCEND_TOOLKIT_HOME}/opp
# ENV TOOLCHAIN_HOME=${ASCEND_TOOLKIT_HOME}/toolkit
# ENV ASCEND_HOME_PATH=${ASCEND_TOOLKIT_HOME}


##npu-smi 命令
# ENV LD_LIBRARY_PATH=/usr/local/Ascend/driver/lib64/driver:$LD_LIBRARY_PATH
RUN echo 'export LD_LIBRARY_PATH=/usr/local/Ascend/driver/lib64/driver:$LD_LIBRARY_PATH'>>~/.bashrc


###配置交叉编译环境
RUN apt-get install g++-aarch64-linux-gnu -y


# ###安装mindstudio及依赖
ARG MINDSTUDIO_PKG

RUN umask 0022 && \ 
    chmod +x $MINDSTUDIO_PKG && \ 
    tar -zxvf $MINDSTUDIO_PKG 


RUN rm -rf ./$MINDSTUDIO_PKG

    # 配置sshd && 环境变量
# RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
#     && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
#     && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config  
    # ###87执行失败
    # && service ssh start 

# ##将root用户密码设置为root
# RUN echo "root:root" | chpasswd
# # 启动sshd服务并且暴露22端口
# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]

# RUN source ~/.bashrc




