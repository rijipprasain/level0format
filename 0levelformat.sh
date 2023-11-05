#!/bin/bash
if ! command -v hdparm &> /dev/null
then
    echo "We need hdparm to run this script"
    read -p "Do you want to install hdparm? [y/N] " install
    if [[ $install == [yY] || $install == [yY][eE][sS] ]]
    then
        sudo apt-get update
        sudo apt-get install hdparm
    else
        echo "hdparm is required for this script to run. Exiting."
        exit 1
    fi
fi
echo "Listing all disk devices:"
lsblk -d -o name,size,type | grep 'disk'
read -p "Enter the device name (e.g., sda , no need to use sda1/2 , just sda or sdb or sdc): " devicename
serial=$(sudo hdparm -I /dev/$devicename | grep 'Serial Number')
echo "The serial number of /dev/$devicename is: $serial"
read -p "Are you sure you want to perform a low-level format on /dev/$devicename? [y/N] " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
    echo "Starting low-level format of /dev/$devicename"
    sudo dd if=/dev/zero of=/dev/$devicename bs=4096 status=progress
    echo "Low-level format is completed"
else
    echo "Operation cancelled"
fi
