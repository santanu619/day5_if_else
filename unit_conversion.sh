sum=0
i="y"

echo " Enter one no."
read n1
while [ $i = "y" ]
do
echo "1.Feet to Inch"
echo "2.Inch to Feet"
echo "3.Feet to Metre"
echo "4.Metre to Feet"
echo "Enter your choice"
read ch
case $ch in
    1)ftoi=`expr $n1 \* 12`
     echo "Inch ="$ftoi;;
        2)itof=`expr $n1 \* 0.083`
     echo "Feet1 = "$itof;;
    3)ftom=`expr $n1 / 3.28`
     echo "Metre = "$ftom;;
    4)mtof=`expr $n1 \* 3.28`
     echo "Feet2 = "$mtof;;
    *)echo "Invalid choice";;
esac
echo "Do u want to continue ?"
read i
if [ $i != "y" ]
then
    exit
fi
done    



