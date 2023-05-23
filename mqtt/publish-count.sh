#!/bin/bash

server=localhost
topic=count
port=1883
delay=2
username=abba
password=1234


filename=count.txt
while read -r line; do
    message="$line"
    echo "$message are published to the topic: $topic"
    mosquitto_pub -h $server -p $port -u $username -P $password -t $topic -m $message 
done < "$filename"
 
