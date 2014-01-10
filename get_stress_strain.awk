#!/usr/bin/awk -f

# ------------------------------------------------------------------------------
#	Author:			Denis Roussel
#	Date:			15/11/2013
#	Description:	Get stress/strain from file with force/elongation
#	Usage:			./script -v height=[HEIGHT] -v surface=[SURFACE] file.csv [> redirection]
# ------------------------------------------------------------------------------

BEGIN{
	OFS=","
	FS=","
	if ( height == "" || surface == "" ) {
		print "./script -v height=[HEIGHT] -v surface=[SURFACE] file.csv [> redirection]"
		exit
	}
}

NR==1{
	print FILENAME,""
#	print "Height (mm)", height
#	print "Surface (mm²)", surface
#	print ""
	print "Strain", "Stress (MPa)"
}

NR>4{
	if ( NR == 5 ) gauge = $2
	printf("%6f,%6f\n",($2-gauge)/height, $3/surface)
}
