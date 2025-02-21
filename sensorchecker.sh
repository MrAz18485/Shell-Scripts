#!/bin/bash
function writefunc {
	for i in `seq 1 $2`;
	do
		printf "[$i/$2]\n\n" >> $1
		sensors >> $1 
		echo "Wrote to file [$i/$2]"
		if [ $i -ne $2 ]
		then
			sleep "$interval"
		else
			echo "Finished writing!"
			exit 0
		fi
	done
}
		
read -p "Enter path(directory) that the data will be saved on: " filepath
if [ -d $filepath ]
then
	read -p "Enter filename that the data will be saved on: " filename
	if [ ! -e "$filepath/$filename" ]
	then
		read -p "Enter number of times to run the sensors: " numiter
		if [ $numiter -gt 0 ]
		then
			read -p "Enter interval (Xs, Xm, Xh): " interval
			if [ [ ${interval:0:0} != '^[0-9]+$' ] && [ [ ${interval:1:1} == 's' ] || [ ${interval:1:1} == 'm' ] || [ ${interval:1:1} == 'h' ] ] ]; then
				writefunc "$filepath/$filename" "$numiter" "$interval"
			else
				echo "Incorrect interval, aborting"
				exit 5
			fi
		else
			echo "Incorrect iteration count, aborting"
			exit 4
		fi
	else
		echo "File already exists, aborting"
		exit 3
	fi
else
	echo "Incorrect path, aborting"
	exit 2	
fi
