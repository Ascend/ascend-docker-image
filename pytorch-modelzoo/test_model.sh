#!/bin/bash

## 启动训练

function start_test_model() {
    cd ~/Resnet50_Cifar_for_Pytorch
    bash test/train_performance_1p.sh
    sleep 5s
    tail -f test/output/0/train_0.log

}

start_test_model