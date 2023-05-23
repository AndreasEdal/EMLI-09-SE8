#!/bin/bash
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
		echo "Button is pressed on the remote" # Here is the callback to execute whenever you receive a message:
        	echo 'p' > /dev/pico01
    	done
done
