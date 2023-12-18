#!/bin/bash

# Define the log file name
LOGFILE="temperature.log" # Replace with the path to your log file if it's not in the current directory

# Check if the file exists
if [[ ! -f "$LOGFILE" ]]; then
    echo "Error: Log file not found!"
    exit 1
fi

# Extract the average temperatures
avg_temps=($(grep -oP 'Average Core Temperature: \K[0-9.]*' "$LOGFILE"))

# Check if data was found
if [[ ${#avg_temps[@]} -eq 0 ]]; then
    echo "No temperature data found in the log file."
    exit 1
fi

# Calculate min, max, and average
min=${avg_temps[0]}
max=${avg_temps[0]}
total=0

for temp in "${avg_temps[@]}"; do
  # Update min if applicable
  if (( $(echo "$temp < $min" | bc -l) )); then
    min=$temp
  fi

  # Update max if applicable
  if (( $(echo "$temp > $max" | bc -l) )); then
    max=$temp
  fi

  # Add to total for average calculation
  total=$(echo "$total + $temp" | bc -l)
done

# Calculate average
average=$(echo "scale=2; $total / ${#avg_temps[@]}" | bc -l)

# Output the results
echo "Minimum Average Core Temperature: $min°C"
echo "Maximum Average Core Temperature: $max°C"
echo "Overall Average of Average Core Temperatures: $average°C"

