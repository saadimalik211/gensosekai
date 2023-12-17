#!/bin/bash

# Source the media functions
source ./media_functions.sh

# Define the root directories for photos, videos, and remainder
PHOTO_ROOT="/mnt/raid5/DockerVolumes/TESTING/Output/Photos"
VIDEO_ROOT="/mnt/raid5/DockerVolumes/TESTING/Output/Videos"
REMAINDER_ROOT="/mnt/raid5/DockerVolumes/TESTING/Output/Remainder"

# Define the directories to search in
SEARCH_DIRS="/mnt/raid5/DockerVolumes/TESTING/Phone"

# Temporary files to hold counts
photo_count_file=$(mktemp)
video_count_file=$(mktemp)
remainder_count_file=$(mktemp)

# Initialize counts
echo 0 > "$photo_count_file"
echo 0 > "$video_count_file"
echo 0 > "$remainder_count_file"

# Find all photo and video files and process them
find "$SEARCH_DIRS" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.mp4" -o -iname "*.mov" \) -print0 | while IFS= read -r -d '' file; do
    # Determine if it's a photo or a video
    if [[ $file =~ \.(jpg|jpeg|png)$ ]]; then
        process_file "$file" "$PHOTO_ROOT" "$REMAINDER_ROOT" "$photo_count_file"
    elif [[ $file =~ \.(mp4|mov)$ ]]; then
        process_file "$file" "$VIDEO_ROOT" "$REMAINDER_ROOT" "$video_count_file"
    else
        # Move file to remainder if it's neither photo nor video and echo the action
        mkdir -p "$REMAINDER_ROOT"
        mv "$file" "$REMAINDER_ROOT/"
        echo "Moved to remainder: $file -> $REMAINDER_ROOT/"
        echo $(( $(cat "$remainder_count_file") + 1 )) > "$remainder_count_file"
    fi
done

# Output the summary
echo "Organization Summary:"
echo "Photos organized: $(cat "$photo_count_file")"
echo "Videos organized: $(cat "$video_count_file")"
echo "Files moved to remainder: $(cat "$remainder_count_file")"

# Clean up temporary files
rm "$photo_count_file"
rm "$video_count_file"
rm "$remainder_count_file"
