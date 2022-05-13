#!/bin/bash
#--------------------------------------------------------------------------------
# 请在此处使用使用bash语法编写脚本代码，安装昇腾软件包
#
# 注：本脚本运行结束后不会被自动清除，若无需保留在镜像中请在postbuild.sh脚本中清除
#--------------------------------------------------------------------------------
# 构建之前把host上的/etc/ascend_install.info拷贝一份到当前目录
cp ascend_install.info /etc/

# 构建之前把host的/usr/local/Ascend/driver/version.info拷贝一份到当前目录
mkdir -p /usr/local/Ascend/driver/
cp version.info /usr/local/Ascend/driver/
 
# Install the nnae run package
chmod +x Ascend-cann-nnae*.run
./Ascend-cann-nnae*.run --install-path=/usr/local/Ascend/ --install --quiet --install-for-all
 
# 只为了安装toolkit包，所以需要清理，容器启动时通过ascend docker挂载进来
rm -f version.info
rm -rf /usr/local/Ascend/driver/
