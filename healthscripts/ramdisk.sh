#!/bin/bash

# Load the new logger script
source /home/saad/git/personal/gensosekai/logger/logger.sh

# Set the custom log file for this ramdisk script
export CUSTOM_LOG_FILE="/opt/gensosekai/log/ramdisk.log"

# Function to check ramdisk space and log the result
check_ramdisk_space() {
    local mount_point="/mnt/ramdisk/"

    # Perform the ramdisk space check and log the result
    df "$mount_point" -h | awk -v mount="$mount_point" 'NR>1 {
        if (NF == 6) {
            print "Ramdisk space check for " mount ": Used: " $3 " Available: " $4
        } else if (NF == 5) {
            print "Ramdisk space check for " mount ": Used: " $2 " Available: " $3
        }
    }' | while read -r log_entry; do
        log_message "INFO" "$log_entry"
    done
}

# Perform ramdisk space check
check_ramdisk_space
