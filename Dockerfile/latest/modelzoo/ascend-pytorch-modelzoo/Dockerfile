FROM ubuntu:18.04

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
    apt install --no-install-recommends wget vim sudo bzip2 wget make tar python3.7 python3.7-dev curl g++ pkg-config unzip numactl libopenblas-dev \
        libblas3 liblapack3 liblapack-dev libblas-dev gfortran libhdf5-dev libffi-dev libicu60 libxml2 libssl-dev git patch -y && \
    wget https://mirrors.tuna.tsinghua.edu.cn/gnu/gcc/gcc-7.3.0/gcc-7.3.0.tar.gz --no-check-certificate && \
    tar -zxf gcc-7.3.0.tar.gz && \
    cd gcc-7.3.0 && \
    ./contrib/download_prerequisites  && \
    ./configure --enable-languages=c,c++ --disable-multilib --with-system-zlib --prefix=/usr/local/gcc7.3.0 && \
     make -j && \
     make install && \
     rm -f /usr/bin/gcc && \
     ln -s /usr/local/gcc7.3.0/bin/gcc /usr/bin/gcc

ENV LD_LIBRARY_PATH=/usr/local/gcc7.3.0/lib64:${LD_LIBRARY_PATH}

# 建立python软链接
RUN ln -s /usr/bin/python3.7 /usr/bin/python && \
    ln -s /usr/bin/python3.7 /usr/bin/python3
        
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
    wget  https://bootstrap.pypa.io/get-pip.py --no-check-certificate  && \
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
    pip3.7 install requests && \
    pip3.7 install attrs && \
    pip3.7 install wheel && \
    pip3.7 install Pillow && \
    pip3.7 install torchvision==0.2.2.post3 && \
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

# Pytorch安装
RUN pip3.7 install --upgrade /tmp/pytorch/dist/torch-1.5.0+ascend*.whl

ENV LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64/:/usr/local/lib/python3.7/dist-packages/torch/lib:/usr/local/Ascend/driver/lib64/:/usr/local/Ascend/driver/lib64/common/:/usr/local/Ascend/driver/lib64/driver/:/usr/local/Ascend/add-ons/:/usr/lib/aarch64_64-linux-gnu:$LD_LIBRARY_PATH
ENV PATH=$PATH:$NNAE_PATH/fwkacllib/ccec_compiler/bin/:$NNAE_PATH/toolkit/tools/ide_daemon/bin/
ENV ASCEND_OPP_PATH=$NNAE_PATH/opp/
ENV OPTION_EXEC_EXTERN_PLUGIN_PATH=$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libfe.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libaicpu_engine.so:$NNAE_PATH/fwkacllib/lib64/plugin/opskernel/libge_local_engine.so
ENV PYTHONPATH=$NNAE_PATH/fwkacllib/python/site-packages/:$NNAE_PATH/fwkacllib/python/site-packages/auto_tune.egg/auto_tune:$NNAE_PATH/fwkacllib/python/site-packages/schedule_search.egg:$PYTHONPATH
ENV ASCEND_AICPU_PATH=$NNAE_PATH

# 安装apex
RUN cp -rf /tmp/FrameworkPTAdapter-apex*.patch /tmp/apex && \
    cd /tmp/apex && \
    patch -p1 < FrameworkPTAdapter-apex*.patch 
    
RUN python3.7 setup.py --npu_float_status bdist_wheel && \
    cd dist && \
    pip3.7 install --upgrade apex-0.1+ascend*.whl && \
	pip3.7 install /tmp/tensor_fused_plugin-0.1+ascend*.whl && \
	cd ../..

# 日志包安装
RUN cd /tmp/dllogger-master/dllogger/ && \
    python3.7 setup.py build && \
    python3.7 setup.py install

# 触发postbuild.sh
RUN bash -c "test -f $POSTBUILD_SH && bash $POSTBUILD_SH" && \
    rm $POSTBUILD_SH
