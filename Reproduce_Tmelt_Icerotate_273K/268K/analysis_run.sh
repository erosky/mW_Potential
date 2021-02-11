#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./validate_eq.sh LOG_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=17
end=14017
datafile="run_Tmelt_268K_00"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Sim 268K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7" > run_PE.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement - Sim 268K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8" > run_MSD.svg

# Plot and save Volume
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Box Volume - Sim 268K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:4" > run_VOL.svg

