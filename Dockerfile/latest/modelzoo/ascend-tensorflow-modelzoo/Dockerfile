FROM ubuntu:18.04

ARG TF_PKG=tensorflow-1.15.0-cp37-cp37m-*.whl
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
    apt install --no-install-recommends vim sudo openssl python3.7 python3.7-dev curl g++ pkg-config unzip \
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
RUN pip3.7 install pip_pkg/*.whl && \
    pip3.7 install pip_pkg/*.tar.gz && \
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

# Ascend包
RUN bash $INSTALL_ASCEND_PKGS_SH

# 环境变量
ENV GLOG_v=2
ENV TBE_IMPL_PATH=$NNAE_PATH/opp/op_impl/built-in/ai_core/tbe
ENV FWK_PYTHON_PATH=$NNAE_PATH/fwkacllib/python/site-packages
ENV PATH=$NNAE_PATH/fwkacllib/ccec_compiler/bin/:$PATH
ENV ASCEND_OPP_PATH=$NNAE_PATH/opp
ENV PYTHONPATH=$HOST_ASCEND_BASE/tfplugin/latest/tfplugin/python/site-packages:\
$FWK_PYTHON_PATH:\
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

# TF安装
RUN pip3.7 install $TF_PKG

# 触发postbuild.sh
RUN bash -c "test -f $POSTBUILD_SH && bash $POSTBUILD_SH" && \
    rm $POSTBUILD_SH
