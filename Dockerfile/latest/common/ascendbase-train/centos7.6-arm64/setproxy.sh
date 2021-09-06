# 文件说明：此文件为镜像步骤前置hook，用于配置外网代理或更换官方yum源和pip源提高镜像构建速度的样例文件
# 使用说明：去掉相应注释，即可使用相应设置功能，也可以对相应设置自行修改
# 代码示例：

# 设置代理 按实际情况进行修改
#export http_proxy=http://user:password@proxyserverip:port
#export https_proxy=http://user:password@proxyserverip:port

# 更换官方yum源 根据实际情况修改
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
#cat > /etc/yum.repos.d/CentOS-Base.repo << EOF
#[base]
#name=CentOS-$releasever - Base - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/os/aarch64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7-aarch64
#
#[updates]
#name=CentOS-$releasever - Updates - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/updates/aarch64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7-aarch64
#
#[extras]
#name=CentOS-$releasever - Extras - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/extras/aarch64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7-aarch64
#
#[centosplus]
#name=CentOS-$releasever - Plus - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos-altarch/7/centosplus/aarch64/
#gpgcheck=0
#enabled=0
#gpgkey=https://mirrors.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7-aarch64
#EOF

# 更换pip源 根据实际情况更换
#mkdir -p ~/.pip/
#cat > ~/.pip/pip.conf << EOF
#[global]
#index-url = http://mirrors.huaweicloud.com/repository/pypi/simple
#trusted-host = mirrors.huaweicloud.com
#EOF
