#!/bin/bash

echo "Path to home directory is: $HOME"
echo "Terminal Type: $TERM"
echo "The Run level 3 processes are: "
echo `ls /etc/rc3.d/S*`
