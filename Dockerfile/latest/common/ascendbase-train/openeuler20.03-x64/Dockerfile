FROM openeuler-20.03-lts-sp2:latest

WORKDIR /tmp
COPY . ./

# 安装编译环境
RUN yum install -y wget gcc gcc-c++ make libtool zlib zlib-devel pcre sudo libffi-devel\
    pcre-devel pcre2-devel perl-devel perl-ExtUtils-Embed openssl openssl-devel python-pip && \
    yum clean all && \
    rm -rf /var/cache/yum


# 安装Python
RUN wget https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tgz && \
    tar -xf Python-3.7.5.tgz && \
    cd Python-3.7.5 && \
    mkdir build && cd build && \
    ../configure --enable-shared --prefix=/usr/local/python37 && \
    make -j && make install && \
    cd .. && rm -rf build && cd .. && rm -rf Python-3.7.5 && rm -f Python-3.7.5.tgz && \
    ldconfig


ENV PATH=$PATH:/usr/local/python37/bin \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/python37/lib

# python包
RUN pip3.7 install -U pip -i https://pypi.mirrors.ustc.edu.cn/simple && \
    pip3.7 install decorator numpy kiwisolver matplotlib \
    sympy cffi pyyaml pathlib2 cython cycler grpcio grpcio-tools \
    -i https://pypi.mirrors.ustc.edu.cn/simple && \
    pip3.7 install protobuf scipy requests mpmath Pillow \
    -i https://pypi.mirrors.ustc.edu.cn/simple && \
    pip3 install pycocotools -i https://pypi.mirrors.ustc.edu.cn/simple && \
    rm -rf /root/.cache/pip

# 清理临时目录
RUN rm -rf ./*
