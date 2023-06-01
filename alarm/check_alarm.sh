#!/bin/bash

# Must be run using 'bash' and not 'sh'

hostname="192.168.10.222"

plantWaterAlarmOn="false"
pumpWaterAlarmOn="false"

mosquitto_sub -h localhost -t "alarm/#" -p 1883 -u "abba" -P "1234" -v | while read -r payload
do
	IFS=' ' read -r topic message <<< $payload

	echo "topic: ${topic}, message: ${message}"

	if [ $topic = "alarm/plantWater" ]; then

		if [ $message = "0" ]; then
			plantWaterAlarmOn="false"
		fi

		if [ $message = "1" ]; then
                        plantWaterAlarmOn="true"
                fi
	fi

	if [ $topic = "alarm/pumpWater" ]; then

		if [ $message = "1" ]; then
			pumpWaterAlarmOn="false"
		fi

		if [ $message = "0" ]; then
                        pumpWaterAlarmOn="true"
                fi
	fi

	# Check alarm
	echo "plant: ${plantWaterAlarmOn}, pump: ${pumpWaterAlarmOn}"

	# TODO: If one is "true" then publish true to the topic
	# otherwise send false

	# We have decided to publish the answer inside another topic as we also must consider the moistness
	# before turning on the lights
	

done
