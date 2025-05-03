#!/usr/bin/bash

echo "Checking config.txt file.."
config_dir="$(dirname $PWD)/startup_manager/config.txt"


if [ -e "$config_dir" ]; 
then
	echo "Config found! Executing.."
	while read -r line  
	do
		if [[ ! "$line" =~ "#" ]] && [ ! -z "$line" ];
		then
			eval "$line"
			echo "Executed $line"
		fi
	done < "$config_dir"
else
	echo "Failed to locate config file! Leaving.."
	exit 1
fi
