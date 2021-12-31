#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./validate_eq.sh



# Create data file of wanted lines from the log file START to END
echo $1

run=$1
start=76
end=1076
logfile="log.eq_ice_289K_1atm_ML"
datafile="eq_ice_289K_1atm_ML.dat"

temp="289"
pres="1atm"



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/200000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8, $9 }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal png size 1000,600; \
            set output 'PE_${pres}_${temp}_ML.png'; \
            set title 'Potential Energy - ${temp}K equilibration, ML-mW'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7"

# Plot and save Mean square disp
gnuplot -e "set terminal png size 1000,600; \
            set output 'MSD_${pres}_${temp}_ML.png'; \
            set title 'Mean Square Displacement - ${temp}K equilibration, ML-mW'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8"


# Plot and save Pressure
gnuplot -e "set terminal png size 1000,600; \
            set output 'Pres_${pres}_${temp}_ML.png'; \
            set title 'Pressure - ${temp}K equilibration, ML-mW'; \
            set ylabel 'atm'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:3"

# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output 'Vol_${pres}_${temp}_ML.png'; \
            set title 'Volume - ${temp}K equilibration, ML-mW'; \
            set ylabel 'cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"
