#!/bin/bash -x
one_feet=12
fourtyTwo_inches=$((42/$one_feet | bc))
echo $fourtyTwo_inches
