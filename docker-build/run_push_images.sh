version=23.0.RC3
public_repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
private_repository=swr.cn-east-3.myhuaweicloud.com/ascendhub_tl
if [[ $2 == "public" ]]; then
    repository=${public_repository}
else
    repository=${private_repository}
fi
if [[ $(arch) == "x86_64" ]]; then
    ARCH=x64
else
    ARCH=arm64
fi


push_mindspore_modelzoo()
{
    docker tag mindspore-modelzoo:ubuntu18.04-${ARCH} ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/mindspore-modelzoo:${version}-ubuntu18.04-${ARCH}
}

push_pytorch_modelzoo()
{
    docker tag pytorch-modelzoo:ubuntu18.04-${ARCH} ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-${ARCH}
    docker push ${repository}/pytorch-modelzoo:${version}-1.8.1-ubuntu18.04-${ARCH}
}

push_pytorch1110_modelzoo()
{
    docker tag pytorch1.11.0-modelzoo:ubuntu18.04-${ARCH} ${repository}/pytorch-modelzoo:${version}-1.11.0-ubuntu18.04-${ARCH}
    docker push ${repository}/pytorch-modelzoo:${version}-1.11.0-ubuntu18.04-${ARCH}
}

push_tensorflow_modelzoo()
{
    docker tag tensorflow-modelzoo:ubuntu18.04-${ARCH} ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/tensorflow-modelzoo:${version}-ubuntu18.04-${ARCH}
}

push_tensorflow265_modelzoo()
{
    docker tag tensorflow2.6.5-modelzoo:ubuntu18.04-${ARCH} ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-${ARCH}
    docker push ${repository}/tensorflow-modelzoo:${version}-2.6.5-ubuntu18.04-${ARCH}
}

push_infer_modelzoo()
{
    docker tag infer-modelzoo:ubuntu18.04-${ARCH} ${repository}/infer-modelzoo:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/infer-modelzoo:${version}-ubuntu18.04-${ARCH}
}

push_infer_modelzoo_mxvision()
{
    docker tag infer-modelzoo:mxvision-ubuntu18.04-${ARCH} ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-${ARCH}
    docker push ${repository}/infer-modelzoo:${version}-mxvision-ubuntu18.04-${ARCH}
}

push_all_in_one()
{
    docker tag all-in-one:ubuntu18.04-${ARCH} ${repository}/all-in-one:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/all-in-one:${version}-ubuntu18.04-${ARCH}
}

push_ascend_algorithm()
{
    docker tag ascend-algorithm:ubuntu18.04-${ARCH} ${repository}/algorithm:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/algorithm:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-algorithm:centos7.6-${ARCH} ${repository}/algorithm:${version}-centos7.6-${ARCH}
    docker push ${repository}/algorithm:${version}-centos7.6-${ARCH}
    docker tag ascend-algorithm:openeuler20.03-${ARCH} ${repository}/algorithm:${version}-openeuler20.03-${ARCH}
    docker push ${repository}/algorithm:${version}-openeuler20.03-${ARCH}
}

push_ascend_infer()
{
    docker tag ascend-infer:ubuntu18.04-${ARCH} ${repository}/ascend-infer:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-infer:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-infer:centos7.6-${ARCH} ${repository}/ascend-infer:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend-infer:${version}-centos7.6-${ARCH}
}

push_ascend_infer_310b()
{
    docker tag ascend-infer-310b:${version}-arm64 ${repository}/ascend-infer-310b:${version}-arm64
    docker push ${repository}/ascend-infer-310b:${version}-arm64
    docker tag ascend-infer-310b:${version}-dev-arm64 ${repository}/ascend-infer-310b:${version}-dev-arm64
    docker push ${repository}/ascend-infer-310b:${version}-dev-arm64
}

push_ascend_toolkit()
{
    docker tag ascend-toolkit:ubuntu18.04-${ARCH} ${repository}/ascend-toolkit:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-toolkit:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-toolkit:centos7.6-${ARCH} ${repository}/ascend-toolkit:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend-toolkit:${version}-centos7.6-${ARCH}
}

push_ascend_mindspore()
{
    docker tag ascend-mindspore:ubuntu18.04-${ARCH} ${repository}/ascend-mindspore:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-mindspore:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-mindspore:centos7.6-${ARCH} ${repository}/ascend-mindspore:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend-mindspore:${version}-centos7.6-${ARCH}
}

push_ascend_pytorch()
{
    docker tag ascend-pytorch:ubuntu18.04-${ARCH} ${repository}/ascend-pytorch:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-pytorch:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-pytorch:centos7.6-${ARCH} ${repository}/ascend-pytorch:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend-pytorch:${version}-centos7.6-${ARCH}
}

push_ascend_pytorch1110()
{
    docker tag ascend-pytorch1.11.0:ubuntu18.04-${ARCH} ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-pytorch:${version}-1.11.0-ubuntu18.04-${ARCH}
    docker tag ascend-pytorch1.11.0:centos7.6-${ARCH} ${repository}/ascend-pytorch:${version}-1.11.0-centos7.6-${ARCH}
    docker push ${repository}/ascend-pytorch:${version}-1.11.0-centos7.6-${ARCH}
}

push_ascend_tensorflow()
{
    docker tag ascend-tensorflow:ubuntu18.04-${ARCH} ${repository}/ascend-tensorflow:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend-tensorflow:${version}-ubuntu18.04-${ARCH}
    docker tag ascend-tensorflow:centos7.6-${ARCH} ${repository}/ascend-tensorflow:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend-tensorflow:${version}-centos7.6-${ARCH}
}

