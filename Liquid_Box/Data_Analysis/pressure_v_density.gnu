# awk '{for (i=1; i<=NF; i++) if ($i + 0 != $i) {next}{print}}' ../mW_bcc_3.90859.log > 
# mW_bcc_3_90859.dat

set ylabel "self diffusion"
set xlabel "timestep (0.0005 psec per step)"
plot "mW_bcc_3_90859.dat" using 1:6


