ARG BASE_VERSION
ARG BASE=ascendbase-infer:$BASE_VERSION
FROM $BASE

ARG NNRT_PKG
ARG ASCEND_BASE=/usr/local/Ascend
WORKDIR /tmp
COPY . ./

ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/nnrt/latest/acllib/lib64:\
$LD_LIBRARY_PATH

RUN umask 0022 && \
    chmod +x $NNRT_PKG && \
    ./$NNRT_PKG --quiet --install --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm $NNRT_PKG

RUN rm -rf ./*

