#!/bin/bash
#Random report generation for 100 users
current_directory=$(dirname $0)
cities=("Delhi" "Mumbai" "Kolkata" "Chennai")
domains=("@yahoo.com" "@gmail.com" "@hotmail.com" "@rediffmail.com")
echo "Generating details -"
echo "User Name <----> Domain Address <----> City <----> Contact Number"
for i in {0..200}
do
  city_name=${cities[$RANDOM%4]}           #generating random city names
  domain_name=${domains[$RANDOM%4]}        #generating randon domain names
  user_name=$((999999+RANDOM%1245))        #generating usernames
  phone_number=$((92113545+RANDOM%94511))  #generating randomly phone numbers
  echo "$user_name <----> $domain_name <----> $city_name <----> $phone_number" >> $current_directory/subscribers.txt
done
cat $current_directory/subscribers.txt
