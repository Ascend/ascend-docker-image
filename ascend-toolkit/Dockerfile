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

# 2. 训练引擎TOOLKIT安装
ARG TOOLKIT_PKG=Ascend-cann-toolkit_*.run
ARG TOOLKIT_PATH=$ASCEND_BASE/ascend-toolkit/latest

# 安装TOOLKIT

RUN umask 0022 && \
    mkdir -p $ASCEND_BASE/driver && \
    if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $TOOLKIT_PKG && \
    ./$TOOLKIT_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm -f $TOOLKIT_PKG

# TOOLKIT环境变量
ENV GLOG_v=2 \
    LD_LIBRARY_PATH=$TOOLKIT_PATH/fwkacllib/lib64:$LD_LIBRARY_PATH \
    TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$TOOLKIT_PATH/fwkacllib/python/site-packages \
    PATH=$TOOLKIT_PATH/fwkacllib/ccec_compiler/bin:$TOOLKIT_PATH/fwkacllib/bin:$PATH \
    ASCEND_OPP_PATH=$TOOLKIT_PATH/opp \
    ASCEND_AICPU_PATH=$TOOLKIT_PATH

ENV PYTHONPATH=\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH

# 清理临时目录
RUN rm -rf ./*
