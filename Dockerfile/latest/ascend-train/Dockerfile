ARG BASE_VERSION
ARG BASE=ascendbase-train:$BASE_VERSION
FROM $BASE

ARG CHIP=all
ARG PREINSTALL=preinstall.sh
ARG POSTINSTALL=postinstall.sh
WORKDIR /tmp
COPY . ./

ARG ASCEND_BASE=/usr/local/Ascend
ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$LD_LIBRARY_PATH

ARG NNAE_PKG
ARG NNAE_PATH=$ASCEND_BASE/nnae/latest

RUN bash -c "test -f $PREINSTALL && bash $PREINSTALL || true" && rm -f $PREINSTALL && \
     if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $NNAE_PKG && \
    ./$NNAE_PKG --quiet --install --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all $CHIPOPTION && \
    rm -f $NNAE_PKG && \
    bash -c "test -f $POSTINSTALL && bash $POSTINSTALL || true" && rm -f $POSTINSTALL

ENV GLOG_v=2 \
    LD_LIBRARY_PATH=$NNAE_PATH/fwkacllib/lib64:$LD_LIBRARY_PATH \
    TBE_IMPL_PATH=$NNAE_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$NNAE_PATH/fwkacllib/python/site-packages \
    PATH=$NNAE_PATH/fwkacllib/ccec_compiler/bin:$NNAE_PATH/fwkacllib/bin:$PATH \
    ASCEND_OPP_PATH=$NNAE_PATH/opp \
    ASCEND_AICPU_PATH=$NNAE_PATH

ENV PYTHONPATH=\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH

RUN rm -rf ./*
