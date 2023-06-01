#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

while true
do
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
	current_time=$(date +%T)
        # echo $TEMP
        TEMP_NUM=$((TEMP / 1000))
        echo $current_time"," $TEMP_NUM"C" >> ./logfiles/cpu_temp.log
        sleep 1
done
