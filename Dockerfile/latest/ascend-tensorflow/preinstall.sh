# 说明，此文件为镜像步骤的前置hook,用于在任何正式安装步骤前执行定制化步骤
# 注意：在安装NNRT、NNAE等CANN软件包前需要在HOST或其他地方获取兼容（同版本）ascend_install.info文件和
#       version.info文件，以满足CANN软件包的安装前检查
# 伪代码示例：
#
# WHERE_BUILD_IMAGE=镜像build上下文目录
# cp /etc/ascend_install.info ${WHERE_BUILD_IMAGE}/
# cp /usr/local/Ascend/driver/version.info ${WHERE_BUILD_IMAGE}/
# 然后在本文件中写入命令，将上述.info文件放入容器中对应位置（driver需自行创建）
# 代码示例:
# mkdir -p /usr/local/Ascend/driver
# cp version.info /usr/local/Ascend/driver/
# cp ascend_install.info /etc/