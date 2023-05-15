## 生成镜像
function build_image()
{
    cd ../$1
    bash build.sh
    cd -
}

function parse_script_args()
{
    while true; do
        case "$1" in
        --help | -h)
            NEED_HELP=yes
            shift
            ;;
        --modelzoo=*)
            image=$(echo "$1" | cut -d"=" -f2)
            if [[ "${image}" = "mindspore" ]]; then
                build_image mindspore-modelzoo
            elif [[ "${image}" = "pytorch" ]]; then
                build_image pytorch-modelzoo
            elif [[ "${image}" = "pytorch1.11.0" ]]; then
                build_image pytorch1.11.0-modelzoo
            elif [[ "${image}" = "tensorflow" ]]; then
                build_image tensorflow-modelzoo
            elif [[ "${image}" = "tensorflow265" ]]; then
                build_image tensorflow2.6.5-modelzoo
            elif [[ "${image}" = "infer-mxvision" ]]; then
                build_image infer-modelzoo-mxvision
            elif [[ "${image}" = "all-in-one" ]]; then
                build_image all-in-one
            elif [[ "${image}" = "all" ]]; then
                build_image mindspore-modelzoo
                build_image pytorch-modelzoo
                build_image pytorch1.11.0-modelzoo
                build_image tensorflow-modelzoo
                build_image tensorflow2.6.5-modelzoo
                build_image infer-modelzoo-mxvision
                build_image all-in-one
            else
                echo "Please check the parameter of --modelzoo"
                exit 1
            fi
            shift
            ;;
        --common=*)
            image=$(echo "$1" | cut -d"=" -f2)
            if [[ "${image}" = "algorithm" ]]; then
                build_image ascend-algorithm
            elif [[ "${image}" = "infer" ]]; then
                build_image ascend-infer
            elif [[ "${image}" = "mindspore" ]]; then
                build_image ascend-mindspore
            elif [[ "${image}" = "pytorch" ]]; then
                build_image ascend-pytorch
            elif [[ "${image}" = "pytorch1.11.0" ]]; then
                build_image ascend-pytorch1.11.0
            elif [[ "${image}" = "tensorflow" ]]; then
                build_image ascend-tensorflow
            elif [[ "${image}" = "toolkit" ]]; then
                build_image ascend-toolkit
            elif [[ "${image}" = "base-infer" ]]; then
                build_image ascendbase-infer
            elif [[ "${image}" = "base-toolkit" ]]; then
                build_image ascendbase-toolkit
            elif [[ "${image}" = "hccl-test" ]]; then
                build_image hccl-test
            elif [[ "${image}" = "cluster" ]]; then
                build_image cluster-flops-test
            elif [[ "${image}" = "all" ]]; then
                build_image ascendbase-toolkit
                build_image ascendbase-infer
                build_image ascend-algorithm
                build_image ascend-infer
                build_image ascend-toolkit
                build_image ascend-mindspore
                build_image ascend-pytorch
                build_image ascend-pytorch1.11.0
                build_image ascend-tensorflow
                build_image hccl-test
                build_image cluster
            else
                echo "Please check the parameter of --common"
                exit 1
            fi
            shift
            ;;
        -*)
            echo "Unsupported parameters: $1"
            exit 1
            ;;
        *)
            if [ "x$1" != "x" ]; then
                echo "Unsupported parameters: $1"
                exit 1
            fi
            break
            ;;
        esac
    done
}

main()
{
    parse_script_args $@
    if [[ "${NEED_HELP}" = yes ]]; then
    cat <<EOF
run-build-images.sh is used to build images

Command: run-build-images.sh [OPTIONS]...

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