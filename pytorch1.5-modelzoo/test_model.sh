#!/bin/bash

## 启动训练

function start_test_model() {
    if [ $1 == 1p ];then
        cd /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code
        python3 train_1p.py --data ./ --npu 0 --epochs 1 || exit 1
        echo test pytorch-modelzoo model success
    fi
    if [ $1 == 8p ];then
        cd /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code/test
        bash train_full_8p.sh --data_path=/home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code &
        sleep 5s
        tail -f /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code/test/output/0/train_0.log &
        while true;do
            sleep 20
            wait_time=$((wait_time+20))
            if [ "$(grep -c "THPModule_npu_shutdown success" /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code/test/output/0/train_0.log)" -gt 0 ] && [ "$(grep -c "Epoch:" /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code/test/output/0/train_0.log)" -gt 0 ];then
                sleep 20
                echo test pytorch-modelzoo model success
                exit 0
            fi
            if [ "$(grep -c "Error" /home/HwHiAiUser/samples/InceptionV4_for_PyTorch_1.1_code/test/output/0/train_0.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
                echo test pytorch-modelzoo model failed
                exit 1
            fi 
        done
    fi 
}

start_test_model $1