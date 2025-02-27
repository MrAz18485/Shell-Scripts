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
		numitersize=${#numiter}
		if [ ${numiter:0:$((numitersize-2))}=='^[1-9]+$' ]
		then
			read -p "Enter interval (Xs, Xm, Xh): " interval
			intervalsize=${#interval}
			if [[ ( ${interval:0:$((intervalsize-2))}=~'^[1-9]+$' ) && ( ${interval:$((intervalsize-1)):$((intervalsize-1))}=='s' || ${interval:$((intervalsize-1)):$((intervalsize-1))}=='m' || ${interval:$((intervalsize-1)):$((intervalsize-1))}=='h' ) ]]; then
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
