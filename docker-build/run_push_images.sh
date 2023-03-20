version=22.0.0
public_repository=swr.cn-east-3.myhuaweicloud.com/test-ascendhub
private_repository=swr.cn-east-3.myhuaweicloud.com/zy-shanghai-1
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

push_pytorch15_modelzoo()
{
    docker tag pytorch1.5-modelzoo:ubuntu18.04-${ARCH} ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/pytorch-modelzoo:${version}-ubuntu18.04-${ARCH}
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
    docker tag infer-modelzoo-mxvision:ubuntu18.04-${ARCH} ${repository}/infer-modelzoo-mxvision:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/infer-modelzoo-mxvision:${version}-ubuntu18.04-${ARCH}
}

push_all_in_one()
{
    docker tag all-in-one:ubuntu18.04-${ARCH} ${repository}/all-in-one:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/all-in-one:${version}-ubuntu18.04-${ARCH}
}

push_ascend_algorithm()
{
    docker tag ascend_algorithm:ubuntu18.04-${ARCH} ${repository}/ascend_algorithm:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_algorithm:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_algorithm:centos7.6-${ARCH} ${repository}/ascend_algorithm:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_algorithm:${version}-centos7.6-${ARCH}
    docker tag ascend_algorithm:openeuler20.03-${ARCH} ${repository}/ascend_algorithm:${version}-openeuler20.03-${ARCH}
    docker push ${repository}/ascend_algorithm:${version}-openeuler20.03-${ARCH}
}

push_ascend_infer()
{
    docker tag ascend_infer:ubuntu18.04-${ARCH} ${repository}/ascend_infer:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_infer:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_infer:centos7.6-${ARCH} ${repository}/ascend_infer:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_infer:${version}-centos7.6-${ARCH}
}

push_ascend_toolkit()
{
    docker tag ascend_toolkit:ubuntu18.04-${ARCH} ${repository}/ascend_toolkit:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_toolkit:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_toolkit:centos7.6-${ARCH} ${repository}/ascend_toolkit:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_toolkit:${version}-centos7.6-${ARCH}
}

push_ascend_mindspore()
{
    docker tag ascend_mindspore:ubuntu18.04-${ARCH} ${repository}/ascend_mindspore:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_mindspore:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_mindspore:centos7.6-${ARCH} ${repository}/ascend_mindspore:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_mindspore:${version}-centos7.6-${ARCH}
}

push_ascend_pytorch()
{
    docker tag ascend_pytorch:ubuntu18.04-${ARCH} ${repository}/ascend_pytorch:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_pytorch:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_pytorch:centos7.6-${ARCH} ${repository}/ascend_pytorch:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_pytorch:${version}-centos7.6-${ARCH}
}

push_ascend_tensorflow()
{
    docker tag ascend_tensorflow:ubuntu18.04-${ARCH} ${repository}/ascend_tensorflow:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascend_tensorflow:${version}-ubuntu18.04-${ARCH}
    docker tag ascend_tensorflow:centos7.6-${ARCH} ${repository}/ascend_tensorflow:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascend_tensorflow:${version}-centos7.6-${ARCH}
}

push_hccl_test()
{
    docker tag hccl-test:ubuntu18.04-${ARCH} ${repository}/hccl-test:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/hccl-test:${version}-ubuntu18.04-${ARCH}
}

push_ascendbase_toolkit()
{
    docker tag ascendbase_toolkit:ubuntu18.04-${ARCH} ${repository}/ascendbase_toolkit:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascendbase_toolkit:${version}-ubuntu18.04-${ARCH}
    docker tag ascendbase_toolkit:centos7.6-${ARCH} ${repository}/ascendbase_toolkit:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascendbase_toolkit:${version}-centos7.6-${ARCH}
    docker tag ascendbase_toolkit:openeuler20.03-${ARCH} ${repository}/ascendbase_toolkit:${version}-openeuler20.03-${ARCH}
    docker push ${repository}/ascendbase_toolkit:${version}-openeuler20.03-${ARCH}
}

push_ascendbase_infer()
{
    docker tag ascendbase_infer:ubuntu18.04-${ARCH} ${repository}/ascendbase_infer:${version}-ubuntu18.04-${ARCH}
    docker push ${repository}/ascendbase_infer:${version}-ubuntu18.04-${ARCH}
    docker tag ascendbase_infer:centos7.6-${ARCH} ${repository}/ascendbase_infer:${version}-centos7.6-${ARCH}
    docker push ${repository}/ascendbase_infer:${version}-centos7.6-${ARCH}
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
        elif [[ "${image}" = "pytorch15" ]]; then
            push_pytorch15_modelzoo
        elif [[ "${image}" = "tensorflow" ]]; then
            push_tensorflow_modelzoo
        elif [[ "${image}" = "tensorflow265" ]]; then
            push_tensorflow265_modelzoo
        elif [[ "${image}" = "infer" ]]; then
            push_infer_modelzoo
        elif [[ "${image}" = "infer-mxvision" ]]; then
            push_infer_modelzoo_mxvision
        elif [[ "${image}" = "all-in-one" ]]; then
            push_all_in_one
        elif [[ "${image}" = "all" ]]; then
            push_mindspore_modelzoo
            push_pytorch_modelzoo
            push_pytorch15_modelzoo
            push_tensorflow_modelzoo
            push_tensorflow265_modelzoo
            push_infer_modelzoo
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
        elif [[ "${image}" = "all" ]]; then
            push_ascendbase_toolkit
            push_ascendbase_infer
            push_ascend_algorithm
            push_ascend_infer
            push_ascend_toolkit
            push_ascend_mindspore
            push_ascend_pytorch
            push_ascend_tensorflow
            push_hccl_test
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
                pytorch15
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
                tensorflow
                toolkit
                base-infer
                base-toolkit
                hccl-test
                all
EOF
        exit 0
    fi
}

main "$@"