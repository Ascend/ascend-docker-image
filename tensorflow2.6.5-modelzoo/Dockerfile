# syntax = docker/dockerfile:experimental
FROM ubuntu:18.04 as buildtemp 

WORKDIR /tmp
COPY . ./

FROM ubuntu:18.04
# 系统包
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
    apt-get -o "Acquire::https::Verify-Peer=false" install -y --no-install-recommends pciutils wget libxml2 g++ automake make xz-utils libbz2-dev libssl-dev vim zip unzip dos2unix autoconf libtool \
    libgl1-mesa-glx zlib1g zlib1g-dev libffi-dev libfreetype6-dev pkg-config libpng-dev numactl libopenblas-dev bzip2 libblas3 liblapack3 liblzma-dev\
    libblas-dev gfortran libhdf5-dev libicu60 libxml2-dev libxslt-dev curl gcc cython3 python3-h5py libgmpxx4ldbl openssl sudo  less htop && \
    apt clean && rm -rf /var/lib/apt/lists/*


ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装python和pip
RUN umask 0022  && \
    curl -k https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz -o Python-3.7.5.tar.xz && \
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
    index-url=http://pypi.douban.com/simple\n\
    trusted-host=pypi.douban.com' >> ~/.pip/pip.conf && \
    pip3 install pip -U

# HwHiAiUser
RUN groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

# 安装python包，pip需升级，不然pip_pkg安装报错
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    ARCH=$(uname -m) && \
    pip3 install -U pip && \
    curl -O https://repo.huaweicloud.com/repository/pypi/packages/b1/51/20098150b6108061cb7542af3de7bfcfe0182bca21613697153e49dc4adc/numpy-1.17.5-cp37-cp37m-manylinux1_x86_64.whl -k && \
    pip3 install numpy-1.17.5-cp37-cp37m-manylinux1_x86_64.whl && \
    pip3 install -r /tmp/requirements.txt && \   
    rm -rf /root/.cache/pip

# 环境变量
ENV GLOG_v=2
ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest
ENV TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe
ENV FWK_PYTHON_PATH=$TOOLKIT_PATH/fwkacllib/python/site-packages
ENV PATH=$TOOLKIT_PATH/fwkacllib/ccec_compiler/bin/:$PATH
ENV ASCEND_OPP_PATH=$TOOLKIT_PATH/opp
ENV PYTHONPATH=$HOST_ASCEND_BASE/tfplugin/latest/tfplugin/python/site-packages:\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH
ENV LD_LIBRARY_PATH=$TOOLKIT_PATH/fwkacllib/lib64:\
/usr/local/Ascend/driver/lib64/common/:\
/usr/local/Ascend/driver/lib64/driver/:\
/usr/local/Ascend/add-ons/:\
/usr/local/Ascend/driver/tools/hccn_tool/:\
$LD_LIBRARY_PATH

# Ascend包
RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    umask 0022  && \
    mkdir -p /home/HwHiAiUser/samples/scripts && \
    chown HwHiAiUser:HwHiAiUser -R /home/HwHiAiUser/samples && \
    cp /tmp/ascend_install.info /etc/ && \
    mkdir -p /usr/local/Ascend/driver/ && \
    cp /tmp/version.info /usr/local/Ascend/driver/ && \
    chmod 755 /usr/local/Ascend && \
    chmod +x /tmp/Ascend-cann-toolkit*.run && \
    bash /tmp/Ascend-cann-toolkit*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
    chmod +x /tmp/Ascend-cann-tfplugin*.run && \
    bash /tmp/Ascend-cann-tfplugin*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all && \
# 安装tensorflow
    ARCH=$(uname -m) && \
    pip3 install /tmp/tensorflow*_${ARCH}.whl && \

# 清理工作
    rm -rf /tmp/* && \
    rm -rf /root/.cache/pip

RUN mkdir -p /user/serverid/devindex/config  && \
    chown -R HwHiAiUser:HwHiAiUser /user/serverid/devindex/config
USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/samples/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Keras-MnasNet_ID3518_for_TensorFlow2.X /home/HwHiAiUser/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X
COPY --chown=HwHiAiUser:HwHiAiUser test_model.sh /home/HwHiAiUser/samples/scripts/test_model.sh
COPY --chown=HwHiAiUser:HwHiAiUser ResNet50_ID0360_for_TensorFlow2.X /home/HwHiAiUser/samples/ResNet50_ID0360_for_TensorFlow2.X
RUN cp /home/HwHiAiUser/samples/ResNet50_ID0360_for_TensorFlow2.X/configs/rank_table_8p.json /user/serverid/devindex/config/hccl.json
WORKDIR /home/HwHiAiUser/