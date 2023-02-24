#!/bin/bash

## 启动训练

function start_test_model() {
    sed -i 's/epoch_size: 90/epoch_size: 5/' /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    cd /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts
    bash /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts/run_standalone_train.sh /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
    sleep 5s
    tail -f /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts/train/log &
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

start_test_model