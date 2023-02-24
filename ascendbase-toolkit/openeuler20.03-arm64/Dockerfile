FROM openeuler-20.03-lts-sp2:latest

WORKDIR /tmp
COPY . ./

# 安装编译环境
RUN yum install -y bc wget gcc gcc-c++ make libtool zlib zlib-devel bzip2 bzip2-devel pcre sudo libffi-devel\
    pcre-devel pcre2-devel perl-devel perl-ExtUtils-Embed openssl openssl-devel python-pip && \
    yum clean all && \
    rm -rf /var/cache/yum

ENV LD_LIBRARY_PATH=/usr/local/python3.7.5/lib: \
    PATH=/usr/local/python3.7.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# 安装Python
RUN umask 0022  && \
    wget https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tgz && \
    tar -xf Python-3.7.5.tgz && cd Python-3.7.5 && ./configure --prefix=/usr/local/python3.7.5 --enable-shared && \
    make && make install && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/python3.7.5/bin/python3 /usr/bin/python && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip3 && \
    ln -sf /usr/local/python3.7.5/bin/pip3 /usr/bin/pip && \
    cd .. && \
    rm -rf Python* && \
    mkdir -p ~/.pip  && \
    echo -e '[global] \n\
    index-url=http://pypi.douban.com/simple\n\
    trusted-host=pypi.douban.com' >> ~/.pip/pip.conf && \
    pip3 install pip -U

# python包
RUN pip3 install -U pip && \
    pip3 install decorator numpy kiwisolver matplotlib \
    sympy cffi pyyaml pathlib2 cython cycler grpcio grpcio-tools && \
    pip3 install protobuf scipy requests mpmath Pillow && \
    pip3 install pycocotools && \
    rm -rf /root/.cache/pip

# 清理临时目录
RUN rm -rf ./*
