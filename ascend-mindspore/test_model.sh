#!/bin/bash

## 启动训练

function start_test_model() {
    sed -i 's/epoch_size: 90/epoch_size: 5/' ~/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    cd ~/Resnet50_Cifar_for_MindSpore/scripts
    bash ~/Resnet50_Cifar_for_MindSpore/scripts/run_standalone_train.sh ~/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin ~/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    sleep 5s
    tail -f ~/Resnet50_Cifar_for_MindSpore/scripts/train/log &
    local wait_time
    wait_time=0
    while true; do
        sleep 10
        ckpt_file_exists=$(find train/output/checkpoint/ -name 'resnet*.ckpt' | wc -l)
        if [ "$ckpt_file_exists" -eq 1 ]; then
            echo test ascend-mindspore model success
            return 0
        fi
        if [ "$ckpt_file_exists" -eq 0 ] && [ $wait_time -gt 400 ]; then
            echo test ascend-mindspore model failed
            return 1
        fi
    done
}

start_test_model