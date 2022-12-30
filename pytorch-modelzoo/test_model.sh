#!/bin/bash

## 启动训练

function start_test_model() {
    cd ~/Resnet50_Cifar_for_PyTorch
    bash test/train_performance_1p.sh &
    sleep 5s
    tail -f test/output/0/train_0.log &
    sleep 600
    if [ "$(grep -c Epoch ~/Resnet50_Cifar_for_PyTorch/test/output/0/train_0.log)" -gt 0 ]; then
        echo test pytorch model success
        return 0
    else
        echo test pytorch model failed
        return 1
    fi
}

start_test_model