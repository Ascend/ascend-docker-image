#!/bin/bash

## 启动训练

function start_test_model() {
    cd ~/Resnet50_Cifar_for_PyTorch
    bash test/train_performance_$1.sh &
    sleep 5s
    tail -f test/output/0/train_0.log &
    while true;do
        sleep 20
        wait_time=$((wait_time+20))
        if [ "$(grep -c "THPModule_npu_shutdown success" ~/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ] && [ "$(grep -c "Saving checkpoint at 2 epochs" ~/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ];then
            sleep 20
            echo test ascend-pytorch model success
            exit 0
        fi
        if [ "$(grep -c "Error" ~/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
            echo test ascend-pytorch model failed
            exit 1
        fi 
    done
}

start_test_model $1