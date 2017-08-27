#!/bin/bash
#This program changes version of data from 1.0 to 2.0 recursively

current_directory=$(dirname $0)
modified_path=$current_directory/project/abc/2.0
mkdir $modified_path
cp -r  $current_directory/project/abc/1.0/* $modified_path
sed -i '0,/Version:1.0/s/Version:1.0/Version:2.0/' $modified_path/code/*
