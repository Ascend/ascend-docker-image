FROM ubuntu:18.04

ARG ASCEND_BASE=/usr/local/Ascend
ARG PREBUILD_SH=prebuild.sh
ARG TOOLKIT_PKG=Ascend-cann-toolkit*.run
ARG MX_SDK_HOME=/usr/local/sdk_home/mxManufacture
WORKDIR /tmp
# 触发prebuild.sh
RUN bash -c "test -f $PREBUILD_SH && bash $PREBUILD_SH"

COPY cmake-3.16.5.tar.gz /tmp

#安装系统依赖和pip3.7
RUN apt update && \
    apt install -y --no-install-recommends pciutils wget libxml2 g++ automake make xz-utils libssl-dev vim zip unzip dos2unix autoconf libtool \
    libgl1-mesa-glx zlib1g zlib1g-dev libffi-dev libfreetype6-dev pkg-config libpng-dev numactl libopenblas-dev bzip2 libblas3 liblapack3 \
    libblas-dev gfortran libhdf5-dev libicu60 libxml2-dev libxslt-dev ca-certificates curl gcc cython3 python3-h5py libgmpxx4ldbl && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    if [ ! -d "/lib64" ]; \
    then \
        mkdir /lib64 && ln -sf /lib/ld-linux-aarch64.so.1 /lib64/ld-linux-aarch64.so.1; \
    fi

RUN tar -zxvf Python-3.7.5.tgz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -s /usr/local/python3.7.5/bin/python3 /usr/bin/python3.7 && \
    ln -s /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3.7 && \
    ln -s /usr/local/python3.7.5/bin/python3 /usr/bin/python3.7.5 && \
    ln -s /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3.7.5 && \
    ln -s /usr/local/python3.7.5/bin/python3 /usr/local/python3.7.5/bin/python3.7.5 && \
    ln -s /usr/local/python3.7.5/bin/pip3 /usr/local/python3.7.5/bin/pip3.7.5 && \
    cd ..
	
ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python3.7.5/bin:$PATH
	
# 源码安装cmake 3.16.5
RUN apt autoremove cmake && \
    tar -zxvf cmake-3.16.5.tar.gz && \
    cd cmake-3.16.5 && \
    ./bootstrap && \
    make && \
    make install && \
    cd ..

RUN pip3.7 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
	pip3.7 install protobuf && \
	pip3.7 install Cython && \
	pip3.7 install wheel==0.32.1 && \
	pip3.7 install setuptools==49.1.0 && \
	pip3.7 install matplotlib==3.2.2 && \
	pip3.7 install opencv-python==4.4.0.42 && \
	pip3.7 install sklearn==0.0 && \
	pip3.7 install pandas==1.0.5 && \
	pip3.7 install pycocotools==2.0.1 && \
	pip3.7 install tables==3.6.1 && \
	pip3.7 install mmcv==0.2.14 && \
	pip3.7 install lxml==4.5.2 && \
	pip3.7 install easydict==1.9

COPY . ./
# install toolkit pkg
RUN bash -c 'umask 0022' && \
    chmod +x $TOOLKIT_PKG && \
    ./$TOOLKIT_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all && \
    rm $TOOLKIT_PKG

ENV ASCEND_HOME=$ASCEND_BASE

RUN unset PYTHONPATH && \
    unset ASCEND_AICPU_PATH && \
    unset LD_LIBRARY_PATH
# LD_LIBRARY_PATH最后两个目录需要根据架构设置对应的目录，这里用的x86的，arm的需要修改
ENV PYTHONPATH=/usr/local/sdk_home/mxManufacture/python:$ASCEND_BASE/ascend-toolkit/latest/pyACL/python/site-packages/acl:\
$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages:$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages/auto_tune.egg/auto_tune:\
$ASCEND_BASE/ascend-toolkit/latest/atc/python/site-packages/schedule_search.egg \
ASCEND_AICPU_PATH=$ASCEND_BASE/ascend-toolkit/latest \
MX_SDK_HOME=/usr/local/sdk_home/mxManufacture/ \
GST_PLUGIN_SCANNER=${MX_SDK_HOME}/opensource/libexec/gstreamer-1.0/gst-plugin-scanner \
GST_PLUGIN_PATH=${MX_SDK_HOME}/opensource/lib/gstreamer-1.0:${MX_SDK_HOME}/lib/plugins \
LD_LIBRARY_PATH=${MX_SDK_HOME}/lib:${MX_SDK_HOME}/opensource/lib:${MX_SDK_HOME}/opensource/lib64:\
/usr/local/Ascend/driver/lib64:/usr/local/Ascend/ascend-toolkit/latest/acllib/lib64:\
/usr/local/Ascend/ascend-toolkit/latest/atc/lib64:/usr/local/python3.7.5/lib:\
/usr/local/Ascend/ascend-toolkit/latest/x86_64-linux/x86_64-linux/devlib/:\
/usr/local/Ascend/ascend-toolkit/latest/x86_64-linux/runtime/lib64/stub/

ENV PATH=\
$ASCEND_BASE/ascend-toolkit/latest/atc/ccec_compiler/bin:\
$ASCEND_BASE/ascend-toolkit/latest/atc/bin:\
$PATH

ENV ASCEND_OPP_PATH=$ASCEND_BASE/ascend-toolkit/latest/opp

# 安装sdk包
ARG SDK_PKG=Ascend-mindxsdk*.run

RUN chmod +x $SDK_PKG && \
    ./$SDK_PKG --quiet --install --install-path=/usr/local/sdk_home  && \
    rm -rf $SDK_PKG && \
    rm -rf /tmp/*
