FROM centos:7.6.1810

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh
ARG LIBSTDCXX=libstdc++.so.6.0.24
WORKDIR /tmp
COPY . ./

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && \
    yum makecache && \
    yum -y install centos-release-scl && \
    yum -y install devtoolset-7 && \
    yum -y install devtoolset-7-gcc-c++ && \
    yum -y install epel-release && \
    yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel \
    sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel \
    xz-devel libffi-devel hdf5-devel libicu patch pciutils && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true"

SHELL ["/usr/bin/scl", "enable", "devtoolset-7"]

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && \
    wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tar.xz && \
    tar -xf Python-3.7.5.tar.xz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tar.xz && \
    ldconfig && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true"

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && \
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
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true"

RUN cp -f ./$LIBSTDCXX /lib64/ && \
    chmod +x /lib64/$LIBSTDCXX && \
    ldconfig
