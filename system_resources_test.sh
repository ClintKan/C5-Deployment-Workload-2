#!/bin/bash

#This is a script that checks how much of the system resources have been used
#Resources include; Memory, Disk space, CPU Utilization.


# Get used storage percentage (without the % symbol)
used_storage=$(df -h --total | awk 'END{print $5}' | sed 's/%//')

# Get total and used memory in MB
total_memory=$(free -m | awk 'NR==2{print $2}')
used_memory=$(free -m | awk 'NR==2{print $3}')

# Calculate used memory %age
used_memory_percentage=$((100 * $used_memory / $total_memory))

# Check if used memory is above 70%
if [ $used_memory_percentage -ge 70 ]; then
    # Check if used storage is above 70%
    if [ $used_storage -ge 70 ]; then
        echo "Memory is above 70%"
        echo "Storage used is above 70%"
        exit 1
    else
        echo "Memory is above 70%"
        echo "Storage used is below 70%"
        exit 1
    fi
else
    # Memory is below 70%
    if [ $used_storage -ge 70 ]; then
        echo "Memory is below 70%"
        echo "Storage used is above 70%"
        exit 1
    else
        echo "Memory is below 70%"
        echo "Storage used is below 70%"
        exit 0
    fi
fi


#CHECKING ON CPU UTILIZATION
# This will be based off memory usage.
