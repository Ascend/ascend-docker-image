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
#name=CentOS-7 - Base - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos/7/os/x86_64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
#
#[updates]
#name=CentOS-7 - Updates - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos/7/updates/x86_64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
#
#[extras]
#name=CentOS-7 - Extras - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos/7/extras/x86_64/
#gpgcheck=0
#gpgkey=https://mirrors.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
#
#[centosplus]
#name=CentOS-7 - Plus - mirrors.huaweicloud.com
#baseurl=https://mirrors.huaweicloud.com/centos/7/centosplus/x86_64/
#gpgcheck=0
#enabled=0
#gpgkey=https://mirrors.huaweicloud.com/centos/RPM-GPG-KEY-CentOS-7
#EOF

# 更换pip源 根据实际情况更换
#mkdir -p ~/.pip/
#cat > ~/.pip/pip.conf << EOF
#[global]
#index-url = http://mirrors.huaweicloud.com/repository/pypi/simple
#trusted-host = mirrors.huaweicloud.com
#EOF
