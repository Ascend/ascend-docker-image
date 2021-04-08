FROM ubuntu:18.04

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh
WORKDIR /tmp
COPY . ./

SHELL ["/bin/bash", "-c"]

# 系统包 + Pip3.7
RUN { source $SETPROXY || true; } && \
    apt update && \
    apt install --no-install-recommends ca-certificates -y && \
    apt install --no-install-recommends wget -y && \
    apt install --no-install-recommends curl g++ pkg-config unzip -y && \
    apt install --no-install-recommends libblas3 liblapack3 gfortran -y && \
    apt install --no-install-recommends liblapack-dev libblas-dev libhdf5-dev libffi-dev -y && \
    apt install --no-install-recommends libicu60 libxml2 pciutils -y && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    { source $UNSETPROXY || true; }


# 安装Python
RUN { source $SETPROXY || true; } && \
    wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig && \
    { source $UNSETPROXY || true; }

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# python包
RUN { source $SETPROXY || true; } && \
    pip3.7 install -U pip && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    rm -rf /root/.cache/pip && \
    { source $UNSETPROXY || true; }

# 设置环境变量
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# 清理临时目录
RUN rm -rf ./*
