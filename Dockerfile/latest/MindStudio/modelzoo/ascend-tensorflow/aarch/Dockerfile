ARG BASE_VERSION
ARG BASE_NAME
ARG BASE=${BASE_NAME}:${BASE_VERSION}
FROM $BASE

WORKDIR /tmp
COPY . ./

RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz --no-check-certificate && \
    tar -zxvf hdf5-1.10.5.tar.gz && \
    cd hdf5-1.10.5/ && \
    ./configure --prefix=/usr/include/hdf5 && \
    make && \
    make install && \
    echo 'export CPATH="/usr/include/hdf5/include/:/usr/include/hdf5/lib/'>>~/.bashrc && \
    ln -s /usr/include/hdf5/lib/libhdf5.so  /usr/lib/libhdf5.so && \
    ln -s /usr/include/hdf5/lib/libhdf5_hl.so  /usr/lib/libhdf5_hl.so

RUN pip3 install Cython && \ 
    pip3 install h5py==2.8.0 

ARG TF_PKG
ARG TFPLUGIN_PKG
ARG ASCEND_BASE=/usr/local/Ascend
# 安装TFplugin 和安装tensorflow
RUN umask 0022 && \ 
    mkdir -p $ASCEND_BASE/driver && \
    cp version.info $ASCEND_BASE/driver/ && \
    cp ascend_install.info /etc/ && \
    chmod +x $TFPLUGIN_PKG && \
    ./$TFPLUGIN_PKG --check && \
    ./$TFPLUGIN_PKG --quiet --install \
    --install-for-all && \
    rm -f ./$TFPLUGIN_PKG && \
    pip3 install $TF_PKG && \
    rm -rf /root/.cache/pip && \
    rm -rf $ASCEND_BASE/driver && \
    rm -f /etc/ascend_install.info

RUN echo 'source /usr/local/Ascend/tfplugin/set_env.sh'>>~/.bashrc 

###清理工作
RUN rm -rf ./$TF_PKG \
    && rm -rf ./$TFPLUGIN_PKG 

# 配置sshd && 环境变量
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/g' /etc/ssh/sshd_config 

# 暴露22端口
EXPOSE 22