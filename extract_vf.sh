#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm vf_rep*.csv
for rep in $(ls *NA12878*.vcf | cut -f2 -d_ | cut -f1 -d.)
do
	$DIR/show_vf.sh *NA12878*$rep*.vcf $1 | $DIR/at_most.sh 0.30 | $DIR/at_least.sh 0.01 > vf_rep$rep.csv
done
