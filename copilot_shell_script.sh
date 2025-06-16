#!/bin/bash

# Ask for the user's name to find their project folder
read -p "Enter your name (used during setup): " name

# Define the target directory
dir="submission_reminder_$name"

# Check if directory exists
if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist."
    exit 1
fi

# Ask for the new assignment name
read -p "Enter the new assignment name: " new_assignment

# Update the ASSIGNMENT variable in config.env using sed
config="$dir/config/config.env"

if [[ -f "$config" ]]; then
    sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$config"
    echo "Updated ASSIGNMENT to \"$new_assignment\" in $config"
else
    echo "Error: Config file not found at $config"
    exit 1
fi

# Run the startup.sh script inside the directory
bash "$dir/startup.sh"

