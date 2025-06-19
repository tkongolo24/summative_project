#!/bin/bash  
echo "Welcome, please enter your name: "
read name
echo "Creating necessary files"
echo "This is your submission_reminder_$name"

while [[ -z "$name" ]]; do
    echo "Please enter a valid name"
    read -p "Enter your name: " name
done

if [ -d "submission_reminder_$name" ]; then
    cd submission_reminder_$name
else
    mkdir submission_reminder_$name
    cd submission_reminder_$name
fi

# Create startup.sh manually 
cat << 'EOF' > "startup.sh"
#!/bin/bash
# Launch the submission reminder app
./app/reminder.sh
EOF

if [ ! -d "app" ]; then
    mkdir app
    cat << 'EOF' > app/reminder.sh 
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
    chmod +x app/reminder.sh
fi

if [ ! -d "modules" ]; then
    mkdir modules
    cat << 'EOF' > modules/functions.sh 
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"
    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
    chmod +x modules/functions.sh
fi

if [ ! -d "assets" ]; then
    mkdir assets
    cat << 'EOF' > assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
David,
Samantha,
Aseye,
Menes,
Grace,
Ayo,
EOF
fi

if [ ! -d "config" ]; then
    mkdir config
    cat << 'EOF' > config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
fi

if [ ! -f "startup.sh" ]; then
    touch startup.sh
fi
chmod +x startup.sh 
