#!/bin/bash

# Default log file
DEFAULT_LOG_FILE="/opt/gensosekai/log/default.log"

# Log levels
declare -A LOG_LEVELS=(
    [DEBUG]=0
    [INFO]=1
    [WARNING]=2
    [ERROR]=3
)

# Default log level
DEFAULT_LOG_LEVEL="INFO"

# In logger.sh
if [ -z "$CUSTOM_LOG_FILE" ]; then
    CUSTOM_LOG_FILE="/opt/gensosekai/log/default.log"
fi


# Function to log a message with timestamp and log level
log_message() {
    local level=$1
    local message=$2
    local log_file=${CUSTOM_LOG_FILE:-$DEFAULT_LOG_FILE} # Use CUSTOM_LOG_FILE if set, otherwise default
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_level=${LOG_LEVELS[$level]}

    # Check if the level exists in LOG_LEVELS
    if [[ -z "$log_level" ]]; then
        echo "Unknown log level: $level"
        exit 1
    fi

    # Check if the current log level is greater or equal to the level of the message
    if [[ $log_level -ge ${LOG_LEVELS[$DEFAULT_LOG_LEVEL]} ]]; then
        # Ensure the log directory exists
        mkdir -p "$(dirname "$log_file")"

        # Write the log entry
        echo "$timestamp - $level - $message" >> "$log_file"
    fi
}

# Example of setting the custom log file at the beginning of a script
# CUSTOM_LOG_FILE="/opt/gensosekai/log/custom_script.log"

# Usage examples:
# log_message "INFO" "This is an informational message."
# log_message "ERROR" "This is an error message."
