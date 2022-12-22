# Introduction

本目录用于构建pytorch-modelzoo容器镜像。镜像以ubuntu18.04为基础镜像，其中中包含
python3.7.5,pytorch, torch_npu, CANN, 和一个Resnet50_Cifor_for_Pytorch样例

## 运行

进入容器中，默认NPU设备号为0。 如果是挂载的其他设备,执行
```bash
export DEVICE_ID=<设备id>
```
指定训练使用的设备

## 制作镜像


在本目录运行build.sh即可。当条件不满足时，查看build.sh的报错。

制作镜像时需要有网络
