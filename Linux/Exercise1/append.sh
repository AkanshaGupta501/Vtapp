#!/bin/bash
#This program appends http:// in front of given web addresses

current_directory=$(dirname $0)
sed  s/\ www\./http:\\/\\/www\./g ./$current_directory/company_name > ./$current_directory/new_company_name
cat ./$current_directory/new_company_name
