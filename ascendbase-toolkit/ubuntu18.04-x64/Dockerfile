FROM ubuntu:18.04

WORKDIR /tmp
COPY . ./

# 系统包 + Pip3
RUN apt update && \
    apt install --no-install-recommends ca-certificates -y && \
    apt install --no-install-recommends bc wget -y && \
    apt install --no-install-recommends curl gcc make g++ pkg-config unzip -y && \
    apt install --no-install-recommends libblas3 liblapack3 gfortran vim -y && \
    apt install --no-install-recommends liblapack-dev libblas-dev libhdf5-dev libffi-dev -y && \
    apt install --no-install-recommends libssl-dev zlib1g-dev xz-utils -y && \
    apt install --no-install-recommends libopenblas-dev libgmpxx4ldbl liblzma-dev -y && \
    apt install --no-install-recommends libicu60 libxml2 pciutils libgl1-mesa-glx libbz2-dev -y && \
    apt clean && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装Python
RUN umask 0022  && \
    wget https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz && \
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

# python包
RUN pip3 install -U pip && \
    pip3 install numpy && \
    pip3 install decorator && \
    pip3 install sympy==1.4 && \
    pip3 install cffi==1.12.3 && \
    pip3 install pyyaml && \
    pip3 install pathlib2 && \
    pip3 install protobuf && \
    pip3 install scipy && \
    pip3 install requests absl-py && \
    rm -rf /root/.cache/pip

# 设置环境变量
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# 清理临时目录
RUN rm -rf ./*
