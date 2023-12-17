#!/bin/bash

# Define the log file
LOG_FILE="/opt/logs/backupdocker.log"

# Function to log a message with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to perform rsync
do_rsync() {
  log_message "Starting backup of volume: $1"
  rsync -avh --delete "${SOURCE_DIR}/$1/" "${BACKUP_DIR}/$1/" || exit 1
  log_message "Backup of volume $1 completed."
}

# Function to stop and start containers
manage_containers() {
  local action=$1
  shift
  log_message "${action^} containers: $@"
  for container in "$@"; do
    log_message "${action^} container: $container"
    docker "$action" "$container" || exit 1
  done
  log_message "Containers ${action^}ed."
}
