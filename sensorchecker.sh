#!/bin/bash
function writefunc {
	for i in `seq 1 "$1"`;
	do
		sensors >> "$0"
		echo "Wrote to file [$i/5]"
		if [ "$i" -ne "$1" ]
		then
			sleep "$interval"
		else
			echo "Finished writing!"
			exit 0
		fi
	done
}
		
read -p "Enter path(directory) that the data will be saved on: " filepath
if [ -d "$filepath" ]
then
	read -p "Enter filename that the data will be saved on: " filename
	if [ ! -e "$filepath/$filename" ]
	then
		read -p "Enter number of times to run the sensors: " numiter
		if [ numiter > 0 ]
		then
			read -p "Enter interval (Xs, Xm, Xh): " interval
			if [ [ "${interval:1:1}" == 's' ] || [ "${interval:1:1}" == 'm' ] || [ "${interval:1:1}" == 'h' ] ]; then
				writefunc "$filepath/$filename" "$numiter" "$interval"
			else
				echo "Incorrect interval, aborting"
				exit
			fi
		else
			echo "Incorrect iteration count, aborting"
			exit
		fi
	else
		echo "File already exists, aborting"
		exit
	fi
else
	echo "Incorrect path, aborting"	
fi
