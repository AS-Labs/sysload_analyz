#!/bin/bash


# by running periodically, checking the system load of the system.
# taking the approximation of any issues with the formula SYSLOAD_1m/CPU_CORES x 100 > 150
# if this condition is met:
# run and collect point in time perf trace and generate a flamegraph at 99Hz polling.

# sysload check
cpu_cores=$(cat /proc/cpuinfo|grep "model name"|wc -l)
sysload=$(uptime|grep load|awk -F'average:' '{print $2}'|awk -F',' '{print $1}'|awk -F'.' '{print $1}')
percentage_load=$(python -c "print ($sysload/$cpu_cores * 100)"|awk -F'.' '{print $1}')

if [[ $percentage_load -gt 120 ]]
then
    echo "generating perf report"
    exit 0
else
    echo "sysload is normal"
    exit 0
fi
