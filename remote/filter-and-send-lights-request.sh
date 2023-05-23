#!/bin/bash

while [ true ]
do
	mosquitto_sub -h localhost -t "button/pressed" -p 1883 -u "abba" -P "1234" | while read -r payload
    	do
        	# Here is the callback to execute whenever you receive a message:
        	echo $payload # Change topic to lights topic and extract message data. Send the request to the remote to activate light
    	done
done
