#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

while true
do
        mem_usage=$(free | grep Mem | awk '{print $4/$2 * 100.0}')
        current_time=$(date +%T)
        echo $current_time"," $mem_usage"%" >> ./logfiles/mem_free.log
        sleep 1
done
