#!/bin/bash

# USAGE: ./validate_water.sh LOG_FILE OUTPUT_DATA_FILE


# Create a data file of wanted lines from timestep START to END

#awk '{print $1}' $1
echo $1
echo $2

start=40
# count number of lines in log file. subtract 
end=1040

datafile=$2


# No Modulo, using all daya points in log file
#
#sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) {print $0}}' > ${datafile}


# Use modulo to reduce datapoints, and try to remove correlation between data points
# mod 20 is every 20 data points taken
#
sed "s/^[ \t]*//" $1 | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)&&(NR%10 == 0)) {print $0}}' > ${datafile}

