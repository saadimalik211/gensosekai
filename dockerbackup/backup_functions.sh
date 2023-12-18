#!/bin/bash

# Source the new logger script
source /home/saad/git/personal/gensosekai/logger/logger.sh

# Function to perform rsync
do_rsync() {
  log_message "INFO" "Starting backup of volume: $1"
  rsync -avh --delete "${SOURCE_DIR}/$1/" "${BACKUP_DIR}/$1/" || {
    log_message "ERROR" "Rsync failed for volume: $1"
    exit 1
  }
  log_message "INFO" "Backup of volume $1 completed."
}

# Function to stop and start containers
manage_containers() {
  local action=$1
  shift
  log_message "INFO" "${action^} containers: $@"
  for container in "$@"; do
    log_message "INFO" "${action^} container: $container"
    docker "$action" "$container" || {
      log_message "ERROR" "Docker failed to ${action} container: $container"
      exit 1
    }
  done
  log_message "INFO" "Containers ${action^}ed."
}
