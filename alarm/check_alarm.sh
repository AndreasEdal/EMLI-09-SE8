#!/bin/bash

# Must be run using 'bash' and not 'sh'

hostname="192.168.10.222"

plantWaterAlarmOn=false
pumpWaterAlarmOn=false

while true 
do

	mosquitto_sub -h localhost -t "alarm/raw/#" -p 1883 -u "abba" -P "1234" -v | while read -r payload
	do
		IFS=' ' read -r topic message <<< $payload

		echo "topic: ${topic}, message: ${message}"

		if [ $topic = "alarm/raw/plantWater" ]; then

			if [ $message = "0" ]; then
				plantWaterAlarmOn=false
			fi

			if [ $message = "1" ]; then
				plantWaterAlarmOn=true
			fi
		fi

		if [ $topic = "alarm/raw/pumpWater" ]; then

			if [ $message = "1" ]; then
				pumpWaterAlarmOn=false
			fi

			if [ $message = "0" ]; then
				pumpWaterAlarmOn=true
			fi
		fi

		# Check alarm
		echo "plant: ${plantWaterAlarmOn}, pump: ${pumpWaterAlarmOn}"

		# If one is "true" then publish true to the topic, otherwise send false
		if [[ $plantWaterAlarmOn = true || $pumpWaterAlarmOn = true ]]; then
			isOn=true
		else
			isOn=false
		fi

		mosquitto_pub -h localhost -t "state/alarm/isOn" -p 1883 -u "abba" -P "1234" -m "${isOn}" -r
		echo "isOn: ${isOn}"
		
	done

done
