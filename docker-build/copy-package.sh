#!/bin/bash

# all-in-one
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/Ascend-mindxdl-elastic-ms_3.0.RC3_linux-$(arch).zip /data/test/ascend-docker-image/all-in-one/
cd /data/test/ascend-docker-image/all-in-one/
unzip Ascend-mindxdl-elastic-ms_3.0.RC3_linux-$(arch).zip
mv py37/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl .
cd -
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/all-in-one/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl /data/test/ascend-docker-image/all-in-one/
# infer-modelzoo
cp -r /usr1/package/ResNet152 /data/test/ascend-docker-image/infer-modelzoo/ # ResNet152
cp -r /usr1/package/Ascend-mindxsdk-mxmanufacture_3.0.RC3_linux-$(arch).run /data/test/ascend-docker-image/infer-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/infer-modelzoo/
# infer-modelzoo-mxvision
cp -r /usr1/package/ResNet152 /data/test/ascend-docker-image/infer-modelzoo-mxvision/ # ResNet152
cp -r /usr1/package/Ascend-mindxsdk-mxvision_3.0.RC3_linux-$(arch).run /data/test/ascend-docker-image/infer-modelzoo-mxvision/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/infer-modelzoo-mxvision/
# mindspore-modelzoo
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/mindspore-modelzoo/
cp -r /data/test/ascend-docker-image/all-in-one/mindx_elastic-0.0.1-py37-none-linux_$(arch).whl /data/test/ascend-docker-image/mindspore-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/mindspore-modelzoo/
# pytorch-modelzoo
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/pytorch-modelzoo/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/pytorch-modelzoo/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/pytorch-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/pytorch-modelzoo/
# pytorch1.5-modelzoo
cp -r /usr1/package/InceptionV4_for_PyTorch_1.1_code /data/test/ascend-docker-image/pytorch1.5-modelzoo/ # InceptionV4_for_PyTorch_1.1_code
cp -r /usr1/package/apex-0.1+ascend.20221219-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/pytorch1.5-modelzoo/
cp -r /usr1/package/torch-1.5.0+ascend.post7.20221219-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/pytorch1.5-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/pytorch1.5-modelzoo/
# tensorflow-modelzoo
cp -r /usr1/package/imagenet2012.zip /data/test/ascend-docker-image/docker-build/ # imagenet2012
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/tensorflow-modelzoo/
cp -r /usr1/package/tensorflow-1.15.0-cp37-cp37m-manylinux2014_$(arch).whl /data/test/ascend-docker-image/tensorflow-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/tensorflow-modelzoo/
# tensorflow2.6.5-modelzoo
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/tensorflow2.6.5-modelzoo/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl /data/test/ascend-docker-image/tensorflow2.6.5-modelzoo/
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/tensorflow2.6.5-modelzoo/

# ascendbase-toolkit
if [[ $(arch) == "x86_64" ]]; then
    cp -r /usr1/package/lib-$(arch)/libstdc++.so /data/test/ascend-docker-image/ascendbase-toolkit/centos7.6-x64/
else
    cp -r /usr1/package/lib-$(arch)/libstdc++.so /data/test/ascend-docker-image/ascendbase-toolkit/centos7.6-arm64/
fi
# ascendbase-infer
if [[ $(arch) == "x86_64" ]]; then
    cp -r /usr1/package/lib-$(arch)/libstdc++.so /data/test/ascend-docker-image/ascendbase-infer/centos7.6-x64/
else
    cp -r /usr1/package/lib-$(arch)/libstdc++.so /data/test/ascend-docker-image/ascendbase-infer/centos7.6-arm64/
fi
# ascend-algorithm
cp -r /usr1/package/Ascend-cann-nnrt_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/ascend-algorithm/
# ascend-infer
cp -r /usr1/package/Ascend-cann-nnrt_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/ascend-infer/
# ascend-toolkit
cp -r /usr1/package/Ascend-cann-toolkit_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/ascend-toolkit/
# ascend-mindspore
cp -r /usr1/package/mindspore_ascend-1.9.0-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/ascend-mindspore/
# ascend-pytorch
cp -r /usr1/package/apex-0.1+ascend-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/ascend-pytorch/
cp -r /usr1/package/torch-1.8.1-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/ascend-pytorch/
cp -r /usr1/package/torch_npu-1.8.1rc3-cp37-cp37m-linux_$(arch).whl /data/test/ascend-docker-image/ascend-pytorch/
# ascend-tensorflow
cp -r /usr1/package/Ascend-cann-tfplugin_6.0.RC1_linux-$(arch).run /data/test/ascend-docker-image/ascend-tensorflow/
cp -r /usr1/package/tensorflow-2.6.5-cp37-cp37m-manylinux2014_$(arch).whl /data/test/ascend-docker-image/ascend-tensorflow/