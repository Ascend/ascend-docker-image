ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE

WORKDIR /tmp
COPY . ./

ARG ASCEND_BASE=/usr/local/Ascend

# MindSpore安装
ARG MS_VERSION

ENV LOCAL_ASCEND=/usr/local/Ascend 

RUN pip3 uninstall te topi hccl -y && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/topi-*-py3-none-any.whl && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/te-*-py3-none-any.whl && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/hccl-*-py3-none-any.whl 

###根据容器内的python版本执行对应的mindspore安装命令
RUN umask 0022 && \
    PY_VERSION=`python3 -V 2>&1|awk '{print $2}'` && \
    if [ ${PY_VERSION: 0: 3} == "3.7" ]; then \
        pip3 install https://ms-release.obs.cn-north-4.myhuaweicloud.com/${MS_VERSION}/MindSpore/ascend/x86_64/mindspore_ascend-${MS_VERSION/-/}-cp37-cp37m-linux_aarch64.whl --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com -i https://pypi.tuna.tsinghua.edu.cn/simple; \
    elif [ ${PY_VERSION: 0: 3} == "3.8" ]; then \
        pip3 install https://ms-release.obs.cn-north-4.myhuaweicloud.com/${MS_VERSION}/MindSpore/ascend/x86_64/mindspore_ascend-${MS_VERSION/-/}-cp38-cp38-linux_aarch64.whl --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com -i https://pypi.tuna.tsinghua.edu.cn/simple; \
    elif [ ${PY_VERSION: 0: 3} == "3.9" ]; then \
        pip3 install https://ms-release.obs.cn-north-4.myhuaweicloud.com/${MS_VERSION}/MindSpore/ascend/x86_64/mindspore_ascend-${MS_VERSION/-/}-cp39-cp39-linux_aarch64.whl --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com -i https://pypi.tuna.tsinghua.edu.cn/simple; \
    fi

###配置环境变量
RUN echo 'GLOG_v=2'>>~/.bashrc \
    && echo 'LOCAL_ASCEND=/usr/local/Ascend'>>~/.bashrc \
    && echo 'LD_LIBRARY_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/lib64:${LOCAL_ASCEND}/driver/lib64:${LOCAL_ASCEND}/driver/lib64/driver:${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe/op_tiling:${LD_LIBRARY_PATH}'>>~/.bashrc \
    && echo 'TBE_IMPL_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe'>>~/.bashrc \
    && echo 'ASCEND_OPP_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp'>>~/.bashrc \
    && echo 'ASCEND_AICPU_PATH=${ASCEND_OPP_PATH}/..'>>~/.bashrc \
    && echo 'PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/compiler/ccec_compiler/bin/:${PATH}'>>~/.bashrc \
    && echo 'PYTHONPATH=${TBE_IMPL_PATH}:${PYTHONPATH}'>>~/.bashrc 

# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

# 暴露22端口
EXPOSE 22
