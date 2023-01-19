#!/bin/bash

cd ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test
. /usr/local/Ascend/tfplugin/set_env.sh && . /usr/local/Ascend/ascend-toolkit/set_env.sh
bash train_full_1p_static.sh --data_path=/home/HwHiAiUser/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/cifar-10-batches-py/ --train_epochs=20&
sleep 5
tail -f output/train_.log &
sleep 300
if [ "$(grep -c Epoch ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ];then
    echo test tensorflow2 model success
    exit 0
else
    echo test tensorflow2 model failed
    exit 1
fi  