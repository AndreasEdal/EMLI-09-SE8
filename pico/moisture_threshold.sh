#!/bin/bash
DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

server=localhost
topic=moisture/value
topic2=state/moisture/isUnderThreshold
port=1883
username=abba
password=1234


while true
do
   mosquitto_sub -h $server -t $topic -p $port -u $username -P $password | while read -r moisture
   do
      echo "$moisture"
      if [ $moisture -lt 40 ]; then
         echo "true"
         mosquitto_pub -h $server -t $topic2 -p $port -u $username -P $password -m "true"
      else
         echo "false"
         mosquitto_pub -h $server -t $topic2 -p $port -u $username -P $password -m "false"
      fi
   done
done
