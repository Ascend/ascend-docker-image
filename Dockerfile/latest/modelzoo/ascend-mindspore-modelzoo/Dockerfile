FROM ubuntu:18.04

ARG VERSION
ARG TRAIN_FRAMEWORK_PKG=mindspore_ascend*.whl
ARG MINDX_ELASTIC_PKG=mindx_elastic-${VERSION}-py3-none-any.whl
ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
ARG POSTBUILD_SH=postbuild.sh
WORKDIR /tmp
COPY . ./
SHELL ["/bin/bash","-c"]

# 系统包,增加libfreetype6-dev pkg-config libpng-dev，否则安装matplotlib报错
RUN apt update && \
    apt install -y --no-install-recommends wget vim sudo openssl libnuma1 python3.7 python3.7-dev curl g++ libfreetype6-dev pkg-config libpng-dev unzip \
        libblas3 liblapack3 liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 libxml2 2to3 python3-lib2to3 python3-toolz && \
        apt clean && rm -rf /var/lib/apt/lists/*
        
# 建立python软链接
RUN ln -sf /usr/bin/python3.7 /usr/bin/python3

# pip3.7
RUN cd /tmp && \
    apt-get download python3-distutils && \
    dpkg-deb -x python3-distutils_*.deb / && \
    rm python3-distutils_*.deb && \
    wget  https://bootstrap.pypa.io/get-pip.py --no-check-certificate  && \
    python3.7 get-pip.py && \
    rm get-pip.py

# HwHiAiUser, hwMindX
RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX

# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo -e '[global] \n\
index-url=https://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# python包
RUN pip3.7 install pip -U && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install grpcio && \
    pip3.7 install grpcio-tools && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests  && \
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
    pip3.7 install easydict==1.9 && \
    pip3.7 install mindinsight && \
    pip3.7 install scikit-learn==0.24.1 && \
    pip3.7 install ${MINDX_ELASTIC_PKG} && \
    rm -rf /root/.cache/pip

# Ascend包
RUN bash $INSTALL_ASCEND_PKGS_SH

# 环境变量
ENV GLOG_v=2
ENV TBE_IMPL_PATH=$NNAE_PATH/opp/op_impl/built-in/ai_core/tbe
ENV FWK_PYTHON_PATH=$NNAE_PATH/fwkacllib/python/site-packages
ENV PATH=$NNAE_PATH/fwkacllib/ccec_compiler/bin/:$PATH
ENV ASCEND_OPP_PATH=$NNAE_PATH/opp
ENV PYTHONPATH=$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH
ENV LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64:\
/usr/local/Ascend/driver/lib64/common/:\
/usr/local/Ascend/driver/lib64/driver/:\
/usr/local/Ascend/add-ons/:\
/usr/local/Ascend/driver/tools/hccn_tool/:\
$LD_LIBRARY_PATH

# TRAIN_FRAMEWORK安装
RUN pip3.7 install $TRAIN_FRAMEWORK_PKG && \
    pip3.7 install $NNAE_PATH/fwkacllib/lib64/te-*.whl && \
    pip3.7 install $NNAE_PATH/fwkacllib/lib64/topi-*.whl && \
    pip3.7 install $NNAE_PATH/fwkacllib/lib64/hccl-*.whl 

# 清理工作
RUN rm -f /etc/ascend_install.info && \
    rm -rf /tmp/*

USER hwMindX