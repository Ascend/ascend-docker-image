# 说明：此文件为镜像步骤后置hook，用于撤销任何在配对setproxy.sh中做出的、不希望保留在最终镜像中的修改
# 使用说明：去掉相应注释，即可使用相应设置功能，也可以对相应设置自行修改
# 代码示例：

#mv /etc/apt/sources.list.bak /etc/apt/sources.list
#rm -rf ~/.pip/pip.conf

#rm -rf /usr/local/Ascend/driver
#rm -f /etc/ascend_install.info
