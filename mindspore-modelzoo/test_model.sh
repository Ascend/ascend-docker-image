#!/bin/bash

## 启动训练

function start_test_model() {
    if [ $1 == 1p ];then
        sed -i 's/epoch_size: 90/epoch_size: 5/' /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
        cd /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts
        bash /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts/run_standalone_train.sh /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/config/resnet50_cifar10_config.yaml
        while [ ! -e /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts/outputs/resnet50/cifar10/log/rank_0/log.txt ]
        do
          sleep 1
        done
        tail -f /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts/outputs/resnet50/cifar10/log/rank_0/log.txt &
        local wait_time
        wait_time=0
        while true; do
            sleep 60
            wait_time=$((wait_time+20))
            ckpt_file_exists=$(find outputs/resnet50/cifar10/ckpt/ -name 'resnet*.ckpt' | wc -l)
            if [ "$ckpt_file_exists" -eq 1 ]; then
                echo test mindspore-modelzoo model success
                return 0
            fi
            if [ "$ckpt_file_exists" -eq 0 ] && [ $wait_time -gt 400 ]; then
                echo test mindspore-modelzoo model failed
                return 1
            fi
        done
    fi
    if [ $1 == 8p ];then
        cd /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/scripts
        bash train_start.sh /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore /home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/logs ../train.py --data_path=/home/HwHiAiUser/samples/Resnet50_Cifar_for_MindSpore/data/cifar10/cifar-10-batches-bin/ --dataset=resnet50 --run_distribute=True --device_num=8
        ckpt_file_exists=$(find outputs/resnet50/cifar10/ckpt/ -name 'resnet*.ckpt' | wc -l)
        if [ "$ckpt_file_exists" -gt 1 ]; then
            echo test mindspore-modelzoo model success
            return 0
        fi
        if [ "$ckpt_file_exists" -eq 0 ] && [ $wait_time -gt 400 ]; then
            echo test mindspore-modelzoo model failed
            return 1
        fi
    fi
}

start_test_model $1