FROM ubuntu:18.04

ARG TRAIN_FRAMEWORK_PKG=mindspore_ascend*.whl
ARG MINDX_ELASTIC_PKG=mindx_elastic*.whl
ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
WORKDIR /tmp

# 系统包,增加libfreetype6-dev pkg-config libpng-dev，否则安装matplotlib报错
RUN echo "deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse\n" > /etc/apt/sources.list && \
    apt-get -o "Acquire::https::Verify-Peer=false" update && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends ca-certificates && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends wget vim sudo openssl \
    libnuma1 curl g++ libfreetype6-dev pkg-config libpng-dev unzip libblas3 liblapack3 liblapack-dev libblas-dev \
    gfortran libhdf5-dev libffi-dev libicu60 libxml2 2to3 python3-lib2to3 python3-toolz libgl1-mesa-glx \
    libbz2-dev libssl-dev less htop && apt clean && rm -rf /var/lib/apt/lists/*

COPY . ./

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装python和pip
RUN curl -k https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz -o Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo '[global] \n\
    index-url=https://pypi.tuna.tsinghua.edu.cn/simple\n\
    trusted-host=pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf && \
    pip3 install pip -U

# HwHiAiUser
RUN groupadd  HwHiAiUser -g 1000 && \
useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

# python包
RUN pip3 install numpy && \
    pip3 install decorator && \
    pip3 install sympy==1.4 && \
    pip3 install cffi==1.12.3 && \
    pip3 install pyyaml && \
    pip3 install pathlib2 && \
    pip3 install grpcio && \
    pip3 install grpcio-tools && \
    pip3 install protobuf && \
    pip3 install scipy && \
    pip3 install requests  && \
    pip3 install wheel && \
    pip3 install setuptools && \
    pip3 install matplotlib && \
    pip3 install opencv-python==4.5.5.64 && \
    pip3 install sklearn==0.0 && \
    pip3 install pandas && \
    pip3 install pycocotools==2.0.6 && \
    pip3 install tables==3.6.1 && \
    pip3 install mmcv==1.7.0 && \
    pip3 install lxml==4.5.2 && \
    pip3 install easydict==1.9 && \
    pip3 install mindinsight && \
    pip3 install scikit-learn==0.24.1 && \
    pip3 install ${MINDX_ELASTIC_PKG} && \
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
RUN pip3 install $TRAIN_FRAMEWORK_PKG && \
    pip3 install $NNAE_PATH/fwkacllib/lib64/te-*.whl && \
    pip3 install $NNAE_PATH/fwkacllib/lib64/topi-*.whl && \
    pip3 install $NNAE_PATH/fwkacllib/lib64/hccl-*.whl 

# 清理工作
RUN rm -f /etc/ascend_install.info && \
    rm -rf /tmp/*

USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Resnet50_Cifar_for_PyTorch /home/HwHiAiUser/samples/Resnet50_Cifar_for_PyTorch
WORKDIR /home/HwHiAiUser/
