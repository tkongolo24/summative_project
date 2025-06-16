#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prompt for assignment
read -p "Enter new assignment name: " new_assignment

# Update the ASSIGNMENT line using absolute path
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$SCRIPT_DIR/config/config.env"

# Run the startup script from the same directory
"$SCRIPT_DIR/startup.sh"

