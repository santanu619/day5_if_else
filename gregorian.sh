#!/bin/sh

DATE=$@
[ "$DATE" = "" ] && DATE=$(date +%Y%m%d)

databases_path=databases

date_year=$(echo $DATE |sed 's/^\(.\{4\}\).*/\1/')
date_month=$(echo $DATE |sed 's/.*\(..\)..$/\1/')
date_day=$(echo $DATE |sed 's/.*\(..\)$/\1/')
date_days=$(date -d $DATE +%j)

lunar_year=$(sed /$date_year/!d $databases_path |sed 's/^\(....\).*/\1/')

lunar_year_data=$(sed /$date_year/!d $databases_path |sed 's/.*\ \(.*\)/\1/')
lunar_year_data_bin=$(echo "ibase=16;obase=2;$lunar_year_data" |sed -e :a -e 's/^.\{1,23\}$/0&/;ta')

new_year_month_bin=$(echo $lunar_year_data_bin |sed -e 's/^.\{17\}\(.\{2\}\).*/\1/')
new_year_month=$(echo "ibase=2;$new_year_month_bin" |sed -e :a -e 's/^.\{1,1\}$/0&/;ta')

new_year_day_bin=$(echo $lunar_year_data_bin |sed -e 's/.*\(.\{5\}\)$/\1/')
new_year_day=$(echo "ibase=2;$new_year_day_bin" |sed -e :a -e 's/^.\{1,1\}$/0&/;ta')

new_year_days=$(date -d $date_year$new_year_month$new_year_day +%j)
lunar_days=$(expr $date_days - $new_year_days + 1)

befor_or_after=0

if [ "$lunar_days" -le "0" ]; then
  befor_or_after=1
  date_year=$(($date_year - 1))

  lunar_year=$(sed /$date_year/!d $databases_path |sed 's/^\(....\).*/\1/')

  lunar_year_data=$(sed /$date_year/!d $databases_path |sed 's/.*\ \(.*\)/\1/')
  lunar_year_data_bin=$(echo "ibase=16;obase=2;$lunar_year_data" |sed -e :a -e 's/^.\{1,23\}$/0&/;ta')
fi

lunar_leap_month_bin=$(echo $lunar_year_data_bin |sed -e 's/^\(.\{4\}\).*/\1/')
lunar_leap_month=$(echo "ibase=2;$lunar_leap_month_bin"|bc)

lunar_month_all_bin=$(echo $lunar_year_data_bin |sed -e 's/^.\{4\}\(.\{13\}\).*/\1/')
[ "$lunar_leap_month" = "0" ] && lunar_month_all_bin=$(echo $lunar_year_data_bin |sed -e 's/^.\{4\}\(.\{12\}\).*/\1/')
lunar_month_all=$(echo $lunar_month_all_bin |sed -e 's/0/29\ /g' |sed -e 's/1/30\ /g')

if [ "$befor_or_after" = "0" ];then
  lunar_month=1
  lunar_day=$lunar_days
  for i in $lunar_month_all
  do
   [ "$lunar_day" -gt "$i" ] && lunar_day=$(($lunar_day - $i)) && lunar_month=$(($lunar_month + 1))
   [ "$lunar_day" = "$i" ] && break
  done
else
  lunar_month=12
  lunar_day=$((-$lunar_days))
  lunar_month_all_bin=$(echo $lunar_month_all_bin |rev)
  lunar_month_all=$(echo $lunar_month_all_bin |sed -e 's/0/29\ /g' |sed -e 's/1/30\ /g')
  for i in $lunar_month_all
  do
   if [ "$lunar_day" -gt "$i" ]; then
     lunar_day=$(($lunar_day - $i))
     lunar_month=$(($lunar_month - 1))
   else
     lunar_day=$(($i - $lunar_day))
     break
   fi
  done
fi

if [ $lunar_leap_month -eq 0 ]; then
  echo $lunar_year-$lunar_month-$lunar_day
else
  if [ $lunar_leap_month -ge $lunar_month ]; then
   echo $lunar_year-$lunar_month-$lunar_day
  elif [ "$befor_or_after" = "0" ]; then
   if [ "$(($lunar_leap_month + 1))" = "$lunar_month" ];then
     lunar_month=$(($lunar_month - 1))
     echo $lunar_year-*$lunar_month-$lunar_day
   else
     lunar_month=$(($lunar_month - 1))
     echo $lunar_year-$lunar_month-$lunar_day
   fi
  else
   echo $lunar_year-$lunar_month-$lunar_day
  fi
fi
