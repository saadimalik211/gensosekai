#!/bin/bash

# Source the media functions
source ./media_functions.sh

# Define the root directory for media and remainder
MEDIA_ROOT="/mnt/raid5/DockerVolumes/PhotoprismOriginals"
REMAINDER_ROOT="/mnt/raid5/DockerVolumes/PhotoprismOriginals"

# Define the directories to search in
SEARCH_DIRS="/mnt/raid5/DockerVolumes/TESTING/PhotoprismOriginalsTesting/PhotoprismOriginals"

# Temporary files to hold counts
media_count_file=$(mktemp)
remainder_count_file=$(mktemp)

# Initialize counts
echo 0 > "$media_count_file"
echo 0 > "$remainder_count_file"

# Find all photo and video files and process them
find "$SEARCH_DIRS" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.mp4" -o -iname "*.mov" \) -print0 | while IFS= read -r -d '' file; do
    # Process file for media (photos and videos combined)
        process_file "$file" "$MEDIA_ROOT" "$REMAINDER_ROOT" "$media_count_file"
      done

      # Output the summary
      echo "Organization Summary:"
      echo "Media files organized: $(cat "$media_count_file")"
      echo "Files moved to remainder: $(cat "$remainder_count_file")"

      # Clean up temporary files
      rm "$media_count_file"
      rm "$remainder_count_file"
