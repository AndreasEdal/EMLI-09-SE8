#!/bin/bash
server=localhost
topic=alarm/pumpWater
port=1883
delay=2
username=abba
password=1234

while true
do
        string=$(sudo head /dev/pico01)
        if [ -n "$string" ]; then
                IFS=',' read -r var1 var2 var3 var4 <<< "$string"
                mosquitto_pub -h $server -p $port -u $username -P $password -t $topic -m  "$var2" 
                echo "$var2 sent to $topic"
        else
                echo "no value rescived, nothing to publish"
        fi  
        sleep $delay
done


