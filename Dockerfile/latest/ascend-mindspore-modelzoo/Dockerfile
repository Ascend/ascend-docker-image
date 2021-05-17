FROM ubuntu:18.04

ARG TRAIN_FRAMEWORK_PKG=mindspore_ascend*.whl
ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
ARG PREBUILD_SH=prebuild.sh
ARG POSTBUILD_SH=postbuild.sh
WORKDIR /tmp
COPY . ./

# 触发prebuild.sh
RUN bash -c "test -f $PREBUILD_SH && bash $PREBUILD_SH"

# 系统包
RUN apt update && \
    apt install --no-install-recommends vim sudo openssl libnuma1 python3.7 python3.7-dev curl g++ pkg-config unzip \
        libblas3 liblapack3 liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 libxml2 -y
        
# 建立python软链接
RUN ln -s /usr/bin/python3.7 /usr/bin/python

# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=https://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# pip3.7
RUN cd /tmp && \
    apt-get download python3-distutils && \
    dpkg-deb -x python3-distutils_*.deb / && \
    rm python3-distutils_*.deb && \
    cd - && \
    python3.7 get-pip.py && \
    rm get-pip.py

# HwHiAiUser, hwMindX
RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX

# python包
RUN pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install grpcio && \
    pip3.7 install grpcio-tools && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests

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

# 触发postbuild.sh
RUN bash -c "test -f $POSTBUILD_SH && bash $POSTBUILD_SH" && \
    rm $POSTBUILD_SH
