ARG BASE_VERSION
ARG BASE=ascendbase-infer:$BASE_VERSION
FROM $BASE

ARG NNRT_PKG=Ascend-cann-nnrt*.run
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
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    mkdir -p $ASCEND_BASE/driver && \
    if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $NNRT_PKG && \
    ./$NNRT_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm $NNRT_PKG && \
    rm -rf $ASCEND_BASE/driver && \
    rm -rf ./*

ENV ASCEND_AICPU_PATH=$ASCEND_BASE/nnrt/latest \
    PYTHONPATH=$PYTHONPATH:$ASCEND_BASE/nnrt/latest/pyACL/python/site-packages/acl

USER HwHiAiUser
