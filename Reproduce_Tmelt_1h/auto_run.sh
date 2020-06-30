#!/bin/bash

TEMPERATURES=('268K' '269K' '270K' '271K' '272K' '273K' '274K' '275K')
WORKING_DIR=~/mW_Potential/Reproduce_Tmelt_1h
LOG_FILE=${WORKING_DIR}/auto_run.log
DATETIME=$(date +"%Y-%m-%d_%H:%M:%S")

# Log date and time
echo "${DATETIME}" >> ${LOG_FILE}

# Run simulation in each temperature directory
for temp in "${TEMPERATURES[@]}"; do
    echo $temp
    cd "${WORKING_DIR}/$temp" && \
    # Check that input file exists before running simulation
    if [ -f in.eq_run_AUTO ]; then
        echo "$temp input file found: Ready to run $temp simulation" >> ${LOG_FILE}
        # Run simulation, direct errors into log file
        mpirun -np 10 ../lmp_mpi -in in.eq_run_AUTO 2> ${LOG_FILE}
        wait
        # Print run time into log file
        tail -1 log.run_Tmelt_${temp}_AUTO >> ${LOG_FILE}
    else
        echo "Input file does not exist for $temp simulation" >> ${LOG_FILE}
    fi
done

# once complete, run auto_analysis.sh
