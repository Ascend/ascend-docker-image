ARG BASE_VERSION
ARG BASE=ascend-toolkit:$BASE_VERSION
FROM $BASE

WORKDIR /tmp
COPY . ./

SHELL ["/bin/bash","-c"]

# 安装torch
RUN umask 0022 && \
    groupadd  HwHiAiUser -g 1000 && \
    useradd -d /home/HwHiAiUser -u 1000 -g 1000 -m -s /bin/bash HwHiAiUser && \
    pip3 install --upgrade /tmp/torch_npu*.whl && \
    pip3 install --upgrade /tmp/apex-0.1_ascend*.whl && \
    pip3 install --upgrade /tmp/torch-*.whl && \
    pip3 install mmcv==1.7.0 && \
    pip3 install urllib3==1.26.6 && \
    pip3 install yapf==0.40.1 && \
    pip3 install torchvision==0.12.0 && \
    pip3 install matplotlib && \
    rm -rf /root/.cache/pip && \
    rm -rf ./*

USER HwHiAiUser
COPY --chown=HwHiAiUser:HwHiAiUser Open_Source_Software_Notice.txt /home/HwHiAiUser/Open_Source_Software_Notice.txt
WORKDIR /home/HwHiAiUser/
