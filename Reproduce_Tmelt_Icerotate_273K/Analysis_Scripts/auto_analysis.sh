#!/bin/bash

TEMPERATURES=('268K' '269K' '270K' '271K' '272K' '273K' '274K')
WORKING_DIR=/home/emrosky/mW_Potential/Reproduce_Tmelt_Icerotate_273K/Analysis_Scripts
LOG_FILE=${WORKING_DIR}/auto_analysis.log
DATETIME=$(date +"%Y-%m-%d_%H:%M:%S")

# Log date and time
echo "${DATETIME}" >> ${LOG_FILE}

# Run simulation in each temperature directory
for temp in "${TEMPERATURES[@]}"; do
    cd "${WORKING_DIR}/../$temp" && \
    # Check that input file exists before running simulation
    if [ -f log.run_Tmelt_${temp}_AUTO ]; then
        echo "$temp input file found: Ready to analyze $temp simulation" >> ${LOG_FILE}
        # Run script, direct errors into log file
        ${WORKING_DIR}/auto_analysis_run.sh log.run_Tmelt_${temp}_AUTO run_Tmelt_${temp}_AUTO
        
    else
        echo "Input file does not exist for $temp simulation" >> ${LOG_FILE}
    fi
done


