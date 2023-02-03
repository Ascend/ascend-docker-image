#!/bin/bash

# 0卡跑训练，需将数据集的位置修改到真实路径
cd ~/ResNet50_ID0058_for_TensorFlow/scripts/ || exit 1
sed -i 's@--data_path=/data/imagenet/@--data_path=/home/HwHiAiUser/ResNet50_ID0058_for_TensorFlow/data/imagenet2012@' train_1p.sh
bash train_1p.sh&
device_id=$(grep device_id train_1p.sh|head -1|cut -d'=' -f2)
echo test start
sleep 5
tail -f log/train_${device_id}.log&
wait_time=0
while true;do
    file_size=$(wc -c < log/train_${device_id}.log)
    sleep 20
    wait_time=$((wait_time+20))
    file_size2=$(wc -c < log/train_${device_id}.log)
    ckpt_file_exists=$(find d_solution/ckpt${device_id}/ -name 'model.ckpt-1000.data*' | wc -l)
    if [ $file_size -eq $file_size2 ] && [ $ckpt_file_exists -eq 1 ];then
        echo test tensorflow-modelzoo model success
        exit 0
    fi
    if [ $file_size -eq $file_size2 ] && [ $ckpt_file_exists -eq 0 ] && [ ${wait_time} -eq 600 ];then
        echo test tensorflow-modelzoo model failed
        exit 1
    fi 
done