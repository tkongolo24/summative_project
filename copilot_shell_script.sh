#!/bin/bash

# Ask for the user's name to find their project folder
read -p "Enter your name (used during setup): " name

# Define project directory and related paths
dir="submission_reminder_$name"
config="$dir/config/config.env"
startup_script="$dir/startup.sh"

# Ask for the new assignment name
read -p "Enter the new assignment name: " new_assignment

# Validate project directory
if [[ ! -d "$dir" ]]; then
    echo "Error: Project folder '$dir' does not exist."
    exit 1
fi

# Ensure config file exists
if [[ ! -f "$config" ]]; then
    echo "Error: Configuration file not found at '$config'."
    exit 1
fi

# Update assignment in config file
if sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config"; then
    echo "Successfully updated ASSIGNMENT to \"$new_assignment\" in $config"
else
    echo "Failed to update the assignment."
    exit 1
fi

# Run startup script to show reminders
if [[ -x "$startup_script" ]]; then
    echo "Launching reminder system..."
    (cd "$dir" && ./startup.sh)
else
    echo "Error: '$startup_script' is missing or not executable."
    exit 1
fi

