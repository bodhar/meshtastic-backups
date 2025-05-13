#!/usr/bin/env bash

# Backup the Meshtastic configuration to a file in the current directory
# Requires the Meshtastic CLI to be installed and in the PATH
# See README.md

# Usage: ./backup-config-ip.sh [backup_name]
# Example: ./backup-config-ip.sh my_backup
# The backup name is optional; if not provided, it will be derived from the device name in the configuration.

# Check if the Meshtastic CLI is installed/sourced
if ! command -v meshtastic &>/dev/null; then
  echo "Meshtastic CLI cannot be found, see README for instructions."
  exit 1
fi

# Check if an argument (backup name) was provided
if [ -n "$1" ]; then
  backup_name="$1"
fi

temp_file=$(mktemp)
backup_directory="$(pwd)/meshtastic-backups"

if meshtastic --export-config > "$temp_file"; then
    mkdir -p "$backup_directory"
    # Get the owner name from the config
    device_name=$(grep -w "owner:" "$temp_file" | awk '{print $2}')
    if [ -z "$device_name" ]; then
        echo "No owner name found in the configuration, exiting to allow manual review."
        echo "Run `meshtastic --export-config` to check the configuration."
        rm "$temp_file"
        exit 1
    fi
    if [ -z "$backup_name" ]; then
    backup_name="$device_name"
    fi
    # Set the backup file name to include date and owner or backup name
    d=$(date +%Y-%m-%d-%H-%M)
    backup_file="$backup_directory/config-$backup_name-$d.yaml"
    mv "$temp_file" "$backup_file"
    echo "Backup successful -> $backup_file"
else
    echo "Meshtastic CLI failed with code $?"
    rm "$temp_file"
    exit 1
fi