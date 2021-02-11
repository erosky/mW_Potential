#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh LOG_FILE DATA_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=17
end=1017
datafile=$2
temp=270
run=AUTO


# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/100000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8 }}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7" > run_PE_${run}.svg

# Plot and save Total Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Total Energy'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:5" > run_E_${run}.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8" > run_MSD_${run}.svg

# Plot and save Volume
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Box Volume'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:4" > run_VOL_${run}.svg

