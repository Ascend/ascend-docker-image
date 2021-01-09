ARG BASE_VERSION
ARG BASE=ascend-train:$BASE_VERSION
FROM $BASE

WORKDIR /tmp

ARG MINDSPORE_PKG
COPY $MINDSPORE_PKG ./
RUN pip3.7 install $MINDSPORE_PKG && \
    rm -f $MINDSPORE_PKG && \
    rm -rf /root/.cache/pip
