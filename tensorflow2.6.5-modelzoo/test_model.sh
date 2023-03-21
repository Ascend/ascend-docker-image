#!/bin/bash

function start_test_model() {
    if [ $1 == 1p ];then
        cd ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test
        . /usr/local/Ascend/tfplugin/set_env.sh && . /usr/local/Ascend/ascend-toolkit/set_env.sh
        bash train_full_1p_static.sh --data_path=/home/HwHiAiUser/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/data/cifar10/cifar-10-batches-py/ --train_epochs=20&
        sleep 5
        tail -f output/train_.log &
        while true;do
            sleep 20
            wait_time=$((wait_time+20))
            if [ "$(grep -c "Stop graph engine succeed" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] && [ "$(grep -c Epoch ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ];then
                sleep 20
                echo test tensorflow-modelzoo model success
                exit 0
            fi
            if [ "$(grep -c "Error" ~/samples/Keras-MnasNet_ID3518_for_TensorFlow2.X/test/output/train_.log)" -gt 0 ] || [ ${wait_time} -eq 1000 ];then
                echo test tensorflow-modelzoo model failed
                exit 1
            fi 
        done
    fi
    if [ $1 == 8p ];then
        export framework=Tensorflow
        cd /home/HwHiAiUser/samples/ResNet50_ID0360_for_TensorFlow2.X/test
        bash train_start.sh /home/HwHiAiUser/samples/ResNet50_ID0360_for_TensorFlow2.X/ /home/HwHiAiUser/samples/logs tensorflow/resnet_ctl_imagenet_main.py --data_dir=/job/data --distribution_strategy=one_device --use_tf_while_loop=true --epochs_between_evals=1 --skip_eval --enable_checkpoint_and_export --model_dir=/home/HwHiAiUser/samples/ --batch_size=2048 --train_epochs=5 --base_learning_rate=3.96 --over_dump=False --data_dump_flag=False --data_dump_step=10 --profiling=False --autotune=False --warmup_epochs=5 --label_smoothing=0.1 --weight_decay=0.000025 --num_accumulation_steps=1 --train_steps=625 --optimizer=SGD --lr_schedule=polynomial --drop_eval_remainder=True --eval_offset_epochs=2
    fi
}

start_test_model $1