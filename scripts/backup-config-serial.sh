#!/usr/bin/env bash

# Backup the Meshtastic configuration to a file in the current directory
# Requires the Meshtastic CLI to be installed and in the PATH
# See README.md

if ! command -v meshtastic &> /dev/null; then
    echo "Meshtastic CLI cannot be found, see README for instructions."
    exit 1
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
    # Set the backup file name to include date and owner name
    d=$(date +%Y-%m-%d)
    backup_file="$backup_directory/config-$device_name-$d.yaml"
    mv "$temp_file" "$backup_file"
    echo "Backup successful -> $backup_file"
else
    echo "Meshtastic CLI failed with code $?"
    rm "$temp_file"
    exit 1
fi