#!/bin/bash

## 启动训练

function start_test_model() {
    sed -i 's/epoch_size: 90/epoch_size: 5/' ~/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    cd ~/samples/Resnet50_Cifar_for_MindSpore/scripts
    bash ~/samples/Resnet50_Cifar_for_MindSpore/scripts/run_standalone_train.sh ~/samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin ~/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml&
    sleep 5s
    tail -f ~/Resnet50_Cifar_for_MindSpore/scripts/train/log&
}

start_test_model