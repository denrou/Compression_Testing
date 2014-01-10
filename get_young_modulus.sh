#!/bin/bash

if [ $# -lt 1 ]; then
	echo "You need at least one file"
fi

for i in $*
do
	cp $i stress_strain
	name=$(echo $i | cut -d . -f 1)
	python ~/Documents/These/Bin/Compression_Testing/get_young_modulus.py > ${name}_young_modulus.csv
	rm stress_strain
done
