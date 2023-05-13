# 简介

昇腾推理基础镜像，基于ubuntu22.04制作，tag不含dev仅安装NNRT，含dev的内部集成推理通用的第三方库（系统包、pip）和TOOLKIT推理引擎。

## 版本配套

| 镜像版本 | CANN版本 | 支持的芯片|
| :------: | :------: | :------: |
| 23.0.RC1 | 6.2.RC1 | Ascend 310B|

## 使用前提

- 物理机上有Ascend 310B芯片
- 物理机已安装对应CANN版本的驱动和固件
- 物理机已安装Docker，且Docker网络可用
- 准备好模型和推理代码

## 如何使用镜像

1. Docker登录Ascend Hub仓库。在镜像详情页面上复制Ascend Hub仓库登录命令后，在带有Ascend 310B芯片的服务器上执行Docker登录命令。
2. 拉取基础镜像。在镜像版本页面找到合适版本的镜像，复制下载命令后在带有Ascend 310B芯片的服务器上执行。
3. 确保物理机的HwHiAiUser的id为1000，和镜像里的HwHiAiUser保持一致。
4. 启动Docker容器实例，启动命令如下：

   ```text
   docker run -it \
   --device=/dev/upgrade:/dev/upgrade \
   --device=/dev/davinci0:/dev/davinci0 \
   --device=/dev/davinci_manager \
   --device=/dev/vdec:/dev/vdec \
   --device=/dev/vpc:/dev/vpc \
   --device=/dev/pngd:/dev/pngd \
   --device=/dev/venc:/dev/venc \
   --device=/dev/sys:/dev/sys \
   --device=/dev/svm0 \
   --device=/dev/ts_aisle:/dev/ts_aisle \
   --device=/dev/dvpp_cmdlist:/dev/dvpp_cmdlist \
   -v /etc/sys_version.conf:/etc/sys_version.conf:ro \
   -v /etc/hdcBasic.cfg:/etc/hdcBasic.cfg:ro \
   -v /usr/lib64/libaicpu_processer.so:/usr/lib64/libaicpu_processer.so:ro \
   -v /usr/lib64/libaicpu_prof.so:/usr/lib64/libaicpu_prof.so:ro \
   -v /usr/lib64/libaicpu_sharder.so:/usr/lib64/libaicpu_sharder.so:ro \
   -v /usr/lib64/libadump.so:/usr/lib64/libadump.so:ro \
   -v /usr/lib64/libtsd_eventclient.so:/usr/lib64/libtsd_eventclient.so:ro \
   -v /usr/lib64/libaicpu_scheduler.so:/usr/lib64/libaicpu_scheduler.so:ro \
   -v /usr/lib64/libcrypto.so.1.1:/usr/lib64/libcrypto.so.1.1:ro \
   -v /usr/lib64/libyaml-0.so.2:/usr/lib64/libyaml-0.so.2:ro \
   -v /usr/lib64/libdcmi.so:/usr/lib64/libdcmi.so:ro \
   -v /usr/lib64/libmpi_dvpp_adapter.so:/usr/lib64/libmpi_dvpp_adapter.so:ro \
   -v /usr/lib64/aicpu_kernels/:/usr/lib64/aicpu_kernels/:ro \
   -v /usr/local/sbin/npu-smi:/usr/local/sbin/npu-smi:ro \
   -v /usr/lib64/libstackcore.so:/usr/lib64/libstackcore.so:ro \
   -v /usr/local/Ascend/driver/lib64:/usr/local/Ascend/driver/lib64:ro \
   -v /var/slogd:/var/slogd:ro \
   -v /var/dmp_daemon:/var/dmp_daemon:ro \
   -v /etc/slog.conf:/etc/slog.conf:ro \
   ascendhub.huawei.com/public-ascendhub/ascend-infer-310b:{tag} \
   /bin/bash
   ```

   参数说明：
    - tag为镜像版本号，如23.0.RC1。
    - /usr/local/Ascend/driver为物理机上安装的NPU驱动目录，根据实际安装的驱动目录进行挂载。
    - 命令中默认挂载0卡到容器中，可根据实际需要挂载device。
    - 请用户根据实际操作系统配置libcrypto.so.1.1和libyaml-0.so.2文件的挂载路径，两个文件所在路径如下。
      - Ubuntu宿主机操作系统下："/usr/lib/aarch64-linux-gnu/"
      - openEuler和euler宿主机操作系统下："/usr/lib64/"
5. 进入容器后在/home/AscendWork目录下执行`. run.sh`。
6. 通过docker cp将推理业务的模型和推理业务代码复制到容器中，确保模型和推理业务代码的属主、属组为HwHiAiUser。
