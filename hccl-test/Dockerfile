ARG BASE_VERSION
ARG BASE=ascend-toolkit:$BASE_VERSION
FROM $BASE

WORKDIR /tmp

ENV TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/mpich-3.2.1/lib:$TOOLKIT_PATH/lib64:$TOOLKIT_PATH/x86_64-linux/devlib

# hccl_test安裝
RUN umask 0022 && \
    curl -O -k https://www.mpich.org/static/downloads/3.2.1/mpich-3.2.1.tar.gz && \
    tar -zxvf mpich-3.2.1.tar.gz && \
    cd mpich-3.2.1 && \
    ./configure --prefix=/usr/local/mpich-3.2.1 && \
    make && \
    make install && \
    cd $TOOLKIT_PATH/tools/hccl_test && \
    make MPI_HOME=/usr/local/mpich-3.2.1 ASCEND_DIR=$TOOLKIT_PATH/x86_64-linux

ENV PATH=$PATH:/usr/local/mpich-3.2.1/bin:$TOOLKIT_PATH/tools/hccl_test/bin

# 安装ssh 
RUN apt-get update && \
    apt-get --no-install-recommends install openssh-server -y && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# 清理临时目录
RUN rm -rf /tmp/* 
COPY hccl_test.sh /tmp/hccl_test.sh