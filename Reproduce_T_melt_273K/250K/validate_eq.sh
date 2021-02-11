#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./validate_eq.sh LOG_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=63
end=73
datafile="eq_Tmelt_250K_00"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Eq 250K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7" > eq_PE.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement - Eq 250K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8" > eq_MSD.svg

