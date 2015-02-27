#!/bin/bash
# given a VCF file, dump all above VF $2
# chr9	133747608	.	A	G	98.00	PASS	DP=462;TI=NM_007313,NM_005157;GI=ABL1,ABL1;FC=Silent,Silent	GT:GQ:AD:VF:NL:SB:GQX	0/1:98:436,24:0.0519:20:-51.6294:98
# usage: vcf_file [status regex]
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

STATUS=$2

if [ -z "$STATUS" ]
then
	STATUS=.*
fi

while read line
do
	if [[ $line =~ ^\#.* ]]; then continue; fi
	IFS='	'
	read -a fields <<< "$line"

	if [[ ${fields[6]} =~ $STATUS ]]
	then
		VF=$(echo ${fields[9]} | cut -f4 -d:)
		AD=$(echo ${fields[9]} | cut -f3 -d:)
		NUM_ALT=$(echo $AD | cut -f2 -d,)
		NUM_READS=$(( $NUM_ALT + $(echo $AD | cut -f1 -d,) ))
# output format: chrom:pos,variantfreq,REF->ALT,#reads,#alt
		echo "${fields[0]}:${fields[1]},$VF,${fields[3]}->${fields[4]},$NUM_READS,$NUM_ALT"
	fi
done < $1
