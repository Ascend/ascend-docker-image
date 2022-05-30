FROM ubuntu:18.04

ARG HOST_ASCEND_BASE=/usr/local/Ascend
ARG NNAE_PATH=/usr/local/Ascend/nnae/latest
ARG INSTALL_ASCEND_PKGS_SH=install_ascend_pkgs.sh
WORKDIR /tmp

# 系统包
RUN apt update && \
    apt install -y --no-install-recommends wget vim sudo bzip2 wget make tar curl g++ pkg-config unzip numactl \
    libopenblas-dev libblas3 liblapack3 liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 libxml2 libbz2-dev libssl-dev git patch libfreetype6-dev pkg-config libpng-dev libgl1-mesa-glx less htop && \
    apt clean && rm -rf /var/lib/apt/lists/*

# 下载gcc及依赖    
RUN wget https://mirrors.tuna.tsinghua.edu.cn/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz --no-check-certificate && \
    tar -zxf gcc-7.3.0.tar.gz && \
    cd gcc-7.3.0 && \
    wget https://mirrors.huaweicloud.com/gnu/gmp/gmp-6.1.0.tar.bz2 --no-check-certificate && \
    wget https://mirrors.huaweicloud.com/gnu/mpfr/mpfr-3.1.4.tar.bz2 --no-check-certificate && \
    wget https://mirrors.huaweicloud.com/gnu/mpc/mpc-1.0.3.tar.gz --no-check-certificate && \
    wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.16.1.tar.bz2 --no-check-certificate
    
RUN cd gcc-7.3.0 && ./contrib/download_prerequisites  && \
    ./configure --enable-languages=c,c++ --disable-multilib --with-system-zlib --prefix=/usr/local/gcc7.3.0 && \
     make -j20 && \
     make install && \
     rm -f /usr/bin/gcc && \
     ln -s /usr/local/gcc7.3.0/bin/gcc /usr/bin/gcc && \
     rm -rf /tmp/*

ENV LD_LIBRARY_PATH=/usr/local/gcc7.3.0/lib64:${LD_LIBRARY_PATH}

# 安装python和pip
COPY Python-3.7.5.tar.xz /tmp

RUN tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    cd .. && \
    rm -rf Python*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/local/python3.7.5/bin:$PATH
        
# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=http://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# HwHiAiUser, hwMindX
RUN useradd -d /home/hwMindX -u 9000 -m -s /bin/bash hwMindX && \
    useradd -d /home/HwHiAiUser -u 1000 -m -s /bin/bash HwHiAiUser && \
    usermod -a -G HwHiAiUser hwMindX

# python包
RUN pip3 install pip -U && \
    pip3 install numpy && \
    pip3 install decorator && \
    pip3 install sympy==1.4 && \
    pip3 install cffi==1.12.3 && \
    pip3 install pyyaml && \
    pip3 install pathlib2 && \
    pip3 install grpcio && \
    pip3 install grpcio-tools && \
    pip3 install protobuf && \
    pip3 install scipy && \
    pip3 install requests && \
    pip3 install attrs && \
    pip3 install wheel && \
    pip3 install Pillow==6.2.2 && \
    pip3 install torchvision==0.2.2.post3 && \
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

# Ascend包
RUN bash $INSTALL_ASCEND_PKGS_SH

# Pytorch安装
RUN pip3 install --upgrade torch-1.5.0+ascend*.whl

ENV LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64/:/usr/local/python3.7.5/lib/python3.7/site-packages/torch/lib:/usr/local/Ascend/driver/lib64/:/usr/local/Ascend/driver/lib64/common/:/usr/local/Ascend/driver/lib64/driver/:/usr/local/Ascend/add-ons/:/usr/lib/aarch64_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH=$PATH:$NNAE_PATH/fwkacllib/ccec_compiler/bin/:$NNAE_PATH/toolkit/tools/ide_daemon/bin/
ENV ASCEND_OPP_PATH=$NNAE_PATH/opp/
ENV OPTION_EXEC_EXTERN_PLUGIN_PATH=$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libfe.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libaicpu_engine.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libge_local_engine.so
ENV PYTHONPATH=$NNAE_PATH/fwkacllib/python/site-packages/:$NNAE_PATH/fwkacllib/python/site-packages/auto_tune.egg/auto_tune:$NNAE_PATH/fwkacllib/python/site-packages/schedule_search.egg:$PYTHONPATH
ENV ASCEND_AICPU_PATH=$NNAE_PATH

# 安装apex
    
RUN pip3 install --upgrade apex-0.1+ascend*.whl

# 日志包安装
RUN cd /tmp/dllogger-master/ && \
    python3 setup.py build && \
    python3 setup.py install

# 清理工作
RUN rm -f /etc/ascend_install.info && \
    rm -rf /tmp/*

USER hwMindX