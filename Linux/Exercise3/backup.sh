#!/bin/bash 
#This program backsup data with timestammp

current_directory=$(dirname $0)
date=`date +%d_%m_%y_%H%M`
backup_folder="backup_$date.tar.gz"
tar -cvzf $current_directory/$backup_folder $current_directory/data/*
