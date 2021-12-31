#!/bin/bash

# read in dump file
# if line in file has 14 entries, then keep it
# average values of last 5 fields q4, q6, q8, q10, q12
echo "Order parameters computed for ML-mW ice at 289K"
dumpfile='prod.ice_289K_1000atm_ML.dump'

awk '{ if (NF==13) sum4 += $9; sum6 += $10; sum8 += $11; sum10 += $12; sum12 += $13; n++ } END { print sum4 / n; print sum6 / n; print sum8 / n; print sum10 / n; print sum12 / n }' $dumpfile

q4=$(awk '{ if (NF==13) sum4 += $9; n++ } END { print sum4 / n }' ${dumpfile})
q6=$(awk '{ if (NF==13) sum6 += $10; n++ } END { print sum6 / n }' $dumpfile )
q8=$(awk '{ if (NF==13) sum8 += $11; n++ } END { print sum8 / n }' $dumpfile )
q10=$(awk '{ if (NF==13) sum10 += $12; n++ } END { print sum10 / n }' $dumpfile )
q12=$(awk '{ if (NF==13) sum12 += $13; n++ } END { print sum12 / n }' $dumpfile )

d4=$(awk -v q="$q4" '{ if (NF==13) sum += (q-$9)^2; n++ } END { print sqrt(sum / n) }' ${dumpfile} )
d6=$(awk -v q="$q6" '{ if (NF==13) sum += (q-$10)^2; n++ } END { print sqrt(sum / n) }' $dumpfile )
d8=$(awk -v q="$q8" '{ if (NF==13) sum += (q-$11)^2; n++ } END { print sqrt(sum / n) }' $dumpfile )
d10=$(awk -v q="$q10" '{ if (NF==13) sum += (q-$12)^2; n++ } END { print sqrt(sum / n) }' $dumpfile )
d12=$(awk -v q="$q12" '{ if (NF==13) sum += (q-$13)^2; n++ } END { print sqrt(sum / n) }' $dumpfile )

echo "q d max min"
echo $q4 $d4 $( bc <<<"$q4 + $d4" ) $( bc <<<"$q4 - $d4" )
echo $q6 $d6 $( bc <<<"$q6 + $d6" ) $( bc <<<"$q6 - $d6" )
echo $q8 $d8 $( bc <<<"$q8 + $d8" ) $( bc <<<"$q8 - $d8" )
echo $q10 $d10 $( bc <<<"$q10 + $d10" ) $( bc <<<"$q10 - $d10" )
echo $q12 $d12 $( bc <<<"$q12 + $d12" ) $( bc <<<"$q12 - $d12" )
