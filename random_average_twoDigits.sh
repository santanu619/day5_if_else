#!/bin/bash -x
randomNumber1=$(((RANDOM%90)+10))
randomNumber2=$(((RANDOM%90)+10))
randomNumber3=$(((RANDOM%90)+10))
randomNumber4=$(((RANDOM%90)+10))
randomNumber5=$(((RANDOM%90)+10))
sum=$(($randomNumber1+$randomNumber2+$randomNumber3+$randomNumber4+$randomNumber5))
average=$((($sum / 5) | bc -l))
echo $average

