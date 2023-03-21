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

## 集群训练

集群训练支持resnet50模型 + imagenet2012数据集，imagenet2012需从物理机挂载。

1. 默认镜像：`ascendhub.huawei.com/public-ascendhub/pytorch-modelzoo:22.0.0`，可修改image字段来修改使用的镜像。

2. 默认在两个节点上进行集群训练。可修改`minAvailable: 2`和`replicas: 2`的值，需同时修改且值一样，定义集群训练的节点数。

3. 默认挂载Ascend910芯片且是满配8卡，可修改数量。requests和limits需保持一致。修改位置如下。

   ```yaml
   resources:
     requests:
       huawei.com/Ascend910: 8                 # Number of required NPUs. The maximum value is 8. You can add lines below to configure resources such as memory and CPU.
     limits:
       huawei.com/Ascend910: 8
   ```

4. 默认架构：x86_64，如果运行环境为aarch64，请改成huawei-arm，修改位置如下。

   ```yaml
   nodeSelector:
     host-arch: huawei-x86
   ```

5. 编辑train_imagenet_vcjob文件，可修改上述4个地方。执行`kubectl apply -f train_imagenet_vcjob.yaml`下发任务，此时使用imagenet2012数据集进行训练。执行`kubectl delete -f train_imagenet_vcjob.yaml`删除任务。
   **注意事项**：使用imagenet2012数据集时请配置数据集的正确路径，且目录及其子目录的属主属组均为HwHiAiUser。修改位置如下。

   ```yaml
   - name: data
     hostPath:
       path: "/data/imagenet"  # Configure the path of the training set.
   ```
