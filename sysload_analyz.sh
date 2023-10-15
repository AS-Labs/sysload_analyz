#!/bin/bash


# by running periodically, checking the system load of the system.
# taking the approximation of any issues with the formula SYSLOAD_1m/CPU_CORES x 100 > 150
# if this condition is met:
# run and collect point in time perf trace and generate a flamegraph at 99Hz polling.

script_pid=$$

while true
do
    # sysload check
    cpu_cores=$(cat /proc/cpuinfo|grep "model name"|wc -l)
    sysload=$(uptime|grep load|awk -F'average:' '{print $2}'|awk -F',' '{print $1}'|awk -F'.' '{print $1}')
    percentage_load=$(python -c "print ($sysload/$cpu_cores * 100)"|awk -F'.' '{print $1}')
    echo "sysload = $percentage_load"
    
    if [[ $percentage_load -gt 120 ]]
    then
        echo "generating perf report"
	date_now=$(date "+%d-%m-%yT%HH%MM%SS")
	ps aux > ./ps-$date_now.out
        sudo perf record -F 99 -ag -- sleep 30
        sudo perf script | ./stackcollapse-perf.pl > highload.perf-folded
        sudo ./flamegraph.pl highload.perf-folded > perf-$(date "+%d-%m-%yT%HH%MM%SS").svg
        echo "Flamegraph generated at ./perf.svg"
        kill -9 $script_pid
	exit 1
    else
        echo "sysload is normal"
    fi
    sleep 5
done
