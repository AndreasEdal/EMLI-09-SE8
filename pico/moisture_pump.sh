#TODO
#!/bin/bash

server=localhost
topic=moisture/value
topic2=moisture/lastPump
port=1883
username=abba
password=1234

remote_ip=192.168.10.222

moisture=$(mosquitto_sub -h $server -t $topic -p $port -u $username -P $password -C 1)
echo "$moisture"
if [ $moisture -gt 40 ]; then
   exit 0
fi

echo "Moisture dry, was less than 40"

#plantStatus=$(mosquitto_sub -h $server -t $topic2 -p $port -u $username -P $password -C 1)
#echo "$plantStatus"

#if [ $plantStatus -eq 1 ]; then
#   exit 0
#fi

#echo "12 hours have passed since the last pump. Starting pump!"
#echo 'p' > /dev/pico01
