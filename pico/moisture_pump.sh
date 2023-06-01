#TODO
#!/bin/bash
DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

server=localhost
topic=state/moisture/isUnderThreshold
topic2=moisture/lastPump
port=1883
username=abba
password=1234
remote_ip=192.168.10.222

while true
do
   moisture=$(mosquitto_sub -h $server -t $topic -p $port -u $username -P $password -C 1)
   echo "$moisture"
   if [ $moisture = "true" ]; then
         echo "Moisture is dry: less than 40"

      lastPump=$(mosquitto_sub -h $server -t $topic2 -p $port -u $username -P $password -C 1)
      current_time=$(date +%s)
      time_diff=$(($current_time - $lastPump))

      if [ $time_diff -gt 3600 ]; then
         mosquitto_pub -h $server -t $topic2 -p $port -u $username -P $password -m $current_time -r
         sh ./start_pump.sh
         echo "sleeping 1 hour"
         sleep 3600
      fi
   else
      echo "no pump, sleeping 1 min"
      sleep 60
   fi
done
