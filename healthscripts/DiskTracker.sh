#!/bin/bash

# Load the new logger script
source /home/saad/git/personal/gensosekai/logger/logger.sh

# Define the single log file path
export CUSTOM_LOG_FILE="/opt/gensosekai/log/disktracker.log"

# Function to check disk space and log the result
check_disk_space() {
    local mount_point=$1
    local dt=$(date '+%Y-%m-%d %H:%M:%S')

    # Perform the disk space check and log the result
    df "$mount_point" -h | awk -v mount="$mount_point" 'NR>1 {
        if (NF == 6) {
            print "Disk space check for " mount ": Used: " $3 " Available: " $4
        } else if (NF == 5) {
            print "Disk space check for " mount ": Used: " $2 " Available: " $3
        }
    }' | while read -r log_entry; do
        log_message "INFO" "$log_entry"
    done
}

# Perform disk space checks for each mount point
check_disk_space "/mnt/raid5/"
check_disk_space "/mnt/backup/"
check_disk_space "/dev/sda6"

# Log completion
log_message "INFO" "Disk space checks completed."
