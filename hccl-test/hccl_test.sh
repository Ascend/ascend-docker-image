#!/bin/bash

echo ---------------all_gather_test---------------
mpirun -n 8 all_gather_test -b 8K -e 64M -f 2 -d fp32 -p 8
echo ---------------all_reduce_test---------------
mpirun -n 8 all_reduce_test -b 8K -e 64M -f 2 -d fp32 -o sum -p 8
echo ---------------alltoallv_test---------------
mpirun -n 8 alltoallv_test -b 8K -e 64M -f 2 -d fp32 -p 8
echo ---------------broadcast_test---------------
mpirun -n 8 broadcast_test -b 8K -e 64M -f 2 -d fp32 -p 8
echo ---------------reduce_scatter_test---------------
mpirun -n 8 reduce_scatter_test -b 8K -e 64M -f 2 -d fp32 -o sum -p 8
echo ---------------reduce_test---------------
mpirun -n 8 reduce_test -b 8K -e 64M -f 2 -d fp32 -o sum -p 8