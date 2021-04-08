# 说明：此文件为镜像步骤后置hook，用于撤销任何在配对preinstall.sh中做出的、不希望保留在最终镜像中的修改
# 在此撤销配对preinstall.sh中放置的version.info和ascend_install.info文件
# 代码示例：
#
# rm -rf /usr/local/Ascend/driver
# rm -f /etc/ascend_install.info