#!/bin/bash

function start_test_model() {
    cd ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test
    . /usr/local/Ascend/tfplugin/set_env.sh && . /usr/local/Ascend/ascend-toolkit/set_env.sh
    bash train_full_1p_static.sh --data_path=/home/HwHiAiUser/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar-10-batches-py/ --train_epochs=20&
    sleep 5
    tail -f output/train_.log &
    while true;do
        sleep 20
        wait_time=$((wait_time+20))
        if [ "$(grep -c "Stop graph engine succeed" ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] && [ "$(grep -c Epoch ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ];then
            sleep 20
            echo test ascend-tensorflow model success
            exit 0
        fi
        if [ "$(grep -c "Error" ~/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
            echo test ascend-tensorflow model failed
            exit 1
        fi 
    done
}

start_test_model