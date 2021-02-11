#!/bin/bash

# read in dump file
# if line in file has 14 entries, then keep it
# average values of last 5 fields q4, q6, q8, q10, q12
echo "Order parameters computed for 800 water molecules at 270K"

awk '{ if (NF==16) sum4 += $12; sum6 += $13; sum8 += $14; sum10 += $15; sum12 += $16; n++ } END { print sum4 / n; print sum6 / n; print sum8 / n; print sum10 / n; print sum12 / n }' prod.ice_order_270K_00.dump

q4=$(awk '{ if (NF==16) sum4 += $12; n++ } END { print sum4 / n }' prod.ice_order_270K_00.dump )
q6=$(awk '{ if (NF==16) sum6 += $13; n++ } END { print sum6 / n }' prod.ice_order_270K_00.dump )
q8=$(awk '{ if (NF==16) sum8 += $14; n++ } END { print sum8 / n }' prod.ice_order_270K_00.dump )
q10=$(awk '{ if (NF==16) sum10 += $15; n++ } END { print sum10 / n }' prod.ice_order_270K_00.dump )
q12=$(awk '{ if (NF==16) sum12 += $16; n++ } END { print sum12 / n }' prod.ice_order_270K_00.dump )

d4=$(awk -v q="$q4" '{ if (NF==16) sum += (q-$12)^2; n++ } END { print sqrt(sum / n) }' prod.ice_order_270K_00.dump )
d6=$(awk -v q="$q6" '{ if (NF==16) sum += (q-$13)^2; n++ } END { print sqrt(sum / n) }' prod.ice_order_270K_00.dump )
d8=$(awk -v q="$q8" '{ if (NF==16) sum += (q-$14)^2; n++ } END { print sqrt(sum / n) }' prod.ice_order_270K_00.dump )
d10=$(awk -v q="$q10" '{ if (NF==16) sum += (q-$15)^2; n++ } END { print sqrt(sum / n) }' prod.ice_order_270K_00.dump )
d12=$(awk -v q="$q12" '{ if (NF==16) sum += (q-$16)^2; n++ } END { print sqrt(sum / n) }' prod.ice_order_270K_00.dump )

echo "q d max min"
echo $q4 $d4 
echo $q6 $d6 
echo $q8 $d8
echo $q10 $d10
echo $q12 $d12
