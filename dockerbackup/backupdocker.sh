#!/bin/bash

# Load the new logger script
source /home/saad/git/personal/gensosekai/logger/logger.sh

# Set and export the custom log file for this backup script
export CUSTOM_LOG_FILE="/opt/gensosekai/log/backupdocker.log"

# Load configuration from the YAML file
CONFIG_FILE="/home/saad/git/personal/gensosekai/dockerbackup/backup-config.yml"
BACKUP_DIR=$(yq e '.backup_directory' "$CONFIG_FILE")
SOURCE_DIR=$(yq e '.source_directory' "$CONFIG_FILE")

# Source the functions from the separate file
source /home/saad/git/personal/gensosekai/dockerbackup/backup_functions.sh

# Log the start time of the entire script
log_message "INFO" "Backup script started."

# Read the containers from the YAML file and backup each container's volumes
yq e '.containers[]' "$CONFIG_FILE" -o json | jq -c '.' | while read -r container; do
  container_name=$(echo "$container" | jq -r '.name')
  dependencies=$(echo "$container" | jq -r '.dependencies | join(" ")')
  volumes=$(echo "$container" | jq -r '.volumes[]')

  # Stop the container and its dependencies
  manage_containers stop $container_name $dependencies

  # Backup volumes for the container
  for volume in $volumes; do
    do_rsync "$volume"
  done

  # Start the container and its dependencies
  manage_containers start $dependencies $container_name
done

# Log the end time of the entire script
log_message "INFO" "Backup script completed."
