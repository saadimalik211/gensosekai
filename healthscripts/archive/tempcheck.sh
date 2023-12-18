#!/bin/bash

# Capture the output of the sensors command
output=$(sensors)

# Extract the package temperature
package_temp=$(echo "$output" | grep 'Package id 0:' | awk '{print $4}')

# Extract the core temperatures and calculate the max and average
core_temps=$(echo "$output" | grep -E 'Core [0-7]:' | awk '{print $3}')
max_core_temp=$(echo "$core_temps" | sort -nr | head -1)
avg_core_temp=$(echo "$core_temps" | awk '{total += $1; count++} END {print total/count}')

# Log the extracted values with a timestamp
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
echo "$timestamp | Package Temperature: $package_temp | Max Core Temperature: $max_core_temp | Average Core Temperature: $avg_core_temp" >> /opt/logs/temperature.log

