FROM ubuntu:18.04

ARG ASCEND_BASE=/usr/local/Ascend
ARG ATC_PKG=Ascend-atc*.run
ARG NNRT_PKG=Ascend-cann-nnrt*.run
ARG OPP_PKG=Ascend-opp*.run
ARG PREBUILD_SH=prebuild.sh

WORKDIR /tmp
COPY . ./

# 触发prebuild.sh
RUN bash -c "test -f $PREBUILD_SH && bash $PREBUILD_SH"

RUN apt update && \
    apt install --no-install-recommends pciutils wget libxml2 g++ automake make xz-utils libssl-dev vim zip unzip dos2unix autoconf libtool libgl1-mesa-glx zlib1g zlib1g-dev libffi-dev -y && \
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

# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=https://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# pip3.7
RUN cd /tmp && \
    apt-get download python3-distutils && \
    dpkg-deb -x python3-distutils_*.deb / && \
    rm python3-distutils_*.deb

RUN pip3.7 install numpy && \
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



# install nnrt run pkg
RUN bash -c 'umask 0022' && \
    chmod +x $NNRT_PKG && \
    ./$NNRT_PKG --quiet --install --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm $NNRT_PKG
	
# install atc run pkg
RUN chmod +x $ATC_PKG && \
    ./$ATC_PKG --quiet --run --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm $ATC_PKG

# install opp run pkg
RUN chmod +x $OPP_PKG && \
    ./$OPP_PKG --quiet --run --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm $OPP_PKG

ENV ASCEND_HOME=$ASCEND_BASE
ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/nnrt/latest/acllib/lib64:\
$ASCEND_BASE/atc/lib64:\
$LD_LIBRARY_PATH
ENV PYTHONPATH=\
$ASCEND_BASE/nnrt/latest/pyACL/python/site-packages/acl:\
$ASCEND_BASE/atc/python/site-packages:\
$ASCEND_BASE/atc/python/site-packages/auto_tune.egg/auto_tune:\
$ASCEND_BASE/atc/python/site-packages/schedule_search.egg:\
$PYTHONPATH
ENV ASCEND_AICPU_PATH=$ASCEND_BASE/nnrt/latest
ENV PATH=\
$ASCEND_BASE/atc/ccec_compiler/bin:\
$ASCEND_BASE/atc/bin:\
$PATH
ENV ASCEND_OPP_PATH=$ASCEND_BASE/opp

RUN rm -rf ./*