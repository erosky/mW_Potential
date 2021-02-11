#!/usr/bin/python

# USE: python validate_water.py DATA_FILE OUTPUT_FILE

import sys
from scipy import *
from scipy.optimize import curve_fit
import numpy as np


# Unit conversion function
atoms = 4096
mass_atom = 18.015/(6.02214*(10**23))
timestep = 5
def real2SI(metric, value):
	converted = 0
	# Convert from number density to g/cm^3
	if (metric == "density"):
		converted = (value * mass_atom / (10**-8)**3)
	# Convert from A^2 to cm^2
	if (metric == "msd"):
		converted = (value * (10**-8)**2)
	# Convert from timestep (femptoseconds) to seconds
	if (metric == "time"):
		converted = (value * timestep * (10**-15))
	return converted


# Get input and output file names from command line input arguments
datafile = sys.argv[1]
outputfile = sys.argv[2]

print(datafile)

# Load Data from input file
output = open(outputfile,'w')

data = loadtxt(datafile)

# Ryan Eq
step, temp, pressure, volume, etotal, ke, pe, msd = transpose(data)

# nvt Eq
#step, temp, ke, pe, pressure, msd = transpose(data)

# Get instantaneous number density at each timestep
density = []
for v in volume:
	density.append(real2SI("density", (atoms/v)))


# Calculate Averages
temp_avg = sum(temp)/len(temp)
pressure_avg = sum(pressure)/len(pressure)
density_avg = sum(density)/len(density)


# Calculate Standard Dev
def std_dev(data_list, avg):
	stdd_sum = 0
	for n in data_list:
		stdd_sum = stdd_sum + (n - avg)**2
	stdd = (stdd_sum/len(data_list))**(0.5)
	return stdd

temp_std = std_dev(temp, temp_avg)
pressure_std = std_dev(pressure, pressure_avg)
density_std = std_dev(density, density_avg)



# Compare with expected values and print output
print ("Temperature: ", temp_avg , ", " , temp_std)
print ("Pressure: ", pressure_avg , ", " , pressure_std)
print ("Density: ", density_avg, ", " , density_std)



# Do a linear fit of msd with respect to time
def linear_func(x, D, C):
	return D*x + C


msd_SI = []
time = []
for d in msd:
	msd_SI.append(real2SI("msd", d))
for s in step:
	time.append(real2SI("time", s))
	


params, params_covar = curve_fit(linear_func, time, msd_SI)
perr = np.sqrt(np.diag(params_covar))
print (params)
print (perr)



pyplot.plot(time, msd_SI)
show()




