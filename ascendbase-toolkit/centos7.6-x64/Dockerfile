FROM centos:7.6

ARG LIBSTDCXX=libstdc++.so.6.0.24
WORKDIR /tmp
COPY . ./

# 安装编译环境
RUN yum -y update && \
    yum makecache && \
    yum -y install centos-release-scl && \
    yum -y install devtoolset-7 && \
    yum -y install devtoolset-7-gcc-c++ && \
    yum -y install epel-release && \
    yum -y install bc wget zlib-devel bzip2-devel openssl-devel ncurses-devel \
    sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel \
    xz-devel libffi-devel hdf5-devel libicu patch pciutils mesa-libGL \
    blas-devel lapack-devel python-backports-lzma openblas.x86_64 openblas-devel.x86_64 && \
    yum clean all && \
    rm -rf /var/cache/yum

SHELL ["/usr/bin/scl", "enable", "devtoolset-7"]

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装Python
RUN umask 0022  && \
    wget https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo -e '[global] \n\
    index-url=http://mirrors.aliyun.com/pypi/simple\n\
    trusted-host=mirrors.aliyun.com' >> ~/.pip/pip.conf && \
    pip3 install pip -U

# python包
RUN pip3 install -U pip && \
    pip3 install decorator numpy kiwisolver matplotlib \
    sympy cffi pyyaml pathlib2 cython cycler grpcio grpcio-tools && \
    pip3 install protobuf scipy requests psutil mpmath Pillow && \
    pip3 install pycocotools attrs attr absl-py && \
    rm -rf /root/.cache/pip

# 安装zlib-1.2.9
RUN wget https://www.zlib.net/fossils/zlib-1.2.9.tar.gz --no-check-certificate && \
    tar -zxvf zlib-1.2.9.tar.gz && \
    cd zlib-1.2.9 && \
    ./configure --libdir=/lib64/ && \
    make && \
    make install && \
    rpm -qa | grep zlib | xargs rpm -e --nodeps && \
    ldconfig

# 安装新libstdc++.so
RUN cp -f ./$LIBSTDCXX /lib64/ && \
    chmod 755 /lib64/$LIBSTDCXX && \
    ldconfig

# 设置容器gcc默认版本
RUN echo "source /opt/rh/devtoolset-7/enable" >> /etc/bashrc

# 清理临时目录
RUN rm -rf ./*
