#!/bin/bash

# Verify that system matches published properties of ML-mW water model
# check density and self-dissusion
# density should be 997 kg/m^3
# diffusion should be 4.7 e-5 cm^2/s
# USAGE: ./validate_model.sh



# Create data file of wanted lines from the log file START to END
echo "running"

run=$1
start=42
end=1042
logfile="log.run_ice_289K_1atm_ML"
datafile="run_ice_289K_1atm_ML.dat"

temp="289"
pres="1 atm"



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/200000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8, $9 }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal png size 1000,600; \
            set output 'PE_${pres}_${temp}_run.png'; \
            set title 'Potential Energy - ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7"

# Plot and save Mean square disp
gnuplot -e "set terminal png size 1000,600; \
            set output 'MSD_${pres}_${temp}_run.png'; \
            set title 'Mean Square Displacement vs Time - ${temp}K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8"

# Plot and save Pressure
gnuplot -e "set terminal png size 1000,600; \
            set output 'Pres_${pres}_${temp}_run.png'; \
            set title 'Pressure - ${temp}K, ML-mW'; \
            set ylabel 'atm'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:3"

# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output 'Vol_${pres}_${temp}_run.png'; \
            set title 'Volume - ${temp}K, ML-mW'; \
            set ylabel 'cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"


# compute average density
awk '{sum += $9; n++}END{print sum / n; }' ${datafile}



