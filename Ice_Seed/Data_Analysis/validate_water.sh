#!/bin/bash

# USAGE: ./validate_water.sh LOG_FILE

# Create temporary data file of wanted lines from timestep START to END

log_file=$1
datafile=$(echo ${log_file} | awk -F '.' '{print $NF}')

start=136  # first line of data in log file
end=2137   # last line of data in log file +1

sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ./data/${datafile}.dat


