echo "Enter Num1"
read num1
echo "Enter Num2"
read num2
echo "Enter Num3"
read num3

if [ $num1 -gt $num2 ] && [ $num1 -gt $num3 ]
then
    echo "Greatest number is $num1"
elif [ $num2 -gt $num1 ] && [ $num2 -gt $num3 ]
then
    echo "Greatest number is $num2"
else
    echo "Greatest number is $num3"
fi

if [ $num1 -lt $num2 ] && [ $num1 -lt $num3 ]
then
    echo "Smallest number is $num1"
elif [ $num2 -lt $num1 ] && [ $num2 -lt $num3 ]
then
    echo "Smallest number is $num2"
else
    echo "Smallest number is $num3"
fi
eq1=$(($num1+($num2*$num3)))
eq2=$(($num1+($num2/$num3)))
eq3=$((($num1%$num2)+$num3))
eq4=$((($num1*$num2)+$num3))

echo $eq1
echo $eq2
echo $eq3
echo $eq4

