# 文件说明：此文件为镜像步骤前置hook，用于配置外网代理或更换官方yum源和pip源提高镜像构建速度的样例文件
# 使用说明：去掉相应注释，即可使用相应设置功能，也可以对相应设置自行修改
# 代码示例：

# 设置代理 按实际情况进行修改
#export http_proxy=http://user:password@proxyserverip:port
#export https_proxy=http://user:password@proxyserverip:port
# 更换官方apt源 根据实际情况修改
#mv /etc/apt/sources.list /etc/apt/sources.list.bak
#cat > /etc/apt/sources.list << EOF
#deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
#deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib
#deb http://mirrors.aliyun.com/debian-security stretch/updates main
#deb-src http://mirrors.aliyun.com/debian-security stretch/updates main
#deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
#deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
#deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
#deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
#EOF

# 更换pip源 根据实际情况更换
#mkdir -p ~/.pip/
#cat > ~/.pip/pip.conf << EOF
#[global]
#index-url = http://mirrors.huaweicloud.com/repository/pypi/simple
#trusted-host = mirrors.huaweicloud.com
#EOF
# 复制物理机驱动和固件信息到容器 容器中安装训练引擎需要检查驱动信息
#mkdir -p /usr/local/Ascend/driver
#cp version.info /usr/local/Ascend/driver/
#cp ascend_install.info /etc/
