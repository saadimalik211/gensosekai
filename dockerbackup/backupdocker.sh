#!/bin/bash

# Load configuration from the YAML file
CONFIG_FILE="backup-config.yml"
BACKUP_DIR=$(yq e '.backup_directory' "$CONFIG_FILE")
SOURCE_DIR=$(yq e '.source_directory' "$CONFIG_FILE")

# Function to perform rsync
do_rsync() {
  rsync -avh --delete "${SOURCE_DIR}/$1/" "${BACKUP_DIR}/$1/" || exit 1
}

# Function to stop and start containers
manage_containers() {
  local action=$1
  shift
  for container in "$@"; do
    echo "${action^} container: $container"
    docker "$action" "$container" || exit 1
  done
}

# Read the containers from the YAML file and backup each container's volumes
yq e '.containers[]' "$CONFIG_FILE" -o json | jq -c '.' | while read -r container; do
  container_name=$(echo "$container" | jq -r '.name')
  dependencies=$(echo "$container" | jq -r '.dependencies | join(" ")')
  volumes=$(echo "$container" | jq -r '.volumes[]')

  # Stop the container and its dependencies
  manage_containers stop $container_name $dependencies

  # Backup volumes for the container
  for volume in $volumes; do
    echo "Backing up volume: $volume"
    do_rsync "$volume"
  done

  # Start the container and its dependencies
  manage_containers start $dependencies $container_name
done


# Add logging and notification as required
echo $(date "+%D - %T") --- Docker backup successfully completed. >> /opt/logs/backupdocker.log


