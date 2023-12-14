# Introduction

本目录用于构建tensorflow-modelzoo容器镜像。镜像以ubuntu18.04为基础镜像，其中中包含
python3.7.5,tensorflow, torch_npu, CANN, 和ResNet50_ID0058_for_TensorFlow（单机单卡、单机8卡）样例、（集群训练）样例。

## 制作镜像

在本目录运行build.sh即可。当条件不满足时，查看build.sh的报错。

制作镜像时需要有网络

## 集群训练

集群训练支持imagenet2012数据集，imagenet2012需从物理机挂载。

1. 默认镜像：`ascendhub.huawei.com/public-ascendhub/tensorflow-modelzoo:22.0.0`，可修改image字段来修改使用的镜像。

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

   **注意事项**：使用imagenet2012数据集需要转换，[参考链接](https://www.hiascend.com/zh/software/modelzoo/models/detail/C/d63df55c1f7f4112a97c8a33e6da89fe/1)，请参考训练章节中的数据集准备的介绍进行转换。使用转换好的imagenet2012数据集时请配置数据集的正确路径，且目录及其子目录的属主属组均为HwHiAiUser。修改位置如下。

   ```yaml
   - name: data
     hostPath:
       path: "/data/imagenet_TF"  # Configure the path of the training set.
   ```
