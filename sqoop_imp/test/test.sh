#!/bin/bash  
#date and time
source /www/data-analysis/conf/config.sh
two_start_date=`date  -d -2day "+%Y-%m-%d"`
two_start_time=`date  -d -2day "+%Y-%m-%d 00:00:00"`
start_date=`date  -d yesterday "+%Y-%m-%d"`
start_time=`date  -d yesterday "+%Y-%m-%d 00:00:00"`
today_date=`date "+%Y-%m-%d"`
today_time=`date "+%Y-%m-%d 00:00:00"`
#configuration file
connect=`grep 'test_ip=' $configUrl`
connect_url=${connect##*=}
username=`grep 'test_user=' $configUrl`
db_username=${username##*=}
password=`grep 'test_user_pw=' $configUrl`
db_password=${password##*=}

##bas_t_account_ops_init
hive_table=test
hive_database=test
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop fs -rmr ${target_dir}
#增量的脚本
source /etc/profile
sqoop import --connect $connect_url --username $db_username --password $db_password --query "select id,name,sex from test where id>1 and  \$CONDITIONS " -m 1 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?