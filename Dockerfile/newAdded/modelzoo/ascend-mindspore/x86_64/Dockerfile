ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE


WORKDIR /tmp
COPY . ./

ARG ASCEND_BASE=/usr/local/Ascend

# MindSpore安装
ARG MS_VERSION
# ARG MS_VERSION=1.8.0


ENV LOCAL_ASCEND=/usr/local/Ascend 

RUN pip3 uninstall te topi hccl -y && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/topi-*-py3-none-any.whl && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/te-*-py3-none-any.whl && \
    pip3 install ${LOCAL_ASCEND}/ascend-toolkit/latest/lib64/hccl-*-py3-none-any.whl 


RUN umask 0022 && \
    ARCH=$(uname -m) && \
    pip3 install \
    https://ms-release.obs.cn-north-4.myhuaweicloud.com/${MS_VERSION}/MindSpore/ascend/${ARCH}/mindspore_ascend-${MS_VERSION}-cp37-cp37m-linux_${ARCH}.whl \
    --trusted-host ms-release.obs.cn-north-4.myhuaweicloud.com && \
    # -i https://pypi.tuna.tsinghua.edu.cn/simple && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info && \
    rm -rf /root/.cache/pip 

# ENV export GLOG_v=2 
# ENV LD_LIBRARY_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/lib64:${LOCAL_ASCEND}/driver/lib64:${LOCAL_ASCEND}/driver/lib64/driver:${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe/op_tiling:${LD_LIBRARY_PATH}
# ENV TBE_IMPL_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe
# ENV ASCEND_OPP_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp 
# ENV ASCEND_AICPU_PATH=${ASCEND_OPP_PATH}/..
# ENV PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/compiler/ccec_compiler/bin/:${PATH}
# ENV PYTHONPATH=${TBE_IMPL_PATH}:${PYTHONPATH}

###配置环境变量
RUN echo 'GLOG_v=2'>>~/.bashrc \
    && echo 'LOCAL_ASCEND=/usr/local/Ascend'>>~/.bashrc \
    && echo 'LD_LIBRARY_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/lib64:${LOCAL_ASCEND}/driver/lib64:${LOCAL_ASCEND}/driver/lib64/driver:${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe/op_tiling:${LD_LIBRARY_PATH}'>>~/.bashrc \
    && echo 'TBE_IMPL_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp/op_impl/built-in/ai_core/tbe'>>~/.bashrc \
    && echo 'ASCEND_OPP_PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/opp'>>~/.bashrc \
    && echo 'ASCEND_AICPU_PATH=${ASCEND_OPP_PATH}/..'>>~/.bashrc \
    && echo 'PATH=${LOCAL_ASCEND}/ascend-toolkit/latest/compiler/ccec_compiler/bin/:${PATH}'>>~/.bashrc \
    && echo 'PYTHONPATH=${TBE_IMPL_PATH}:${PYTHONPATH}'>>~/.bashrc 

# USER hwMindX

# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

###启动ssh服务
ADD run.sh /run.sh
RUN chmod 755 /run.sh

##将root用户密码设置为root
RUN echo "root:root" | chpasswd
# 启动sshd服务并且暴露22端口
EXPOSE 22
CMD ["/run.sh"]


