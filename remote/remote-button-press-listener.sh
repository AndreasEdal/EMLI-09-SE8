#!bin/bash

server=localhost
topic=remote/button/pressed
port=1883
delay=0.5
username=abba
password=1234

remote_ip=192.168.10.222

while true
do
	BUTTON_COUNT=$(curl "http://${remote_ip}/button/a/count" -s)
	echo $BUTTON_COUNT
	
	if [ $BUTTON_COUNT -gt "0" ]
	then
		mosquitto_pub -h $server -p $port -u $username -P $password -t $topic -m "button pressed"
		echo "message sent to mqtt broker"
	fi
	sleep $delay
done
