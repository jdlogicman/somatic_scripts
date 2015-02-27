#!/bin/bash
INPUT="$1"
if [ -x "$INPUT" ]
then
	INPUT="sampled_allele_freq.txt"
fi
(for chrom in `cat $INPUT  | awk '{print $1}' | grep -v Rep1`; do grep $chrom expected_allele_freq.txt; done) | awk '{printf ",%s",$2} END { print ""}'
