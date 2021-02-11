#!/bin/bash

# read in dump file
# if line in file has 14 entries, then keep it
# average values of last 5 fields q4, q6, q8, q10, q12

awk '{ if (NF==13) sum4 += $9; sum6 += $10; sum8 += $11; sum10 += $12; sum12 += $13; n++ } END { print sum4 / n; print sum6 / n; print sum8 / n; print sum10 / n; print sum12 / n }' prod.water_order_280K_00.dump

q4=$(awk '{ if (NF==13) sum4 += $9; n++ } END { print sum4 / n }' prod.water_order_280K_00.dump )
q6=$(awk '{ if (NF==13) sum6 += $10; n++ } END { print sum6 / n }' prod.water_order_280K_00.dump )
q8=$(awk '{ if (NF==13) sum8 += $11; n++ } END { print sum8 / n }' prod.water_order_280K_00.dump )
q10=$(awk '{ if (NF==13) sum10 += $12; n++ } END { print sum10 / n }' prod.water_order_280K_00.dump )
q12=$(awk '{ if (NF==13) sum12 += $13; n++ } END { print sum12 / n }' prod.water_order_280K_00.dump )

d4=$(awk -v q="$q4" '{ if (NF==13) sum4 += (q-$9)^2; n++ } END { print sqrt(sum4 / n) }' prod.water_order_280K_00.dump )
d6=$(awk -v q="$q6" '{ if (NF==13) sum6 += (q-$10)^2; n++ } END { print sqrt(sum6 / n) }' prod.water_order_280K_00.dump )
d8=$(awk -v q="$q8" '{ if (NF==13) sum8 += (q-$11)^2; n++ } END { print sqrt(sum8 / n) }' prod.water_order_280K_00.dump )
d10=$(awk -v q="$q10" '{ if (NF==13) sum10 += (q-$12)^2; n++ } END { print sqrt(sum10 / n) }' prod.water_order_280K_00.dump )
d12=$(awk -v q="$q12" '{ if (NF==13) sum12 += (q-$13)^2; n++ } END { print sqrt(sum12 / n) }' prod.water_order_280K_00.dump )

echo "q4"
echo $q4 $d4
echo $q6 $d6
echo $q8 $d8
echo $q10 $d10
echo $q12 $d12
