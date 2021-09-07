ARG BASE_VERSION
ARG BASE=ascendbase-infer:$BASE_VERSION
FROM $BASE

ARG ARCH
ARG NNRT_PKG
ARG CHIP=all
ARG ASCEND_BASE=/usr/local/Ascend
WORKDIR /tmp
COPY . ./

ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$ASCEND_BASE/nnrt/latest/acllib/lib64:\
$LD_LIBRARY_PATH

RUN umask 0022 && \
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
    ./$NNRT_PKG --quiet --install --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all $CHIPOPTION && \
    rm $NNRT_PKG && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

ENV ASCEND_AICPU_PATH=$ASCEND_BASE/nnrt/latest \
    PYTHONPATH=$PYTHONPATH:$ASCEND_BASE/nnrt/latest/pyACL/python/site-packages/acl

RUN rm -rf ./*
