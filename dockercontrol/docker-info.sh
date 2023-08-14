#!/bin/bash

echo "Containers and Volumes:"

# Iterate over all container names and statuses sorted alphabetically
docker ps -a --format '{{.Names}} {{.Status}}' | sort | while read -r container_info; do
  container_name=$(echo "$container_info" | awk '{print $1}')
  container_status=$(echo "$container_info" | cut -d ' ' -f2-)

  # Check if the container is active
  if [[ $container_status == "Up"* ]]; then
    active_status="Active"
  else
    active_status="Not Active"
  fi

  echo "Container: $container_name | Status: $active_status"

  # Get the volumes associated with the container and sort them
  container_volumes=$(docker container inspect --format '{{ range .Mounts }}{{ .Name }} {{ end }}' "$container_name" | tr ' ' '\n' | sort)

  if [ -n "$container_volumes" ]; then
    # If there are volumes, iterate over them and print their names
    echo "$container_volumes" | while read -r volume_name; do
      if [ -n "$volume_name" ]; then
        echo "  Volume: $volume_name"
      fi
    done
  else
    # If no volumes are associated with the container, print a message
    echo "  No Volumes"
  fi

  echo ""
done

echo "Volumes Not In Use:"
# List all volumes, and filter out those that are not associated with any container
docker volume ls --format '{{.Name}}' | sort | while read -r volume_name; do
  if ! docker ps -a --filter volume="$volume_name" --format '{{.Names}}' | grep -q .; then
    echo "  $volume_name"
  fi
done

