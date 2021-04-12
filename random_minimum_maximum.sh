#!/bin/bash
MAXCOUNT=10
count=1
while [ "$count" -le $MAXCOUNT ]; do
 randomNumber=$(((RANDOM%900)+100))
 number[$count]=$randomNumber
 let "count += 1"
done

echo "${number[@]}"

#main loop
#small=${number[0]}
#greatest=${number[0]}
#for((i=0;i<MAXCOUNT;i++))
#do
#logic for smallest number
#if [ ${number[$i]} -lt $small ]; then
#small=${number[$i]}
#logic for greatest number
#elif [ ${number[$i]} -gt $greatest ]; then
#greatest=${number[$i]}
#fi
#done
#printing smallest and greatest number
#echo "smallest number in an array is $small"
#echo "greatest number in an array is $greatest"

echo "Original Numbers in array:"
for (( i = 0; i < 9; i++ ))
    do
      echo ${number[$i]}
    done

for (( i = 0; i < 9; i++ ))
do
   for (( j = $i; j < 9; j++ ))
   do
      if [ ${number[$i]} -gt ${number[$j]} ]; then
       t=${number[$i]}
       $number[$i]=${number[$j]}
       $number[$j]=$t
      fi
   done
done
echo "Minimum: " $number[0]
echo "Maximum: " $number[9]

