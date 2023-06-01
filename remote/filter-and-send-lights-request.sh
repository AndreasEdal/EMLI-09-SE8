#!/bin/bash

# Must be run using 'bash' and not 'sh'

IFS='/'
hostname="192.168.10.222"

while true 
do

	mosquitto_sub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" | while read -r payload
	do
		read -a segments <<< $payload

		# Segment message into color and state
		color=${segments[0]}
		state=${segments[1]}
		echo "Color: ${color}"
		echo "State: ${state}"

		# Send an HTTP request to the remote to activate the right LED
		curl "${hostname}/led/${color}/${state}"
	done

done