#!/bin/bash

function start_test_model() {
    cd ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test
    . /usr/local/Ascend/tfplugin/set_env.sh && . /usr/local/Ascend/ascend-toolkit/set_env.sh
    bash train_full_1p_static.sh --data_path=/home/HwHiAiUser/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/cifar-10-batches-py/ --train_epochs=20&
    sleep 5
    tail -f output/train_.log &
    while true;do
        sleep 20
        wait_time=$((wait_time+20))
        if [ "$(grep -c "Stop graph engine succeed" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] && [ "$(grep -c Epoch ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ];then
            sleep 20
            echo test tensorflow-modelzoo model success
            exit 0
        fi
        if [ "$(grep -c "Error" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
            echo test tensorflow-modelzoo model failed
            exit 1
        fi 
    done
}

start_test_model 