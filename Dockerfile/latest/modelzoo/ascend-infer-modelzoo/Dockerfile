FROM ubuntu:18.04

ARG ASCEND_BASE=/usr/local/Ascend
ARG TOOLKIT_PKG=Ascend-cann-toolkit*.run
ARG SDK_PKG=Ascend-mindxsdk*.run
ARG MX_SDK_HOME=/home/hwMindX/sdk_home/mxManufacture
WORKDIR /tmp

# 安装系统依赖
RUN apt update && \
    apt install -y --no-install-recommends pciutils wget libxml2 g++ automake make xz-utils libbz2-dev libssl-dev vim zip unzip dos2unix autoconf libtool \
    libgl1-mesa-glx zlib1g zlib1g-dev libffi-dev libfreetype6-dev pkg-config libpng-dev numactl libopenblas-dev bzip2 libblas3 liblapack3 \
    libblas-dev gfortran libhdf5-dev libicu60 libxml2-dev libxslt-dev ca-certificates curl gcc cython3 python3-h5py libgmpxx4ldbl less htop && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    if [ ! -d "/lib64" ]; \
    then \
        mkdir /lib64 && ln -sf /lib/ld-linux-aarch64.so.1 /lib64/ld-linux-aarch64.so.1; \
    fi

COPY Python-3.9.2.tar.xz /tmp

# 安装python和pip
RUN tar -xvf Python-3.9.2.tar.xz && cd Python-3.9.2 && ./configure --prefix=/usr/local/python3.9.2 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.9.2/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.9.2/bin/python3 /usr/bin/python3.9 && \
    ln -sf /usr/local/python3.9.2/bin/pip3 /usr/bin/pip3 && \
    cd .. && \
    rm -rf Python*
	
ENV LD_LIBRARY_PATH=/usr/local/python3.9.2/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python3.9.2/bin:$PATH

COPY cmake-3.20.5.tar.gz /tmp

# 源码安装cmake
RUN apt autoremove cmake && \
    tar -zxvf cmake-3.20.5.tar.gz && \
    cd cmake-3.20.5 && \
    ./bootstrap && \
    make && \
    make install && \
    cd .. && \
    rm -rf cmake*

# HwHiAiUser, hwMindX
RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX

# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=http://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

RUN pip3 install pip -U && \
    pip3 install numpy && \
    pip3 install decorator && \
    pip3 install sympy==1.4 && \
	pip3 install protobuf==3.13.0 && \
    pip3 install Pillow && \
	pip3 install Cython && \
	pip3 install wheel==0.32.1 && \
	pip3 install setuptools==49.1.0 && \
	pip3 install matplotlib==3.2.2 && \
	pip3 install opencv-python==4.5.5.64 && \
	pip3 install sklearn==0.0 && \
	pip3 install pandas==1.0.5 && \
	pip3 install pycocotools==2.0.1 && \
	pip3 install tables==3.6.1 && \
	pip3 install mmcv==0.2.14 && \
	pip3 install lxml==4.5.2 && \
	pip3 install easydict==1.9 && \
    rm -rf /root/.cache/pip

COPY . ./
# install toolkit pkg
RUN bash -c 'umask 0022' && \
    chmod +x $TOOLKIT_PKG && \
    ./$TOOLKIT_PKG --quiet --install --install-path=$ASCEND_BASE --install-for-all && \
    mv $SDK_PKG /home/hwMindX && \
    rm -rf /tmp/*

# 环境变量设置
ENV ASCEND_HOME=$ASCEND_BASE

ENV PYTHONPATH=${MX_SDK_HOME}/python:$ASCEND_BASE/ascend-toolkit/latest/pyACL/python/site-packages/acl:\
$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages:$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages/auto_tune.egg/auto_tune:\
$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages/schedule_search.egg \
ASCEND_AICPU_PATH=$ASCEND_BASE/ascend-toolkit/latest \
MX_SDK_HOME=/home/hwMindX/sdk_home/mxManufacture/ \
GST_PLUGIN_SCANNER=${MX_SDK_HOME}/opensource/libexec/gstreamer-1.0/gst-plugin-scanner \
GST_PLUGIN_PATH=${MX_SDK_HOME}/opensource/lib/gstreamer-1.0:${MX_SDK_HOME}/lib/plugins \
LD_LIBRARY_PATH=${MX_SDK_HOME}/lib:${MX_SDK_HOME}/opensource/lib:\
/usr/local/Ascend/driver/lib64:/usr/local/Ascend/ascend-toolkit/latest/acllib/lib64:\
/usr/local/Ascend/ascend-toolkit/latest/atc/lib64:/usr/local/python3.9.2/lib

ENV PATH=$ASCEND_BASE/ascend-toolkit/latest/atc/ccec_compiler/bin:$ASCEND_BASE/ascend-toolkit/latest/atc/bin:$PATH

ENV ASCEND_OPP_PATH=$ASCEND_BASE/ascend-toolkit/latest/opp

# 安装sdk包
WORKDIR /home/hwMindX
USER hwMindX
RUN bash $SDK_PKG --quiet --install --install-path=/home/hwMindX/sdk_home  && \
    rm -rf $SDK_PKG