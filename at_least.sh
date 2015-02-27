#!/bin/bash
MIN=$1

if [ -z "$MIN" ]
then
	MIN=0
fi

while read line
do
	VF=$(echo $line | cut -f2 -d,)

	if (( $(bc <<< "$VF >= $MIN") == 1 ))
	then
		echo $line
	fi
done 
