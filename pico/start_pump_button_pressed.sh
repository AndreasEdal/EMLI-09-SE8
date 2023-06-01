#!/bin/bash

DIR_BIN=`dirname $(readlink -f $0)`
cd $DIR_BIN

server=localhost
topic=remote/button/pressed
port=1883
delay=2
username=abba
password=1234

echo "Button pressed subscriber started..."
while [ true ]
do
	mosquitto_sub -h $server -t $topic -p $port -u $username -P $password | while read -r payload
    	do
		sh ./start_pump.sh
		echo "Button is pressed on the remote" # Here is the callback to execute whenever you receive a message:
    	done
done
