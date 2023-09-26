# mindspore-modelzoo介绍

镜像基于ubuntu18.04基础镜像构建，包含训练、转换、推理和有效算力验收功能。镜像中包含MindSpore框架、python3.7.5、toolkit和toolbox软件包，并且内置了用于集群训练的resnet50模型和用于有效算力验收的resnet50、bert-large模型。

## 集群训练

集群训练支持cifar10和imagenet2012数据集，其中cifar10数据集已内置，imagenet2012需从物理机挂载。

1. 默认镜像：`ascendhub.huawei.com/public-ascendhub/mindspore-modelzoo:22.0.0`，可修改image字段来修改使用的镜像。

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

5. 编辑train_cifar_vcjob.yaml或train_imagenet_vcjob文件，可修改上述5个地方。执行`kubectl apply -f train_cifar_vcjob.yaml`下发任务，此时使用cifar10数据集进行训练；执行`kubectl apply -f train_imagenet_vcjob.yaml`下发任务，此时使用imagenet2012数据集进行训练。执行`kubectl delete -f train_cifar_vcjob.yaml`或`kubectl delete -f train_imagenet_vcjob.yaml`删除任务。
   注意事项：使用imagenet2012数据集时请配置数据集的正确路径，且目录及其子目录的属主属组均为HwHiAiUser。修改位置如下。

   ```yaml
   - name: data
     hostPath:
       path: "/data/imagenet"  # Configure the path of the training set.
   ```

## 单机推理

推理基于Caffe ResNet-50网络（单输入、单Batch）实现图片分类的功能。

1. 默认镜像：`ascendhub.huawei.com/public-ascendhub/mindspore-modelzoo:22.0.0`，可修改image字段来修改使用的镜像。
2. 默认挂载芯片：Ascend310P，对应310P芯片，可修改为环境上对应的芯片名，例如910芯片修改为Ascend910。1指单卡，可修改数量挂载多卡，requests和limits需保持一致。修改位置如下。

   ```yaml
   resources:
     requests:
       huawei.com/Ascend310P: 1                 # Number of required NPUs. The maximum value is 8. You can add lines below to configure resources such as memory and CPU.
     limits:
       huawei.com/Ascend310P: 1
   ```

3. 默认架构：x86_64，如果运行环境为arm，请改成huawei-arm，修改位置如下。

   ```yaml
   nodeSelector:
     host-arch: huawei-x86
   ```

4. 编辑infer_vcjob.yaml文件，可修改上述3个地方。执行`kubectl apply -f infer_vcjob.yaml`下发任务，执行`kubectl delete -f infer_vcjob.yaml`删除任务。

## dmi测算力、带宽和功耗

镜像内置了toolbox，可用dmi测算力、带宽和功耗。

1. 默认镜像：`ascendhub.huawei.com/public-ascendhub/mindspore-modelzoo:22.0.0`，可修改image字段来修改使用的镜像。

2. 默认使用dmi在两个节点上批量测试算力、带宽和功耗。可修改`minAvailable: 2`和`replicas: 2`的值，需同时修改且值一样。例如改为1则单机测试。

3. 默认挂载芯片：Ascend310P，对应310P芯片，可修改为环境上对应的芯片名，例如910芯片修改为Ascend910。修改位置参考**单机推理**。当申请的昇腾910 AI处理器总数小于或等于8时，只能申请一个Pod，大于8则每个Pod为8个昇腾910 AI处理器。

4. 默认架构：x86_64，如果运行环境为arm，请改成huawei-arm，修改位置参考**单机推理**。

5. 编辑dmi_vcjob.yaml文件，可修改上述3个地方。执行`kubectl apply -f dmi_vcjob.yaml`下发任务，执行`kubectl delete -f dmi_vcjob.yaml`删除任务。

注意事项：310不支持功耗测试。

## 有效算力验收

mindspore-modelzoo镜像作为有效算力验收时使用的镜像，支持resnet50和bert-large模型。

1. 所有待验收节点请获取[mindspore-modelzoo](https://ascendhub.huawei.com/#/detail/mindspore-modelzoo)镜像，镜像版本>=23.0.RC1。
2. 所有节点获取镜像后，选择一个节点作为管理节点，在管理节点获取[有效算力验收工具](https://gitee.com/ascend/ascend-toolbox/tags)，相关使用说明请参考该工具的使用文档。

**有效算力验收镜像中使用文件的来源**：
  |文件|获取方法|
  |:-----------:| :-------------:|
  |run_ais.py|[ascend-toolbox](https://gitee.com/ascend/ascend-toolbox/tree/dev)工具中|
  |train_*Ais-Benchmark-Stubs\*|参考[tools文档](https://gitee.com/ascend/tools/blob/master/ais-bench_workload/doc/ais-bench_workload%E6%9E%84%E5%BB%BA%E6%95%99%E7%A8%8B.md)|
