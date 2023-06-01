#!/bin/bash

server=localhost
topic=alarm/isOn
port=1883
username=abba
password=1234

remote_ip=192.168.10.222

alarmStatus=$(mosquitto_sub -h $server -t $topic -p $port -u $username -P $password -C 1)
echo "$alarmStatus"
if [ $alarmStatus = "false" ]; then
   echo 'p' > /dev/pico01
fi
