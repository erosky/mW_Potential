#!/bin/bash

# USAGE: ./validate_water.sh LOG_FILE


# Create temporary data file of wanted lines from timestep START to END

#awk '{print $1}' $1
echo $1

start=4193
# count number of lines in log file. subtract 
end=44191

datafile="no_thermostat_228K_00"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ~/mW_Potential/Liquid_Box/No_Thermostat/Data_Analysis/${datafile}.dat


