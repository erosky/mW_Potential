#!/bin/bash

# USAGE: ./validate_water.sh LOG_FILE


# Create temporary data file of wanted lines from timestep START to END

#awk '{print $1}' $1
echo $1

start=4199
# count number of lines in log file. subtract 
end=6200

datafile="ice_box_228K_00"


sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ~/mW_Potential/Ice_Box/Data_Analysis/${datafile}.dat


