#!/bin/bash
function writefunc {
	for i in `seq 1 5`;
	do
		sensors >> ./sensordata/"$filename"
		echo "Wrote to file [$i/5]"
		if [ "$i" -ne 5 ]
		then
			sleep 5m
		else
			echo "Finished writing!"
			exit 0
		fi
	done
}
		
read -p "Enter filename that the data will be saved on: " filename
if [ -e ./sensordata/"$filename" ]
then
	read -p "Filename already exists, overwrite?(T/F) " choice
	if [ $choice == "T" ] || [ $choice == "t" ]
	then
		echo "Starting to write data on already existing file"
		writefunc
	else
		echo "Quitting program.."
		exit 2
	fi
else
	touch ./sensordata/"$filename"
	echo "Starting to write data on newly created file"
	writefunc
fi
