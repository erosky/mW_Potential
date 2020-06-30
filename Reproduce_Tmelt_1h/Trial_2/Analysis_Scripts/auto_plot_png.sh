#!/bin/bash


#TEMPERATURES=('266K' '267K')
TEMPERATURES=('268K' '269K' '270K' '271K' '272K' '273K' '274K' '275K')
WORKING_DIR=~/mW_Potential/Reproduce_Tmelt_1h/Trial_2/Analysis_Scripts
LOG_FILE=${WORKING_DIR}/auto_plot.log
DATETIME=$(date +"%Y-%m-%d_%H:%M:%S")

# Log date and time
echo "${DATETIME}" >> ${LOG_FILE}

for temp in "${TEMPERATURES[@]}"; do
    data_file="../${temp}/run_Tmelt_${temp}_AUTO.dat"
    if [ -f ${data_file} ]; then
        echo "$temp input file found: Ready to copy $temp data" >> ${LOG_FILE}
        cp ${data_file} ${WORKING_DIR}/run_Tmelt_${temp}_AUTO.dat
    else
        echo "Input file does not exist for $temp simulation" >> ${LOG_FILE}
    fi
done


# Plot and save Pot Energy
gnuplot -e "set terminal png; \
            set output 'Tmelt_PE_all.png';
            set title 'Potential Energy'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set key outside ; \
            set key right top ; \
            set style data lines; \
            plot for [i=268:275] 'run_Tmelt_'.i.'K_AUTO.dat' using 1:7 title ''.i.'K'; "

# Plot and save Total Energy
gnuplot -e "set terminal png; \
            set title 'Total Energy'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set key outside ; \
            set key right top ; \
            set style data lines; \
            plot for [i=268:275] 'run_Tmelt_'.i.'K_AUTO.dat' using 1:5 title ''.i.'K'" > ${WORKING_DIR}/Tmelt_TE_all.png

# Plot and save Mean square disp
gnuplot -e "set terminal png; \
            set title 'Mean Square Displacement'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set key outside ; \
            set key right top ; \
            set style data lines; \
            plot for [i=268:275] 'run_Tmelt_'.i.'K_AUTO.dat' using 1:8 title ''.i.'K'" > ${WORKING_DIR}/Tmelt_MSD_all.png

# Plot and save Volume
gnuplot -e "set terminal png; \
            set title 'Box Volume'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set key outside ; \
            set key right top ; \
            set style data lines; \
            plot for [i=268:275] 'run_Tmelt_'.i.'K_AUTO.dat' using 1:4 title ''.i.'K'" > ${WORKING_DIR}/Tmelt_VOL_all.png


for temp in "${TEMPERATURES[@]}"; do
    if [ -f ${WORKING_DIR}/run_Tmelt_${temp}_AUTO.dat ]; then
        echo "$temp input file found: Ready to remove $temp data" >> ${LOG_FILE}
        rm ${WORKING_DIR}/run_Tmelt_${temp}_AUTO.dat
    else
        echo "Data file was not created for $temp simulation" >> ${LOG_FILE}
    fi
done
