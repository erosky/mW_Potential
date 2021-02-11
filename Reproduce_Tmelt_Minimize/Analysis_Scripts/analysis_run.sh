#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh LOG_FILE


# Create data file of wanted lines from the log file START to END
echo $1

start=17
end=7017
datafile="run_Tmelt_270K_02"
temp=270
run=02


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./${datafile}.dat


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Sim ${temp}K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:7" > run_PE_${run}.svg

# Plot and save Total Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Total Energy - Sim ${temp}K'; \
            set ylabel 'kcal/mol'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:5" > run_E_${run}.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement - Sim ${temp}K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:8" > run_MSD_${run}.svg

# Plot and save Volume
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Box Volume - Sim ${temp}K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'timestep'; \
            set style data lines; \
            plot '${datafile}.dat' using 1:4" > run_VOL_${run}.svg

