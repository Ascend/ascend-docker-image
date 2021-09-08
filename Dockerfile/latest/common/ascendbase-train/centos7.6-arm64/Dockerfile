FROM arm64v8/centos:7

ARG LIBSTDCXX=libstdc++.so.6.0.24
WORKDIR /tmp
COPY . ./

# 安装编译环境
RUN yum -y update&& \
    yum makecache && \
    yum -y install centos-release-scl && \
    yum -y install devtoolset-7 && \
    yum -y install devtoolset-7-gcc-c++ && \
    yum -y install epel-release && \
    yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel \
    sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel \
    xz-devel libffi-devel hdf5-devel libicu patch pciutils && \
    yum -y install blas-devel lapack-devel atlas openblas-devel && \
    yum clean all && \
    rm -rf /var/cache/yum

# scl enable devtoolset-7 bash
SHELL ["/usr/bin/scl", "enable", "devtoolset-7"]

# 安装Python
RUN wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared --prefix=/usr/local/python37 && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig

ENV PATH=$PATH:/usr/local/python37/bin \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/python37/lib

# python包
RUN pip3.7 install -U pip && \
    pip3.7 install decorator && \
    pip3.7 install numpy==1.19.4 && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    rm -rf /root/.cache/pip

# 安装新libstdc++.so
RUN cp -f ./$LIBSTDCXX /lib64/ && \
    chmod +x /lib64/$LIBSTDCXX && \
    ldconfig

# 清理临时目录
RUN rm -rf ./*