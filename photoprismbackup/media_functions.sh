#!/bin/bash

# Function to extract date from filename
extract_date_from_filename() {
    local filename="$1"
    local date_regexes=(
    'PXL_([0-9]{4})([0-9]{2})([0-9]{2})' # PXL_YYYYMMDD
    'Screenshot_([0-9]{4})([0-9]{2})([0-9]{2})' # Screenshot_YYYYMMDD
    'signal-([0-9]{4})-([0-9]{2})-([0-9]{2})' # signal-YYYY-MM-DD
    # Add more patterns as needed
    )
    for regex in "${date_regexes[@]}"; do
        if [[ $filename =~ $regex ]]; then
            echo "${BASH_REMATCH[1]}:${BASH_REMATCH[2]}"
            return 0
        fi
    done

    echo ""
    return 1
}

# Function to process each file
process_file() {
    local file_path="$1"
    local root_dir="$2"
    local remainder_dir="$3"
    local count_file="$4"

    # Extract the creation date from the metadata
    local creation_date=$(exiftool -d "%Y:%m" -DateTimeOriginal "$file_path" | awk -F': ' '{print $2}')

    # If exiftool could not find the date, try to extract it from the filename
    if [ -z "$creation_date" ]; then
        creation_date=$(extract_date_from_filename "$(basename "$file_path")")
    fi

    # If a date was found, organize the file
    if [ -n "$creation_date" ]; then
        # Parse the year and month
        local year=$(echo $creation_date | cut -d: -f1)
        local month=$(echo $creation_date | cut -d: -f2)

        # Create the directory structure if it does not exist
        local target_dir="$root_dir/$year/$month"
        mkdir -p "$target_dir"

        # Move the file and echo the action
        mv "$file_path" "$target_dir/"
        echo "Organized: $file_path -> $target_dir/"
        
        # Increment the count
        echo $(( $(cat "$count_file") + 1 )) > "$count_file"
    else
        # Move the file to the remainder directory if no date is found and echo the action
        mkdir -p "$remainder_dir"
        mv "$file_path" "$remainder_dir/"
        echo "Moved to remainder: $file_path -> $remainder_dir/"
        echo $(( $(cat "$count_file") + 1 )) > "$count_file"
    fi
}
