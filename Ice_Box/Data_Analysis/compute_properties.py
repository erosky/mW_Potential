#!/usr/bin/python

# USE: python compute_properties.py DATA_FILE OUTPUT_FILE

import sys
from scipy import *
from scipy.optimize import curve_fit
import numpy as np
import matplotlib.pyplot as plt


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
data = np.loadtxt(datafile)

# Set properties
raw_vars = ["step", "temp", "pressure", "volume", "etotal", "ke", "pe", "msd"]
compute_vars = ["temp", "pressure", "density", "msd", "mass_density"]

# Input Data Columns ----MAKE SURE THESE MATCH THE INPUT DATA FILE----
step, temp, pressure, volume, etotal, ke, pe, msd = np.transpose(data)

# nvt Eq
#step, temp, ke, pe, pressure, msd = transpose(data)



# Get instantaneous number density at each timestep
if "density" in compute_vars:
	density = []
	for v in volume:
		density.append(atoms/v)

# Get instantaneous mass density at each timestep
manual_mass_density = []
for v in volume:
	manual_mass_density.append(real2SI("density", (atoms/v)))

# Calculate Standard Dev
def std_dev(data_list, avg):
	stdd_sum = 0
	for n in data_list:
		stdd_sum = stdd_sum + (n - avg)**2
	stdd = (stdd_sum/len(data_list))**(0.5)
	return stdd


# Calculate Averages, Std Dev, and print output
if "temp" in compute_vars:
	temp_avg = np.sum(temp)/len(temp)
	temp_std = std_dev(temp, temp_avg)
	print ("Temperature: ", temp_avg , ", " , temp_std)
	output.write("\nTemperature (K): " + str(temp_avg) + ", " + str(temp_std))
if "pressure" in compute_vars:
	pressure_avg = np.sum(pressure)/len(pressure)
	pressure_std = std_dev(pressure, pressure_avg)
	print ("Pressure: ", pressure_avg , ", " , pressure_std)
	output.write("\nPressure (atm): "+ str(pressure_avg) + ", " + str(pressure_std))
if "density" in compute_vars:
	density_avg = np.sum(density)/len(density)
	density_std = std_dev(density, density_avg)
	print ("Density: ", density_avg, ", " , density_std)
	output.write("\nDensity (N/A^3): "+ str(density_avg) + ", " + str(density_std))
if "mass_density" in compute_vars:
	m_density_avg = np.sum(manual_mass_density)/len(manual_mass_density)
	m_density_std = std_dev(manual_mass_density, m_density_avg)
	print ("Manual Mass density: ", m_density_avg, ", " , m_density_std)
	output.write("\nManual Mass density (g/cm^3): "+ str(m_density_avg) + ", " + str(m_density_std))


# Do a linear fit of msd with respect to time
if "msd" in compute_vars:
	def linear_func(x, D, C):
		return D*x + C
	
	msd_SI = []
	time = []
	for d in msd:
		msd_SI.append(real2SI("msd", d))
	for s in step:
		time.append(s * (10**-9))
	
	params, params_covar = curve_fit(linear_func, time, msd_SI)
	perr = np.sqrt(np.diag(params_covar))
	print ("Slope of MSD: ", params[0], perr[0])
	output.write("\nSlope of MSD (cm^2/s)): "+ str(params[0]) + ", " + str(perr[0]))
	
	plt.plot(time, msd_SI)
	plt.show()

