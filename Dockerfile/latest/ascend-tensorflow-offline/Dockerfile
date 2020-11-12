ARG BASE_VERSION
ARG BASE=ascend-train:$BASE_VERSION
FROM $BASE

ARG PREINSTALL=preinstall.sh
ARG POSTINSTALL=postinstall.sh
WORKDIR /tmp
COPY . ./

ARG TFPLUGIN_PKG
ARG TF_1_15_OFFLINE_PKG
ARG ASCEND_BASE=/usr/local/Ascend
ARG TF_PLUGIN_PATH=$ASCEND_BASE/tfplugin/latest

RUN bash $PREINSTALL && rm -f $PREINSTALL && \ 
    chmod +x ./$TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --quiet --install --install-path=$ASCEND_BASE --install-username=root --install-usergroup=root \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    bash $POSTINSTALL && rm -f $POSTINSTALL

RUN chmod +x $TF_1_15_OFFLINE_PKG && \ 
    ./$TF_1_15_OFFLINE_PKG && \
    rm -f ./$TF_1_15_OFFLINE_PKG && \
    rm -rf /root/.cache/pip

ENV TF_PLUGIN_PKG=$TF_PLUGIN_PATH/tfplugin/python/site-packages
ENV PYTHONPATH=$TF_PLUGIN_PKG:$PYTHONPATH

RUN rm -rf ./*
