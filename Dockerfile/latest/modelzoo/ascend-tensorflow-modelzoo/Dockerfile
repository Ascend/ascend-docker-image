FROM ubuntu:18.04

# x64的改为TF_PKG=tensorflow-cpu=1.15.0
ARG TF_PKG=tensorflow-1.15.0-cp37-cp37m-*.whl

ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
WORKDIR /tmp

# 系统包
RUN apt update && \
    apt install -y --no-install-recommends pciutils wget libxml2 g++ automake make xz-utils libbz2-dev libssl-dev vim zip unzip dos2unix autoconf libtool \
    libgl1-mesa-glx zlib1g zlib1g-dev libffi-dev libfreetype6-dev pkg-config libpng-dev numactl libopenblas-dev bzip2 libblas3 liblapack3 liblzma-dev\
    libblas-dev gfortran libhdf5-dev libicu60 libxml2-dev libxslt-dev ca-certificates curl gcc cython3 python3-h5py libgmpxx4ldbl openssl sudo  less htop && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY . ./

# 安装python和pip
RUN tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    cd .. && \
    rm -rf Python*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python3.7.5/bin:$PATH

# HwHiAiUser, hwMindX
RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX
    
# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=http://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# 安装python包，pip需升级，不然pip_pkg安装报错
RUN pip3 install -U pip && \
    pip3 install pip_pkg/*.whl && \
    pip3 install pip_pkg/*.tar.gz && \
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
RUN pip3 install $TF_PKG

# 清理工作
RUN rm -f /etc/ascend_install.info && \
    rm -rf /tmp/*

USER hwMindX