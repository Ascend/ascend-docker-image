#!/bin/bash

## 启动训练

function start_test_model() {
    cd ~/InceptionV4_for_PyTorch_1.1_code
    python3 train_1p.py --data ./ --npu 0 --epochs 1
}

start_test_model