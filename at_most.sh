#!/bin/bash
MAX=$1

if [ -z "$MAX" ]
then
	MAX=1
fi

while read line
do
	VF=$(echo $line | cut -f2 -d,)

	if (( $(bc <<< "$VF <= $MAX") == 1 ))
	then
		echo $line
	fi
done 
