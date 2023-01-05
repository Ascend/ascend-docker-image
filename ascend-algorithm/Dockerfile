ARG BASE_VERSION
ARG BASE=ascendbase-toolkit:$BASE_VERSION
FROM $BASE

ARG CHIP=all
WORKDIR /tmp
COPY . ./

# 1. 驱动路径环境变量设置
ARG ASCEND_BASE=/usr/local/Ascend
ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$LD_LIBRARY_PATH

# 2. 推理引擎NNRT安装
ARG NNRT_PKG=Ascend-cann-nnrt*.run
ARG NNRT_PATH=$ASCEND_BASE/nnrt/latest

# 安装NNRT

RUN umask 0022 && \
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    cp run.sh /home/ && \
    chmod +x /home/run.sh && \
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $NNRT_PKG && \
    ./$NNRT_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm -f $NNRT_PKG && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

# NNRT环境变量
ENV GLOG_v=2 \
    LD_LIBRARY_PATH=$NNRT_PATH/fwkacllib/lib64:$LD_LIBRARY_PATH \
    TBE_IMPL_PATH=$NNRT_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$NNRT_PATH/fwkacllib/python/site-packages \
    PATH=$NNRT_PATH/fwkacllib/ccec_compiler/bin:$NNRT_PATH/fwkacllib/bin:$PATH \
    ASCEND_OPP_PATH=$NNRT_PATH/opp \
    ASCEND_AICPU_PATH=$NNRT_PATH

ENV PYTHONPATH=\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/Ascend/driver/lib64:/usr/local/Ascend/driver/lib64/common:/usr/local/Ascend/driver/lib64/driver\
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/Ascend/nnrt/latest/acllib/lib64 \
    PYTHONPATH=$PYTHONPATH:/usr/local/Ascend/nnrt/latest/pyACL/python/site-packages/acl \
    ASCEND_AICPU_PATH=/usr/local/Ascend/nnrt/latest

# 清理临时目录
RUN rm -rf ./*
USER HwHiAiUser
CMD ["/bin/bash", "-c", "/home/run.sh"]
