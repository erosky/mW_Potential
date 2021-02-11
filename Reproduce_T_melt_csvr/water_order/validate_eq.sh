#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./validate_eq.sh LOG_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=137
end=147
datafile="280K.eq-water"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set title 'Potential Energy - Water 280K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7"

# Plot and save Mean square disp
gnuplot -e "
            set title 'Mean Square Displacement - Water 280K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8"

