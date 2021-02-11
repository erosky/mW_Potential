import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import curve_fit


log_file = "no_thermostat_228K_00.dat"
# liquid_file = "gofr_200k_liquid_nothermostat.dat"
# ice_file = "gofr_200k_ice_nothermostat.dat"

log = np.loadtxt(log_file)
data = np.transpose(log)


labels = ["step", "temp", "press", "vol", "etotal", "ke", "pe", "msd", "ns", "density"]
N = 4096


time_ns = []
density = []
density_si = []

def density_convert(NperA):
	# gpermol = 18.015
	# Apercm = 10**8
	# molperN = 6.02214*10**(-23)
	return NperA * 29.91531

for step in data[0]:
	time_ns.append(5.0 * step * 1/1000000)

for vol in data[3]:
	density.append(N/vol)
	density_si.append(density_convert(N/vol))

data = np.append(data, [time_ns], axis = 0)
data = np.append(data, [density], axis = 0)


init_density = sum(density[0:250000/50])/len(density[0:250000/50])
fin_density = sum(density[-len(density)/2:-1])/len(density[-len(density)/2:-1])
print init_density
print fin_density

def density_convert(NperA):
	# gpermol = 18.015
	# Apercm = 10**8
	# molperN = 6.02214*10**(-23)
	return NperA * 29.91531

print density_convert(init_density)
print density_convert(fin_density)




plt.figure(0)
plt.subplot(311)
plt.title('Density of System')
plt.ylabel('Temperature (K)')
plt.ylim(175, 300)
# plt.title(r'$\sigma_i=15$')
plt.plot(data[8], data[1], 'k-')
plt.hlines(273.15, 0, 10, colors='r', label="273.15 K")
plt.grid(True)

plt.subplot(312)
plt.ylabel('Density (g/cm^3)')
# plt.title('Histogram of IQ')
plt.plot(data[8], density_si, 'g-')
plt.grid(True)

plt.subplot(313)
plt.xlabel('Time (ns)')
plt.ylabel('Volume (A^3)')
# plt.title('Histogram of IQ')
plt.plot(data[8], data[3], 'b-')
plt.grid(True)
plt.savefig('density_228K_no_thermostat.png', bbox_inches='tight')
plt.show()


plt.figure(1)
plt.subplot(311)
plt.title('Energy of System (eV)')
plt.ylabel('Total Energy')
plt.plot(data[8], data[4], color='black')
plt.grid(True)

plt.subplot(312)
plt.ylabel('Kinetic Energy')
plt.plot(data[8], data[5], color='skyblue') 
plt.grid(True)

plt.subplot(313)
plt.xlabel('Time (ns)')
plt.ylabel('Potential Energy')
plt.plot(data[8], data[6], color='olive')
plt.grid(True)
plt.savefig('energy_228K_no_thermostat.png', bbox_inches='tight')
plt.show()


plt.figure(1)
plt.title('Enthalpy E + PV')
plt.ylabel('KE+P*V')
plt.plot(data[8], data[5]+data[3]*data[2], color='olive')
plt.grid(True)
plt.xlabel('Time (ns)')
plt.savefig('enthalpy_228K_no_thermostat.png', bbox_inches='tight')
plt.show()


# Calculate Self Diffusion

slope_range = 300
def linear(x, a, b):
	return a*x + b

diff = []
for i in range(0, slope_range):
	diff.append(0)

for i in range(slope_range, len(data[8])-slope_range):
	msd_vals = data[7][i-slope_range : i+slope_range]
	time_vals = data[8][i-slope_range : i+slope_range]
	popt, pcov = curve_fit(linear, time_vals, msd_vals)
	perr = np.sqrt(np.diag(pcov))
	diff.append(popt[0]/6)

for i in range(0, slope_range):
	diff.append(0)

plt.figure(2)
plt.subplot(311)
plt.title('Self Diffusion')
plt.grid(True)
plt.ylabel('Mean Sq Disp')
plt.plot(data[8], data[7])

plt.subplot(312)
plt.grid(True)
plt.ylabel('Self Diff Coefficient')
plt.plot(data[8], diff)
plt.subplot(313)

plt.grid(True)
plt.xlabel('Time (ns)')
plt.ylabel('Temperature')
plt.ylim(175, 300)
plt.plot(data[8], data[1])
plt.hlines(273.15, 0, 10, colors='r', label="273.15 K")
plt.savefig('diffusion_200K_no_thermostat.png', bbox_inches='tight')
plt.show()
	
	



