#!/bin/bash
if lsblk | grep -q 'sda1'
then
    /home/leapfrog/Script/run_script.sh
fi
