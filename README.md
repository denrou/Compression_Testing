# Format datas issued from _Instron 5585 H_ compression testing

## File structure

The _Instron 5585 H_ is a test machine to anaylze mechanical properties of a sample. Compression testing are performed on ceramics to obtain the Young Modulus of our sample. The software, _Instron_ records datas on a csv file as follow:

	head output_compression_test.csv
	
	

## Transformations

The stress is defined as the force applied on the sample divided by the surface where the foce is applied on (stress = Force/Surface).
The strain is defined as the elongation divided by the size of the sample (strain = elongation/size)

### get_stress_strain

#### get_stress_strain.awk

INPUT:	csv file produced by _Instron_ software, height and surface of the sample
OUTPUT:	strain and stress

#### get_stress_strain.sh

INPUT:	text file containing the name of several csv files, their respective height and surface
OUTPUT:
* STDOUTPUT: error messages (missing csv files, incorrect height or surface)
* create a "Results" folder and run **get_stress_strain.awk** on each csv files

#### get_young_modulus

To get the Young Modulus (mechanical property) for our sample we apply cycles of loading/unloadings force. The Young Modulus is determined by calculating the slope on each unloading part. The script analyse a 2 curve (2 column table), which in our case is a strain/stress file, detect all unloading parts (decreasing strain) and determine the slope for each of them.

### get_young_modulus.py

INPUT:	csv file named **stress_strain** containing at least one column (only the first column is analyzed). The first row is not taken into account
OUTPUT:	slope for each decreasing part of the 1st column (minimum of five conscutive points) with the first point where it started

### get_young_modulus.sh

INPUT:	list of file to analyse
OUTPUT:	list of file with suffix **_youg_modulus** containing results of **get_young_modulus.py**
