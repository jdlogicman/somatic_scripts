#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ALL_EXPECTED="$(awk '{printf "%s|", $1}' $DIR/expected_allele_freq.txt)DUMMY"

filter_out_expected()
{
	while read line
	do
		chrpart=$(echo $line | cut -f1 -d,)
		if ! [[ $chrpart =~ $ALL_EXPECTED ]]
		then
			echo $line
		fi

	done

}
