#!/bin/bash

# Source the logger script
source "/home/saad/git/personal/gensosekai/logger/logger.sh"

# Set a custom log file for this script
CUSTOM_LOG_FILE="/opt/gensosekai/log/s3_sync.log"

# Load configuration from YAML file
CONFIG_FILE="/home/saad/git/personal/gensosekai/photoprismbackup/pp_s3_backup-config.yaml"

if [ ! -f "$CONFIG_FILE" ]; then
    log_message "ERROR" "Configuration file $CONFIG_FILE does not exist."
    exit 1
fi

# Use yq to parse the YAML configuration
aws_access_key_id=$(yq e '.aws.access_key_id' "$CONFIG_FILE")
aws_secret_access_key=$(yq e '.aws.secret_access_key' "$CONFIG_FILE")
aws_s3_bucket=$(yq e '.aws.s3_bucket' "$CONFIG_FILE")
aws_region=$(yq e '.aws.region' "$CONFIG_FILE")
local_backup_directory=$(yq e '.local_backup_directory' "$CONFIG_FILE")

# Export the AWS credentials and region as environment variables
#export AWS_ACCESS_KEY_ID="$aws_access_key_id"
#export AWS_SECRET_ACCESS_KEY="$aws_secret_access_key"
#export AWS_REGION="$aws_region"

# Log the start of the sync process
log_message "INFO" "Starting sync of $local_backup_directory to s3://$aws_s3_bucket/"

# Sync the local backup directory to the S3 bucket using the provided AWS credentials
AWS_ACCESS_KEY_ID="$aws_access_key_id" AWS_SECRET_ACCESS_KEY="$aws_secret_access_key" aws s3 sync "$local_backup_directory" "s3://$aws_s3_bucket/" --region "$aws_region" --no-progress

# Check if the sync was successful
if [ $? -eq 0 ]; then
    log_message "INFO" "Sync completed successfully."
else
    log_message "ERROR" "Sync failed."
fi

# Unset the AWS credentials and region environment variables
#unset AWS_ACCESS_KEY_ID
#unset AWS_SECRET_ACCESS_KEY
#unset AWS_REGION
