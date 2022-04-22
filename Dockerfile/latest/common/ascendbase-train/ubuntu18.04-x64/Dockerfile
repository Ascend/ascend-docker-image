FROM ubuntu:18.04

WORKDIR /tmp
COPY . ./

# 系统包 + Pip3.7
RUN apt update && \
    apt install --no-install-recommends ca-certificates -y && \
    apt install --no-install-recommends wget -y && \
    apt install --no-install-recommends curl gcc g++ make pkg-config unzip -y && \
    apt install --no-install-recommends libblas3 liblapack3 gfortran -y && \
    apt install --no-install-recommends liblapack-dev libblas-dev libhdf5-dev libffi-dev libssl-dev -y && \
    apt install --no-install-recommends zlib1g-dev xz-utils libgmpxx4ldbl libopenblas-dev -y && \
    apt install --no-install-recommends libicu60 libxml2 pciutils -y && \
    apt clean && rm -rf /var/lib/apt/lists/*

# 安装Python
RUN wget https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared --prefix=/usr/local/python37 && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig

ENV PATH=$PATH:/usr/local/python37/bin \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/python37/lib

# 配置python pip源
RUN mkdir -p ~/.pip \
&& echo '[global] \n\
index-url=http://pypi.doubanio.com/simple/\n\
trusted-host=pypi.doubanio.com' >> ~/.pip/pip.conf

# python包
RUN pip3.7 install -U pip && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    rm -rf /root/.cache/pip

# 设置环境变量
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# 清理临时目录
RUN rm -rf ./*
