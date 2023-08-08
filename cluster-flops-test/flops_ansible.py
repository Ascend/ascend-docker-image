#!/usr/bin/env python3
# coding: utf-8
# Copyright 2022 Huawei Technologies Co., Ltd

import subprocess
import argparse
import json
import sys
import glob
import re


def flops_test(args):
    npu_id, test_type, chip_name = args
    flops_info = {
        "chip_name": chip_name,
        "npu_id": npu_id,
        "ops": "",
        "ops_type": test_type,
    }
    pattern = r"910B\d"
    if re.search(pattern, chip_name) and test_type == "int8":
        flops_result = "The int8 type is not supported on 1980B serieds"
        flops_info["ops"] = flops_result
        return flops_result, flops_info
    if not re.search(pattern, chip_name) and test_type == "fp32":
        flops_result = "The fp32 type is only supported on 1980B series, please change the type to int8 or fp16"
        flops_info["ops"] = flops_result
        return flops_result, flops_info
    flops_process = subprocess.run(
        [
            "ascend-dmi",
            "-f",
            "--fmt",
            "json",
            "-d",
            f"{npu_id}",
            "-t",
            f"{test_type}",
        ],
        shell=False,
        capture_output=True,
        encoding="utf-8",
    )
    if flops_process.returncode != 0 or "error" in flops_process.stdout:
        flops_result = "can not test the device"
        flops_info["ops"] = flops_result
        return flops_result, flops_info
    flops_dict = json.loads(flops_process.stdout)
    device_id = flops_dict["computing_power"]["device_id"]
    if test_type == "fp16":
        flops_result = str(flops_dict["computing_power"]["tflops_fp16"])
    elif test_type == "int8":
        flops_result = str(flops_dict["computing_power"]["tops_int8"])
    else:
        flops_result = str(flops_dict["computing_power"]["tflops_fp32"])
    if "/" in device_id:
        flops_result = float(flops_result) / len(device_id.split("/"))
    flops_info["ops"] = flops_result
    return flops_result, flops_info


def get_chip_name_list(npu_number):
    get_dmi_details_process = subprocess.run(
        ["ascend-dmi", "-i", "--dt"],
        shell=False,
        capture_output=True,
        encoding="utf-8",
    )
    if "failed" in get_dmi_details_process.stdout:
        raise RuntimeError(
            "The chip is not available, please ensure that no other containers are occupying the chip"
        )
    find_chip_name = re.findall("Chip Name.*: (.*)", get_dmi_details_process.stdout)
    if len(find_chip_name) > 0:
        res = [i for i in find_chip_name]
        con = -1
        if "Ascend 310" in res or "Ascend 310P3" in get_dmi_details_process.stdout:
            con = 1
        return res, con
    else:
        get_npu_details_process = subprocess.run(
            ["npu-smi", "info"],
            shell=False,
            capture_output=True,
            encoding="utf-8",
        )
        if get_npu_details_process.returncode == 0:
            find_chip_name = re.findall(
                r"310\w*|910\w*", get_npu_details_process.stdout
            )
            if len(find_chip_name) > 0:
                res = [i for i in find_chip_name]
                con = -1
                if "310" in res or "310P3" in res:
                    con = 1
                return res, con
            else:
                return ["310P" for _ in range(npu_number)], 1
        else:
            return ["unknown" for _ in range(npu_number)], 1


def get_npu_count():
    npu_count = len(glob.glob("/dev/davinci[0-9]*"))
    if npu_count == 0:
        raise FileNotFoundError("davinci device is not exists")
    return npu_count


def main():
    chip_name_list, _ = get_chip_name_list(npu_count)
    flops_info_dict = {}
    for i in range(npu_count):
        flops_result, flops_info = flops_test((i, args.type, chip_name_list[i]))
        print(flops_result)
        flops_info_dict[i] = flops_info
    print(flops_info_dict)


def parse_argument():
    flops_test_help = (
        "Specifies test type of the matrix multiplications running on a single ai core."
    )
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("--type", help=flops_test_help, metavar="")
    try:
        args = parser.parse_args()
    except SystemExit as e:
        if e.code == 0:
            sys.exit(0)
        else:
            sys.exit(1)
    if args.type != "fp16" and args.type != "fp32" and args.type != "int8":
        print("The value can only be fp16 or fp32 or int8")
        parser.print_help()
        sys.exit(1)
    return args


if __name__ == "__main__":
    args = parse_argument()
    try:
        npu_count = get_npu_count()
    except FileNotFoundError as e:
        print(e)
        sys.exit(1)
    main()
