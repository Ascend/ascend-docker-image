ARG BASE_VERSION
ARG BASE=ascend-toolkit:$BASE_VERSION
FROM $BASE

WORKDIR /tmp
COPY . ./

ARG ASCEND_BASE=/usr/local/Ascend

SHELL ["/bin/bash","-c"]

RUN umask 0022 && \
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    pip3 install easydict && \
    mkdir -p $ASCEND_BASE/driver && \
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
        pip3 install psutil; \
    fi && \
    pip3 install /tmp/mindspore*.whl && \
    pip3 install /usr/local/Ascend/ascend-toolkit/latest/fwkacllib/lib64/te-*.whl && \
    rm -rf $ASCEND_BASE/driver && \
    rm -rf /tmp/*

ENV GLOG_v=2
ARG TOOLKIT_PATH=/usr/local/Ascend/ascend-toolkit/latest
ENV TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe
ENV PYTHONPATH=$TBE_IMPL_PATH:$PYTHONPATH
ENV PATH=$TOOLKIT_PATH/ccec_compiler/bin/:$PATH

USER HwHiAiUser

COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
COPY --chown=HwHiAiUser:HwHiAiUser Resnet50_Cifar_for_MindSpore /home/HwHiAiUser/Resnet50_Cifar_for_MindSpore
COPY --chown=HwHiAiUser:HwHiAiUser test_model.sh /home/HwHiAiUser/test_model.sh
WORKDIR /home/HwHiAiUser/