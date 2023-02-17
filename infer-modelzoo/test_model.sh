#!/bin/bash

cd ResNet152/sdk
bash run.sh imgs/ res
cat /home/HwHiAiUser/log/mindxsdk/logs/mindx_sdk.INFO
if [ "$(grep -c "Destroy streams successfully" /home/HwHiAiUser/log/mindxsdk/logs/mindx_sdk.INFO)" -gt 0 ];then
    echo test infer-modelzoo model success
    exit 0
else
    echo test infer-modelzoo model failed
    exit 1
fi