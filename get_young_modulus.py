#!/bin/python

import csv
from scipy import stats

fname = "stress_strain"
file = open(fname, "rb")
stress = []; strain = []

try:
	reader = csv.reader(file)
	try:
		for i in range(5):
			reader.next();
	except:
		print "Please verify the file " + fname
		quit()
	for row in reader:
		if row[1]:
			strain.append(float(row[0]))
			stress.append(float(row[1]))
finally:
	file.close()

previous_value = 0
start_decreasing = 0
number_of_point = 0
cycle = []
index = 0

for i in range(len(strain)):
	if strain[i] < previous_value:
		if start_decreasing == 0:
			start_decreasing = i-1
			max_value = previous_value
		number_of_point += 1
	else:
		if number_of_point > 5:
			end_decreasing = i-1
			min_value = previous_value
			range_value = max_value - min_value
			start_slope = 0; end_slope = 0;
			for j in range(start_decreasing,end_decreasing):
				if strain[j] > max_value-0.25*range_value:
					start_slope = j
				if strain[j] < min_value+0.1*range_value and end_slope == 0:
					end_slope = j
			cycle.append([start_decreasing, end_decreasing, start_slope, end_slope])
			start_decreasing = 0
		else:
			start_decreasing = 0
		number_of_point = 0
	previous_value = strain[i]
	

print ","
print "Strain,Young Modulus"
for i in range(len(cycle)):
	x = strain[cycle[i][2]:cycle[i][3]]
	y = stress[cycle[i][2]:cycle[i][3]]
	slope, intercept, r_value, p_value, std_err = stats.linregress(x,y)
	print "%6f,%6f" % (strain[cycle[i][0]], slope)
