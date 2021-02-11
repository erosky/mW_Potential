
TEMPERATURES=['266K', '267K', '268K', '269K', '270K', '271K', '272K', '273K', '274K']
WORKING_DIR= '~/mW_Potetial/Reproduce_T_melt'
LOG_FILE='auto_run.log'

FULL_DATASET={'266K':[]

for temp in TEMPERATURES:
    data_file='run_Tmelt_{}_AUTO.dat'.format(temp)
    LOG_FILE.write('loading for {}'.format(temp))
    
    FULL_DATASET[temp] = 'run_Tmelt_{}_AUTO.dat'.format(temp)
# if something goes wrong, log "Unable to complete run of ${entry}
# if success, log "completed run for ${entry}"


#

