#!/bin/bash
#select users from Chennai and copy to new file

current_directory=$(dirname $0)
echo "Users information who stay in Chennai"
echo "Matches Found :"
grep -c "Chennai" $current_directory/subscribers.txt
echo "User Name <----> Domain Address <----> City <----> Contact Number"
grep "Chennai" $current_directory/subscribers.txt > $current_directory/chennai.txt
cat $current_directory/chennai.txt
