FROM ubuntu:18.04

ARG SETPROXY=setproxy.sh
ARG UNSETPROXY=unsetproxy.sh
WORKDIR /tmp
COPY . ./

RUN bash -c "test -f $SETPROXY && bash $SETPROXY || true" && \
    apt update && \
    apt install --no-install-recommends python3.7 python3.7-dev -y && \
    apt install --no-install-recommends curl g++ pkg-config unzip -y && \
    apt install --no-install-recommends libblas3 liblapack3 gfortran -y && \
    apt install --no-install-recommends liblapack-dev libblas-dev libhdf5-dev libffi-dev -y && \
    apt install --no-install-recommends libicu60 libxml2 -y && \
    apt-get download python3-distutils && \
    apt clean && rm -rf /var/lib/apt/lists/* && \
    curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    dpkg-deb -x python3-distutils_*.deb / && \
    rm -f python3-distutils_*.deb && \
    python3.7 get-pip.py && \
    rm -f get-pip.py && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true"


RUN bash -c "test -f $SETPROXY && bash  $SETPROXY || true" && \
    pip3.7 install -U pip && \
    pip3.7 install numpy && \
    pip3.7 install decorator && \
    pip3.7 install sympy==1.4 && \
    pip3.7 install cffi==1.12.3 && \
    pip3.7 install pyyaml && \
    pip3.7 install pathlib2 && \
    pip3.7 install grpcio && \
    pip3.7 install grpcio-tools && \
    pip3.7 install protobuf && \
    pip3.7 install scipy && \
    pip3.7 install requests && \
    rm -rf /root/.cache/pip && \
    bash -c "test -f $UNSETPROXY && bash $UNSETPROXY || true"

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH


RUN rm -rf ./*
