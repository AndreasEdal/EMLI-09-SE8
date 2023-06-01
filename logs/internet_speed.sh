#!/bin/bash

output=$(speedtest-cli --secure | awk -F': ' '/Hosted by/ { ping=$NF }
                                             /Download:/ { download=$2 }
                                             /Upload:/ { upload=$2 }
                                             END { print "Ping:", ping ",", "Download:", download ",", "Upload:", upload }')
current_time=$(date +%T) 

echo $current_time "," $output >> ./logfiles/internet_speed.log