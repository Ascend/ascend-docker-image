# syntax = docker/dockerfile:experimental
FROM ubuntu:18.04 as buildtemp 

WORKDIR /tmp
COPY . ./

FROM ubuntu:18.04

ARG SUFFIX=""

# 安装系统依赖
RUN if [ $(arch) = "aarch64" ];then SUFFIX='-ports';fi && \
    echo "deb [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-updates main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-updates main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-backports main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-backports main restricted universe multiverse\n\
    deb [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-security main restricted universe multiverse\n\
    deb-src [trusted=yes] https://repo.huaweicloud.com/ubuntu${SUFFIX}/ bionic-security main restricted universe multiverse\n" > /etc/apt/sources.list && \
    apt-get -o "Acquire::https::Verify-Peer=false" update && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends ca-certificates && \
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends wget vim sudo bzip2 numactl make tar openssl \
    libnuma1 curl g++ libfreetype6-dev pkg-config libpng-dev zip unzip libblas3 liblapack3 liblapack-dev libblas-dev xz-utils \
    gfortran libhdf5-dev libffi-dev libicu60 libxml2 2to3 python3-lib2to3 python3-toolz libgl1-mesa-glx automake libxml2-dev libxml2-dev \
    libsqlite3-dev libzip-dev liblzma-dev zlib1g zlib1g-dev libbz2-dev libopenblas-dev pciutils dos2unix autoconf libtool \
    git patch bc libssl-dev less htop cython3 python3-h5py libgmpxx4ldbl && apt clean && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装python和pip
RUN umask 0022  && \
    curl -kO https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make -j 20 && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo '[global] \n\
    index-url=http://pypi.douban.com/simple\n\
    trusted-host=pypi.douban.com' >> ~/.pip/pip.conf

# HwHiAiUser
RUN groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

# python包
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    pip3 install pip -U && \
    pip3 install -r /tmp/requirements.txt && \
    pip3 install /tmp/mindx_elastic*.whl && \
    pip3 install /tmp/dllogger && \
    rm -rf /root/.cache/pip

# 环境变量
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest
ARG ASCEND_PLUGIN_HOME=/usr/local/Ascend/tfplugin/latest
ENV GLOG_v=2 \
    TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$TOOLKIT_PATH/fwkacllib/python/site-packages \
    PATH=$TOOLKIT_PATH/fwkacllib/ccec_compiler/bin/:$PATH \
    ASCEND_OPP_PATH=$TOOLKIT_PATH/opp \
    ASCEND_PLUGIN_HOME=/usr/local/Ascend/tfplugin/latest \
    PYTHONPATH=$ASCEND_PLUGIN_HOME/python/site-packages:$FWK_PYTHON_PATH:$FWK_PYTHON_PATH/auto_tune.egg:$FWK_PYTHON_PATH/schedule_search.egg:$TBE_IMPL_PATH:$PYTHONPATH \
    LD_LIBRARY_PATH=$TOOLKIT_PATH/fwkacllib/lib64:/usr/local/Ascend/driver/lib64/common/:/usr/local/Ascend/driver/lib64/driver/:/usr/local/Ascend/add-ons/:/usr/local/Ascend/driver/tools/hccn_tool/:$LD_LIBRARY_PATH

# CANN包和TRAIN_FRAMEWORK安装
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    bash /tmp/Ascend-cann-toolkit*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
    cp /tmp/ascend_install.info /etc && \
    mkdir -p /usr/local/Ascend/driver && \
    cp /tmp/version.info /usr/local/Ascend/driver && \
    bash /tmp/Ascend-cann-tfplugin*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
    pip3 install /tmp/mindspore_ascend*.whl && \
    pip3 install $TOOLKIT_PATH/fwkacllib/lib64/te-*.whl && \
    pip3 install $TOOLKIT_PATH/fwkacllib/lib64/topi-*.whl && \
    pip3 install $TOOLKIT_PATH/fwkacllib/lib64/hccl-*.whl && \ 
    pip3 install /tmp/tensorflow*.whl && \
    pip3 install --upgrade /tmp/torch_npu*.whl && \
    pip3 install --upgrade /tmp/apex-0.1+ascend*.whl && \
    pip3 install --upgrade /tmp/torch-*.whl && \
    rm -rf /tmp/*  && \
    rm -rf /root/.cache/pip

USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser samples /home/HwHiAiUser/samples
COPY --chown=HwHiAiUser:HwHiAiUser test_model.sh /home/HwHiAiUser/samples/test_model.sh
WORKDIR /home/HwHiAiUser/