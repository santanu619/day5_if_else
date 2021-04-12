#!/bin/bash -x
FEET=60*40
METERS=$(( $FEET / 3 ))
ACRES=$(($METERS/21))
PLOTS=$(($ACRES*25))
echo $PLOTS

