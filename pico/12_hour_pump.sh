#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

server=localhost
topic=alarm/pumpWater
topic2=alarm/plantWater
port=1883
username=abba
password=1234

remote_ip=192.168.10.222


sh ./start_pump.sh
echo "12 hours have passed since the last pump. Starting pump!"


