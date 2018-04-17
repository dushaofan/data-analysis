#!bin/sh
filelist=`ls /www/data-analysis/create_table/hive_table`
for file in $filelist
do
 result=$(echo $file | grep ".sql")
 if [[ "$result" != "" ]]
 then
   if [[ "$file" != "ues_create_date.sql" ]]
   then
    hive -f  $file
   fi
 fi
 done