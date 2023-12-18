#!/bin/bash

# Load the new logger script
source /home/saad/git/personal/gensosekai/logger/logger.sh

# Set the custom log file for this opt backup script
export CUSTOM_LOG_FILE="/opt/gensosekai/log/optbackup.log"

# Log the start of the backup
log_message "INFO" "Starting /opt backup with --delete."

# Perform the rsync operation with --delete flag
if rsync -avh --delete /opt /mnt/backup/optbackup; then
    log_message "INFO" "/opt backup completed successfully."
else
    log_message "ERROR" "/opt backup encountered errors."
    exit 1
fi
