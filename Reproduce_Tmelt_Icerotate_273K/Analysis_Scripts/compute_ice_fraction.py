# Compute fraction of atoms considered ice-like at each timestep
# input: dump file

# File structure
# ITEM: TIMESTEP
# [timestep]
# ITEM: NUMBER OF ATOMS
# [n]
# ITEM: BOX BOUNDS pp pp pp
# 0.0000000000000000e+00 2.4818000000000001e+01
# 0.0000000000000000e+00 3.1022500000000001e+01
# 0.0000000000000000e+00 3.1022500000000001e+01
# ITEM: ATOMS id type xs ys zs stress[1-6] order[4, 12]

# Algorithm
# For each timestep
#   N = total number of atoms
#   I = number of ice atoms
#   For each atom
#     if order[12] > 0.3
#     I++
#     Set atom type in new dump file 
#   fraction_ice = I/N
#   write to ice fraction data file for timestep


# Initialization
# Read in number of atoms


# There will be a lot of timesteps, you will want to compute in parallel
# N_t = number of timesteps
# N_procs = number of processor cores
# N_per_proc = N_t/N_procs
# remainder = N_t%N_procs
# For line in file, separate by white space field seperator
# Thread_dict = { 0:[5, N], 1:[start,end], ... , N_t:[start,end] }

# Output file structure
# timestep, ice, water





