#!/bin/bash
server=localhost
port=1883
delay=2
username=abba
password=1234
delay=1

while true
do
        string=$(sudo head /dev/pico01)
        if [ -n "$string" ]; then
                IFS=',' read -r var1 var2 var3 var4 <<< "$string"
                mosquitto_pub -h $server -p $port -u $username -P $password -t "alarm/raw/plantWater" -m  "$var1" 
                echo "$var1 sent to alarm/raw/plantWater"
                mosquitto_pub -h $server -p $port -u $username -P $password -t "alarm/raw/pumpWater" -m  "$var2" 
                echo "$var2 sent to alarm/raw/pumpWater"
                mosquitto_pub -h $server -p $port -u $username -P $password -t "moisture/value" -m  "$var3" 
                echo "$var3 sent to moisture/value"
                mosquitto_pub -h $server -p $port -u $username -P $password -t "light/value" -m  "$var4" 
                echo "$var4 sent to light"
        else
                echo "no value rescived, nothing to publish"
        fi  
        sleep $delay
done