push_hccl_test()
{
    docker tag hccl-test:ubuntu18.04-${ARCH} ${repository}/hccl-test:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/hccl-test:${version}-ubuntu18.04-${ARCH}
}

push_cluster()
{
    docker tag cluster-flops-test:${ARCH} ${repository}/cluster-flops-test:${version}-${ARCH}
    docker push ${repository}/cluster-flops-test:${version}-${ARCH}
}

push_ascendbase_toolkit()
{
    docker tag ascendbase-toolkit:ubuntu18.04-${ARCH} ${repository}/ascendbase-toolkit:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascendbase-toolkit:${version}-ubuntu18.04-${ARCH}
    docker tag ascendbase-toolkit:centos7.6-${ARCH} ${repository}/ascendbase-toolkit:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascendbase-toolkit:${version}-centos7.6-${ARCH}
    docker tag ascendbase-toolkit:openeuler20.03-${ARCH} ${repository}/ascendbase-toolkit:${version}-openeuler20.03-${ARCH}
    docker push ${repository}/ascendbase-toolkit:${version}-openeuler20.03-${ARCH}
}

push_ascendbase_infer()
{
    docker tag ascendbase-infer:ubuntu18.04-${ARCH} ${repository}/ascendbase-infer:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascendbase-infer:${version}-ubuntu18.04-${ARCH}
    docker tag ascendbase-infer:centos7.6-${ARCH} ${repository}/ascendbase-infer:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascendbase-infer:${version}-centos7.6-${ARCH}
}


function parse_script_args()
{
    case "$1" in
    --help | -h)
        NEED_HELP=yes
        ;;
    --modelzoo=*)
        image=$(echo "$1" | cut -d"=" -f2)
        if [[ "${image}" = "mindspore" ]]; then
            push_mindspore_modelzoo
        elif [[ "${image}" = "pytorch" ]]; then
            push_pytorch_modelzoo
        elif [[ "${image}" = "pytorch1.11.0" ]]; then
            push_pytorch1110_modelzoo
        elif [[ "${image}" = "tensorflow" ]]; then
            push_tensorflow_modelzoo
        elif [[ "${image}" = "tensorflow265" ]]; then
            push_tensorflow265_modelzoo
        elif [[ "${image}" = "infer-mxvision" ]]; then
            push_infer_modelzoo_mxvision
        elif [[ "${image}" = "all-in-one" ]]; then
            push_all_in_one
        elif [[ "${image}" = "all" ]]; then
            push_mindspore_modelzoo
            push_pytorch_modelzoo
            push_pytorch1110_modelzoo
            push_tensorflow_modelzoo
            push_tensorflow265_modelzoo
            push_infer_modelzoo_mxvision
            push_all_in_one
        else
            echo "Please check the parameter of --modelzoo"
            exit 1
        fi
        ;;
    --common=*)
        image=$(echo "$1" | cut -d"=" -f2)
        if [[ "${image}" = "algorithm" ]]; then
            push_ascend_algorithm
        elif [[ "${image}" = "infer" ]]; then
            push_ascend_infer
        elif [[ "${image}" = "mindspore" ]]; then
            push_ascend_mindspore
        elif [[ "${image}" = "pytorch" ]]; then
            push_ascend_pytorch
        elif [[ "${image}" = "pytorch1.11.0" ]]; then
            push_ascend_pytorch1110
        elif [[ "${image}" = "tensorflow" ]]; then
            push_ascend_tensorflow
        elif [[ "${image}" = "toolkit" ]]; then
            push_ascend_toolkit
        elif [[ "${image}" = "base-infer" ]]; then
            push_ascendbase_infer
        elif [[ "${image}" = "base-toolkit" ]]; then
            push_ascendbase_toolkit
        elif [[ "${image}" = "hccl-test" ]]; then
            push_hccl_test
        elif [[ "${image}" = "cluster" ]]; then
            push_cluster
        elif [[ "${image}" = "infer-310b" ]]; then
            push_ascend_infer_310b
        elif [[ "${image}" = "all" ]]; then
            push_ascendbase_toolkit
            push_ascendbase_infer
            push_ascend_algorithm
            push_ascend_infer
            push_ascend_toolkit
            push_ascend_mindspore
            push_ascend_pytorch
            push_ascend_pytorch1110
            push_ascend_tensorflow
            push_hccl_test
            push_cluster
            push_ascend_infer_310b
        else
            echo "Please check the parameter of --common"
            exit 1
        fi
        ;;
    -*)
        echo "Unsupported parameters: $1"
        exit 1
        ;;
    *)
        if [ "$1" != "x" ]; then
            echo "Unsupported parameters: $1"
            exit 1
        fi
        break
        ;;
    esac
}

main()
{
    parse_script_args $@
    if [[ "${NEED_HELP}" = yes ]]; then
    cat <<EOF
run-push-images.sh is used to push images

Command: run-push-images.sh [OPTIONS]...

Options:
    -h, --help                    Displays the help information.
    --modelzoo= mindspore         Specifies the modelzoo image to be created.
                pytorch
                pytorch1.11.0
                tensorflow
                tensorflow265
                infer
                infer-mxvision
                all-in-one
                all
    --common=   algorithm          Specifies the common image to be created. 
                infer
                modelzoo
                pytorch
                pytorch1.11.0
                tensorflow
                toolkit
                base-infer
                base-toolkit
                hccl-test
                cluster
                all
EOF
        exit 0
    fi
}

main "$@"