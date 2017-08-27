#!/bin/bash
#searching users with email domain @yahoo.com

current_directory=$(dirname $0)
echo "Users with email domain as @yahoo.com"
echo "Matches Found :" 
grep -c "@yahoo.com" $current_directory/subscribers.txt
echo "User Name <----> Domain Address <----> City <----> Contact Number"
grep "@yahoo.com" $current_directory/subscribers.txt > $current_directory/yahoo.txt
cat $current_directory/yahoo.txt
