#!/bin/bash
current_time=$(date +%T) 

ping -c 1 google.com > /dev/null

if [ $? -eq 0 ]; then
  echo $current_time, "Internet connection: True" >> ./logfiles/internet_connection.log
  sh ./internet_speed.sh
else
  echo $current_time, "Internet connection: False" >> ./logfiles/internet_connection.log
fi