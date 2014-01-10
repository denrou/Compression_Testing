#!/bin/bash

# ------------------------------------------------------------------------------
#	Author:			Denis Roussel
#	Date:			15/11/2013
#	Description:	Get stress/strain from serie of files with force/elongation.
#					The script create a folder "Results" containing the different
#					csv files.
#	Usage:			./script input_file
# ------------------------------------------------------------------------------

FILE_INPUT=$1
SCRIPT_GET_STRESS_STRAIN=~/Documents/These/Bin/Compression_Testing/get_stress_strain.awk

if [ ! -f $"$FILE_INPUT" ]; then
	echo "You need an input file containing height and surface"
	echo "$0 FILE_INPUT"
	exit 1
fi

mkdir Results

for i in $(seq 2 $(wc -l $FILE_INPUT | cut -d " " -f 1))
do
	CSV_NAME="$(awk -v line=$i 'NR==line{print $1}' $FILE_INPUT).csv"
	HEIGHT=$(awk -v line=$i 'NR==line{print $2}' $FILE_INPUT)
	SURFACE=$(awk -v line=$i 'NR==line{print $3}' $FILE_INPUT)
	if [ -f $CSV_NAME ]; then
		sed -i -e "s/\"//g" "$CSV_NAME"
		SCRIPT_GET_STRESS_STRAIN -v height=$HEIGHT -v surface=$SURFACE $CSV_NAME > Results/$CSV_NAME
	else
		echo -e "$CSV_NAME not found"
	fi
done
