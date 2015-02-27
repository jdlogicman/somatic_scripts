#!/bin/bash
ROOT=$1

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for rep in $(seq 1 $#)
do	
	echo -n "	Rep$rep"
done
echo "	Expected"

while read line
do
	chr=$(echo $line | cut -f1 -d:)
	pos=$(echo $line | cut -f2 -d: | awk '{print $1}')
	expected_vf=$(echo $line | awk '{print $2}')
	echo -n "$chr:$pos"
	for file in $*
	do
		variant=$(grep -E "$chr\s$pos\s" $file | grep PASS | awk '{print $10}' | cut -f4 -d:)
		if [ -z "$variant" ]
		then
			variant="NA"
		fi
		echo -n "	$variant"
	done
	echo "	$expected_vf"
done < $DIR/expected_allele_freq.txt
