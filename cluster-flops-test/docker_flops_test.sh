. Ascend/toolbox/set_env.sh
. Ascend/nnae/set_env.sh &> /dev/null || . Ascend/nnrt/set_env.sh &> /dev/null
python3 flops_ansible.py --type=$1
