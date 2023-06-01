#!/bin/bash

alarmIsOn=false
moistureUnderThreshold=false

while true 
do

    mosquitto_sub -h localhost -t "state/#" -p 1883 -u "abba" -P "1234" -v | while read -r payload
    do
        IFS=' ' read -r topic message <<< $payload

        echo "topic: ${topic}, message: ${message}"

        if [ $topic = "state/alarm/isOn" ]; then

            if [ $message = "true" ]; then
                alarmIsOn=true
            elif [ $message = "false" ]; then
                alarmIsOn=false
            fi
        fi

        if [ $topic = "state/moisture/isUnderThreshold" ]; then

            if [ $message = "true" ]; then
                moistureUnderThreshold=true
            fi

            if [ $message = "false" ]; then
                moistureUnderThreshold=false
            fi
        fi

        # Check alarm
        echo "alarmIsOn: ${alarmIsOn}, moistureUnderThreshold: ${moistureUnderThreshold}"

        # If one is "true" then publish true to the topic, otherwise send false
        if [[ $alarmIsOn = true || $moistureUnderThreshold = true ]]; then
        
            if [[ $alarmIsOn = true ]]; then
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "red/on"
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "green/off"
            else
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "red/off"
            fi

            if [[ $moistureUnderThreshold = true ]]; then
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "yellow/on"
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "green/off"
            else
                mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "yellow/off"
            fi

        else
            mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "yellow/off"
            mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "red/off"
            mosquitto_pub -h localhost -t "remote/lights" -p 1883 -u "abba" -P "1234" -m "green/on"
        fi
    done
    
done