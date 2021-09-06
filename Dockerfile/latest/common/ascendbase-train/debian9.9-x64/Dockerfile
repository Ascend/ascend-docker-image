FROM gcc:7.3.0

WORKDIR /tmp
COPY . ./

# Python 3.7.5
RUN apt update && \
    apt install --no-install-recommends wget unzip zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
    libreadline-dev libffi-dev curl libbz2-dev libhdf5-dev pciutils -y && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig

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

# 环境变量
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# 清理临时目录
RUN rm -rf ./*