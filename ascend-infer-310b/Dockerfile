# syntax = docker/dockerfile:experimental
FROM ubuntu:22.04 as buildtemp
WORKDIR /tmp
COPY . ./

FROM ubuntu:22.04

ARG ASCEND_BASE=/usr/local/Ascend
WORKDIR /home/AscendWork

# 推理程序需要使用到底层驱动，底层驱动的运行依赖HwHiAiUser，HwBaseUser，HwDmUser三个用户
# 创建运行推理应用的用户及组，HwHiAiUse，HwDmUser，HwBaseUser的UID与GID分别为1000，1101，1102为例
RUN sed -i "s@http://.*ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt update && \
    apt upgrade -y && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    umask 0022 && \
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    groupadd HwDmUser -g 1101 && \
    useradd -d /home/HwDmUser -u 1101 -g 1101 -m -s /bin/bash HwDmUser && \
    usermod -aG HwDmUser HwHiAiUser && \
    groupadd HwBaseUser -g 1102 && \
    useradd -d /home/HwBaseUser -u 1102 -g 1102 -m -s /bin/bash HwBaseUser && \
    usermod -aG HwBaseUser HwHiAiUser

RUN --mount=type=cache,target=/tmp,from=buildtemp,source=/tmp \
    cp /tmp/run.sh /home/AscendWork/ && \
    chmod +x /home/AscendWork/run.sh && \
    bash /tmp/Ascend-cann-nnrt*.run --quiet --install --install-path=$ASCEND_BASE --install-for-all --force && \
    chown -R HwHiAiUser:HwHiAiUser /home/AscendWork/ && \
    ln -sf /lib /lib64 && \
    mkdir /var/dmp && \
    mkdir /usr/slog && \
    chown HwHiAiUser:HwHiAiUser /usr/slog && \
    chown HwHiAiUser:HwHiAiUser /var/dmp

ENV LD_LIBRARY_PATH=/usr/local/Ascend/nnrt/latest/lib64:/usr/local/Ascend/driver/lib64:/usr/lib64
ENV LD_PRELOAD=/lib/aarch64-linux-gnu/libc.so.6
	
# 可使用AICPU算子
RUN cp /usr/local/Ascend/nnrt/latest/opp/Ascend/aicpu/Ascend-aicpu_syskernels.tar.gz /home/HwHiAiUser/ && \
    rm -rf /usr/local/Ascend/nnrt/latest/opp/Ascend/aicpu/Ascend-aicpu_syskernels.tar.gz && \
    echo $(wc -c /home/HwHiAiUser/Ascend-aicpu_syskernels.tar.gz|awk ' {print$1} ') > /home/HwHiAiUser/aicpu_package_install.info && \
    tail -c +8449 /home/HwHiAiUser/Ascend-aicpu_syskernels.tar.gz > /home/HwHiAiUser/aicpu.tar.gz && \
    rm -rf /home/HwHiAiUser/Ascend-aicpu_syskernels.tar.gz && \
    chown HwHiAiUser:HwHiAiUser /home/HwHiAiUser/aicpu.tar.gz && \
    mkdir -p /home/HwHiAiUser/aicpu_kernels && \
    tar -xvf /home/HwHiAiUser/aicpu.tar.gz -C /home/HwHiAiUser/ 2>/dev/null || true && \
    rm -rf /home/HwHiAiUser/aicpu.tar.gz && \
    mv /home/HwHiAiUser/aicpu_kernels_device/* /home/HwHiAiUser/aicpu_kernels/ && \
    chown -R HwHiAiUser:HwHiAiUser /home/HwHiAiUser/

USER 1000
CMD bash /home/AscendWork/run.sh