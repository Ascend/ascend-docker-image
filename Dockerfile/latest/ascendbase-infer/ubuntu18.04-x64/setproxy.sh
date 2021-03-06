# 文件说明：此文件为镜像步骤前置hook，用于配置外网代理或更换官方yum源和pip源提高镜像构建速度的样例文件
# 使用说明：去掉相应注释，即可使用相应设置功能，也可以对相应设置自行修改
# 代码示例：

# 设置代理 按实际情况进行修改
#export http_proxy=http://user:password@proxyserverip:port
#export https_proxy=http://user:password@proxyserverip:port

# 更换官方apt源 根据实际情况修改
#cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
#sed -i "s@http://.*archive.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list
#sed -i "s@http://.*security.ubuntu.com@http://mirrors.huaweicloud.com@g" /etc/apt/sources.list

# 更换pip源 根据实际情况更换
#mkdir -p ~/.pip/
#cat > ~/.pip/pip.conf << EOF
#[global]
#index-url = http://mirrors.huaweicloud.com/repository/pypi/simple
#trusted-host = mirrors.huaweicloud.com
#EOF
