#!/bin/bash

cp -rf /usr1/package/cifar-10* .
cp -rf /usr1/package/mindspore-modelzoo-data-model/* .
# all-in-one
cp -rf /usr1/package/mindspore_ascend-*linux_$(arch).whl ../all-in-one/
cp -rf /usr1/package/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl ../all-in-one/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../all-in-one/
cp -rf /usr1/package/apex1.8/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -rf /usr1/package/torch-1.8*linux_$(arch).whl ../all-in-one/
cp -rf /usr1/package/torch_npu-1.8.1-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -rf /usr1/package/Ascend-cann-tfplugin*-$(arch).run ../all-in-one/
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/tensorflow_cpu-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl ../all-in-one/
else
    cp -rf /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl ../all-in-one/
fi
# infer-modelzoo
cp -rf /usr1/package/ResNet152 ../infer-modelzoo/ # ResNet152
cp -rf /usr1/package/Ascend-mindxsdk-mxmanufacture_*linux-$(arch).run ../infer-modelzoo/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../infer-modelzoo/
# infer-modelzoo-mxvision
cp -rf /usr1/package/ResNet152 ../infer-modelzoo-mxvision/ # ResNet152
cp -rf /usr1/package/Ascend-mindxsdk-mxvision_*linux-$(arch).run ../infer-modelzoo-mxvision/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../infer-modelzoo-mxvision/
# mindspore-modelzoo
cp -rf /usr1/package/mindspore_ascend-*linux_$(arch).whl ../mindspore-modelzoo/
cp -rf ../all-in-one/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl ../mindspore-modelzoo/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../mindspore-modelzoo/
cp -rf /usr1/package/Ascend-mindx-toolbox*-$(arch).run ../mindspore-modelzoo/
# pytorch-modelzoo
cp -rf /usr1/package/apex1.8/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../pytorch-modelzoo/
cp -rf /usr1/package/torch-1.8*linux_$(arch).whl ../pytorch-modelzoo/
cp -rf /usr1/package/torch_npu-1.8.1-cp37-cp37m-linux_$(arch).whl ../pytorch-modelzoo/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../pytorch-modelzoo/
cp -rf /usr1/package/pytorch1.8/ResNet50_for_PyTorch ../pytorch-modelzoo/
# pytorch1.5-modelzoo
cp -rf /usr1/package/InceptionV4_for_PyTorch_1.1_code ../pytorch1.5-modelzoo/ # InceptionV4_for_PyTorch_1.1_code
cp -rf /usr1/package/apex1.5/apex-0.1*linux_$(arch).whl ../pytorch1.5-modelzoo/
cp -rf /usr1/package/torch-1.5.0*linux_$(arch).whl ../pytorch1.5-modelzoo/
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../pytorch1.5-modelzoo/
cp -rf /usr1/package/pytorch1.5/ResNet50_for_PyTorch ../pytorch1.5-modelzoo/
# tensorflow-modelzoo
cp -rf /usr1/package/imagenet2012.zip ../docker-build/ # imagenet2012
cp -rf /usr1/package/Ascend-cann-tfplugin*-$(arch).run ../tensorflow-modelzoo/
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/tensorflow-1.15.0-cp37-cp37m-manylinux2010_$(arch).whl ../tensorflow-modelzoo/
else
    cp -rf /usr1/package/tensorflow-1.15.0-cp37-cp37m-manylinux2014_$(arch).whl ../tensorflow-modelzoo/
fi
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../tensorflow-modelzoo/
# tensorflow2.6.5-modelzoo
cp -rf /usr1/package/Ascend-cann-tfplugin*-$(arch).run ../tensorflow2.6.5-modelzoo/
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/tensorflow_cpu-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl ../tensorflow2.6.5-modelzoo/
else
    cp -rf /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl ../tensorflow2.6.5-modelzoo/
fi
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../tensorflow2.6.5-modelzoo/

# ascendbase-toolkit
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/lib-$(arch)/libstdc++.so.6.0.24 ../ascendbase-toolkit/centos7.6-x64/
else
    cp -rf /usr1/package/lib-$(arch)/libstdc++.so.6.0.24 ../ascendbase-toolkit/centos7.6-arm64/
fi
# ascendbase-infer
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/lib-$(arch)/libstdc++.so.6.0.24 ../ascendbase-infer/centos7.6-x64/
else
    cp -rf /usr1/package/lib-$(arch)/libstdc++.so.6.0.24 ../ascendbase-infer/centos7.6-arm64/
fi
# ascend-algorithm
cp -rf /usr1/package/Ascend-cann-nnrt*-$(arch).run ../ascend-algorithm/
# ascend-infer
cp -rf /usr1/package/Ascend-cann-nnrt*-$(arch).run ../ascend-infer/
# ascend-toolkit
cp -rf /usr1/package/Ascend-cann-toolkit*-$(arch).run ../ascend-toolkit/
# ascend-mindspore
cp -rf /usr1/package/mindspore_ascend-*linux_$(arch).whl ../ascend-mindspore/
# ascend-pytorch
cp -rf /usr1/package/apex1.8/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../ascend-pytorch/
cp -rf /usr1/package/torch-1.8*linux_$(arch).whl ../ascend-pytorch/
cp -rf /usr1/package/torch_npu-1.8.1-cp37-cp37m-linux_$(arch).whl ../ascend-pytorch/
# ascend-tensorflow
cp -rf /usr1/package/Ascend-cann-tfplugin*-$(arch).run ../ascend-tensorflow/
if [[ $(arch) == "x86_64" ]]; then
    cp -rf /usr1/package/tensorflow_cpu-2.6.5-cp37-cp37m-manylinux2010_x86_64.whl ../ascend-tensorflow/
else
    cp -rf /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_aarch64.whl ../ascend-tensorflow/
fi