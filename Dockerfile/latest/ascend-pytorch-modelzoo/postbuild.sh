#!/bin/bash
#--------------------------------------------------------------------------------
# 请在此处使用使用bash语法编写脚本代码，清除不需要保留在容器中的安装包、脚本、代理配置等
# 本脚本将会在正式构建过程结束后被执行
#
# 注：本脚本运行结束后会被自动清除，不会残留在镜像中；脚本所在位置和Working Dir位置为/root
#--------------------------------------------------------------------------------
rm -f ascend_install.info
rm -f prebuild.sh
rm -f install_ascend_pkgs.sh
rm -f Dockerfile
rm -f Ascend-cann-nnae*.run
rm -f apex-0.1+ascend-cp37-cp37m-*.whl
rm -f torch-1.5.0+ascend-cp37-cp37m-*.whl
rm -f /tmp
