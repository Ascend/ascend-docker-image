ARG BASE_VERSION
ARG BASE=ascendbase-infer:$BASE_VERSION
FROM $BASE

ARG ARCH
ARG NNRT_PKG
ARG CHIP=all
ARG ASCEND_BASE=/usr/local/Ascend
ARG PREINSTALL=preinstall.sh
ARG POSTINSTALL=postinstall.sh
WORKDIR /tmp
COPY . ./

ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$ASCEND_BASE/nnrt/latest/acllib/lib64:\
$LD_LIBRARY_PATH

SHELL ["/bin/bash", "-c"]

RUN umask 0022 && \
    { source $PREINSTALL || true; }  && \
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
    { source $POSTINSTALL || true; }

ENV ASCEND_AICPU_PATH=$ASCEND_BASE/nnrt/latest/$ARCH-linux

RUN rm -rf ./*
