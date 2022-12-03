#!/bin/bash

arch=$(uname -m)

have_torch=$(find . |grep "mindspore"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put mindspore wheel package here"
    exit 1
fi

have_torch=$(find . |grep "mindx_elastic"|grep $arch|wc -l)
if [ $have_torch == 0 ]; then
    echo "please put mindx_elastic wheel package here"
    exit 1
fi

have_nnae=$(find . |grep cann|grep nnae|grep $arch|wc -l)
if [ $have_nnae == 0 ]; then
    echo "please put nnae package here"
    exit 1
fi

docker build . -t mindspore-modelzoo
