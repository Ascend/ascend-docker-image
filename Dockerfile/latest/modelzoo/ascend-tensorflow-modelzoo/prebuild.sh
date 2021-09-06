#!/bin/bash
#--------------------------------------------------------------------------------
# 请在此处使用使用bash语法编写脚本代码，执行安装准备工作，例如配置代理等
# 本脚本将会在正式构建过程启动前被执行
#
# 注：本脚本运行结束后不会被自动清除，若无需保留在镜像中请在postbuild.sh脚本中清除
#--------------------------------------------------------------------------------
chmod 777 -R /tmp
rm /var/lib/apt/lists/*
#apt源设置（以下为示例，请根据实际配置）
tee /etc/apt/sources.list <<- EOF
deb http://mirrors.aliyun.com/ubuntu-ports/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu-ports/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu-ports/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu-ports/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu-ports/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu-ports/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu-ports/ bionic-backports main restricted universe multiverse
EOF
