#!/bin/bash

## 测试mindspore

function start_test_mindspore() {
    sed -i 's/epoch_size: 90/epoch_size: 5/' ~/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    cd ~/samples/Resnet50_Cifar_for_MindSpore/scripts || exit 1
    bash ~/samples/Resnet50_Cifar_for_MindSpore/scripts/run_standalone_train.sh ~/samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin ~/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml &
    sleep 5s
    tail -f ~/samples/Resnet50_Cifar_for_MindSpore/scripts/train/log &
    local wait_time
    wait_time=0
    while true; do
        sleep 20
        wait_time=$((wait_time+20))
        ckpt_file_exists=$(find train/output/checkpoint/ -name 'resnet*.ckpt' | wc -l)
        if [ "$ckpt_file_exists" -eq 1 ]; then
            echo test mindspore-modelzoo model success
            return 0
        fi
        if [ "$ckpt_file_exists" -eq 0 ] && [ $wait_time -gt 400 ]; then
            echo test mindspore-modelzoo model failed
            return 1
        fi
    done
}

function start_test_tf2() {
    cd ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test || exit 1
    bash train_full_1p_static.sh --data_path=/home/HwHiAiUser/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/cifar-10-batches-py/ --train_epochs=5 &
    sleep 5
    tail -f output/train_.log &
    while true;do
        sleep 20
        wait_time=$((wait_time+20))
        if [ "$(grep -c "Stop graph engine succeed" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] && [ "$(grep -c Epoch ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ];then
            sleep 20
            echo test tensorflow-modelzoo model success
            return 0
        fi
        if [ "$(grep -c "Error" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
            echo test tensorflow-modlezoo model failed
            return 1
        fi 
    done
}

function start_test_pytorch() {
    cd ~/samples/Resnet50_Cifar_for_PyTorch/test || exit 1
    bash train_performance_1p.sh &
    sleep 5
    tail -f output/0/train_0.log &
    while true;do
        sleep 20
        wait_time=$((wait_time+20))
        if [ "$(grep -c "THPModule_npu_shutdown success" ~/samples/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ] && [ "$(grep -c Epoch ~/samples/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ];then
            sleep 20
            echo test pytorch-modelzoo model success
            return 0
        fi
        if [ "$(grep -c "Error" ~/samples/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
            echo test pytorch-modelzoo model failed
            return 1
        fi 
    done
}

result=0

function main() {
    if [ $# = 0 ]; then
        if ! start_test_mindspore; then
            result=1
        fi
        if ! start_test_tf2; then
            result=1
        fi
        if ! start_test_pytorch; then
            result=1
        fi
    fi
    if [[ $1 == 'mindspore' ]]; then
        if ! start_test_mindspore; then
            result=1
        fi
    elif [[ $1 == 'tensorflow' ]]; then
        if ! start_test_tf2; then
            result=1
        fi
    elif [[ $1 == 'pytorch' ]]; then
        if ! start_test_pytorch; then
            result=1
        fi
    fi
}

main "$@"
if [ $result = 1 ]; then
    exit 1
fi
