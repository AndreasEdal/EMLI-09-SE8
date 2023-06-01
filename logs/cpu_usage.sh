#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

while true
do
        cpu_usage=$((100-$(vmstat 1 2|tail -1|awk '{print $15}')))
        current_time=$(date +%T)
        echo $current_time"," $cpu_usage"%" >> ./logfiles/cpu_usage.log
        sleep 1
done
