#!/bin/bash

# all-in-one
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -r /usr1/package/Ascend-mindxdl-elastic-ms_3.0.RC3_linux-$(arch).zip ../all-in-one/
cd ../all-in-one/
unzip Ascend-mindxdl-elastic-ms_3.0.RC3_linux-$(arch).zip
mv py37/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl .
cd -
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../all-in-one/
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl ../all-in-one/
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run ../all-in-one/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl ../all-in-one/
# infer-modelzoo
cp -r /usr1/package/ResNet152 ../infer-modelzoo/ # ResNet152
cp -r /usr1/package/Ascend-mindxsdk-mxmanufacture_3.0.RC3_linux-$(arch).run ../infer-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../infer-modelzoo/
# infer-modelzoo-mxvision
cp -r /usr1/package/ResNet152 ../infer-modelzoo-mxvision/ # ResNet152
cp -r /usr1/package/Ascend-mindxsdk-mxvision_3.0.RC3_linux-$(arch).run ../infer-modelzoo-mxvision/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../infer-modelzoo-mxvision/
# mindspore-modelzoo
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl ../mindspore-modelzoo/
cp -r ../all-in-one/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl ../mindspore-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../mindspore-modelzoo/
# pytorch-modelzoo
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../pytorch-modelzoo/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl ../pytorch-modelzoo/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl ../pytorch-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../pytorch-modelzoo/
# pytorch1.5-modelzoo
cp -r /usr1/package/InceptionV4_for_PyTorch_1.1_code ../pytorch1.5-modelzoo/ # InceptionV4_for_PyTorch_1.1_code
cp -r /usr1/package/apex-0.1+ascend.20221219-cp37-cp37m-linux_$(arch).whl ../pytorch1.5-modelzoo/
cp -r /usr1/package/torch-1.5.0+ascend.post7.20221219-cp37-cp37m-linux_$(arch).whl ../pytorch1.5-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../pytorch1.5-modelzoo/
# tensorflow-modelzoo
cp -r /usr1/package/imagenet2012.zip ../docker-build/ # imagenet2012
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run ../tensorflow-modelzoo/
cp -r /usr1/package/tensorflow-1.15.0-cp37-cp37m-manylinux2014_$(arch).whl ../tensorflow-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../tensorflow-modelzoo/
# tensorflow2.6.5-modelzoo
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run ../tensorflow2.6.5-modelzoo/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl ../tensorflow2.6.5-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../tensorflow2.6.5-modelzoo/

# ascendbase-toolkit
if [[ $(arch) == "x86_64" ]]; then
    cp -r /usr1/package/lib-$(arch)/libstdc++.so ../ascendbase-toolkit/centos7.6-x64/
else
    cp -r /usr1/package/lib-$(arch)/libstdc++.so ../ascendbase-toolkit/centos7.6-arm64/
fi
# ascendbase-infer
if [[ $(arch) == "x86_64" ]]; then
    cp -r /usr1/package/lib-$(arch)/libstdc++.so ../ascendbase-infer/centos7.6-x64/
else
    cp -r /usr1/package/lib-$(arch)/libstdc++.so ../ascendbase-infer/centos7.6-arm64/
fi
# ascend-algorithm
cp -r /usr1/package/Ascend-cann-nnrt_6.0.RC1_linux-$(arch).run ../ascend-algorithm/
# ascend-infer
cp -r /usr1/package/Ascend-cann-nnrt_6.0.RC1_linux-$(arch).run ../ascend-infer/
# ascend-toolkit
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run ../ascend-toolkit/
# ascend-mindspore
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl ../ascend-mindspore/
# ascend-pytorch
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl ../ascend-pytorch/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl ../ascend-pytorch/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl ../ascend-pytorch/
# ascend-tensorflow
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run ../ascend-tensorflow/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl ../ascend-tensorflow/