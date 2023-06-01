#TODO
#!/bin/bash
DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

server=localhost
topic=moisture/values
topic2=moisture/lastPump
port=1883
username=abba
password=1234

remote_ip=192.168.10.222

moisture=$(mosquitto_sub -h $server -t $topic -p $port -u $username -P $password -C 1)
echo "$moisture"
if [ $moisture -gt 40 ]; then
   echo "No Pump, too moist"
   exit 0
fi

echo "Moisture dry, was less than 40"

lastPump=$(mosquitto_sub -h $server -t $topic2 -p $port -u $username -P $password -C 1)
current_time=$(date +%s)
time_diff=$(($current_time - $lastPump))

if [ $time_diff -gt 30 ]; then
   echo "30 sec since last pump, PUMP IT!"
   mosquitto_pub -h $server -t $topic2 -p $port -u $username -P $password -m $current_time -r
   sh ./start_pump.sh
fi
#plantStatus=$(mosquitto_sub -h $server -t $topic2 -p $port -u $username -P $password -C 1)
#echo "$plantStatus"

#if [ $plantStatus -eq 1 ]; then
#   exit 0
#fi

#echo "12 hours have passed since the last pump. Starting pump!"
#echo 'p' > /dev/pico01
