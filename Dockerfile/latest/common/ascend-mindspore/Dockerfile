ARG BASE_VERSION
ARG BASE=ascend-train:$BASE_VERSION
FROM $BASE

WORKDIR /tmp
COPY . ./

ARG ASCEND_BASE=/usr/local/Ascend

# MindSpore安装
ARG VERSION=1.5.0
# 注：centos7需激活SHELL，ubuntu18.04需注释
SHELL ["/usr/bin/scl", "enable", "devtoolset-7"]

# 注：Ubuntu18.04需修改默认SHELL为bash，或者下面的RUN语句后改为bash -c '执行语句'
RUN umask 0022 && \
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver && \
    cp ascend_install.info /etc/ && \
    declare -A ARCHS_SUFFIX=(['x86_64']='x86' ['aarch64']='aarch64') && \
    ARCH=$(uname -m) && \
    OS_ID=$(grep -oP "^ID=\"?\K\w+" /etc/os-release) && \
    if [ "$OS_ID" == "ubuntu" ]; then \
        apt-get update; \
        apt-get install --no-install-recommends libnuma1 libgomp1 libxml2 -y; \
        rm -rf /var/lib/apt/lists/*; \
    elif [ "$OS_ID" == "centos" ]; then \
        yum makecache fast; \
        yum -y install numactl-libs libgomp libxml2; \
        yum clean all; \
    fi && \
    if [ "$ARCH" == "aarch64" ]; then \
        pip3 install \
        --index-url https://pypi.obs-website.cn-east-2.myhuaweicloud.com/simple/ \
        --trusted-host pypi.obs-website.cn-east-2.myhuaweicloud.com \
        psutil; \
    fi && \
    pip3 install \
    https://ms-release.obs.cn-north-4.myhuaweicloud.com/${VERSION}/MindSpore/ascend/${ARCH}/mindspore_ascend-${VERSION}-cp37-cp37m-linux_${ARCH}.whl \
    --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com \
    -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info && \
    rm -rf /root/.cache/pip && \
    rm -rf /tmp/*
    