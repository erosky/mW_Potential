#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./validate_eq.sh LOG_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=70
end=1070
datafile="setup_atoms_280K_01.eq_all"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Ice Water Phase Coexistance 280K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7" > all_eq_PE_01.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement - Ice Water Phase Coexistance 280K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8" > all_eq_MSD_01.svg

