#!/bin/bash

# Load configuration from the YAML file
CONFIG_FILE="backup-config.yml"
BACKUP_DIR=$(yq e '.backup_directory' "$CONFIG_FILE")
SOURCE_DIR=$(yq e '.source_directory' "$CONFIG_FILE")

# Source the functions from the separate file
source backup_functions.sh

# Log the start time of the entire script
log_message "Backup script started."

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
log_message "Backup script completed."
