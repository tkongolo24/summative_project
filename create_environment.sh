#!/bin/bash  
echo "Welcome,"
read name 
echo "This is your submission_reminder_$name"

if [ -d "submission_reminder_$name" ]; then 
	cd submission_reminder_$name
else
	mkdir submission_reminder_$name
      cd submission_reminder_$name	
fi 

if [ ! -d "app" ]; then 
       	mkdir app;  
touch app/reminder.sh 
elif [ ! -d "modules" ]; then  
	mkdir  modules; 
touch modules/functions.sh
elif [ ! -d "assets" ]; then 
	mkdir assets; 
touch assets/submissions.txt
elif [ ! -d "config" ]; then 
	mkdir config ;  
touch config/config.env
if [ ! -f "startup.sh" ];then
	touch startup.sh 
fi 
