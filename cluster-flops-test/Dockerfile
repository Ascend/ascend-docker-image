# syntax = docker/dockerfile:experimental
FROM ubuntu:18.04 as buildtemp

WORKDIR /tmp
COPY . ./

FROM ubuntu:18.04

ARG NNRT_PKG
ARG TOOLBOX_PKG

RUN sed -i "s@http://.*ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt update && \
    apt install -y --no-install-recommends make g++ zlib1g zlib1g-dev libssl-dev curl && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    umask 0027 && \
    groupadd HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser

WORKDIR /tmp

RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    cp ascend_install.info /etc/ && \
    mkdir -p /usr/local/Ascend/driver/ && \
    cp version.info /usr/local/Ascend/driver/ && \
    chown HwHiAiUser:HwHiAiUser /tmp/*

USER HwHiAiUser

ENV PATH=/home/HwHiAiUser/.local/python3/bin:$PATH \
    LD_LIBRARY_PATH=/home/HwHiAiUser/.local/python3/lib:/usr/local/Ascend/driver/lib64/common/:/usr/local/Ascend/driver/lib64/driver

RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    curl -kO https://repo.huaweicloud.com/python/3.7.5/Python-3.7.5.tgz && \
    tar -xf Python*.tgz && cd Python*/ && ./configure --prefix=/home/HwHiAiUser/.local/python3 --enable-shared && \
    make -j 20 && make install && \
    cd .. && rm -rf Python*.tgz Python*/ && \
    bash $TOOLBOX_PKG --install && \
    bash $NNRT_PKG --install --force && \
    cp docker_flops_test.sh flops_ansible.py /home/HwHiAiUser

WORKDIR /home/HwHiAiUser
