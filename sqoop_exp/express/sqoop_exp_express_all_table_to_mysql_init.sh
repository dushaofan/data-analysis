#!/bin/sh
#date and time
source /www/data-analysis/conf/config.sh
two_start_date=`date  -d -2day "+%Y-%m-%d"`
two_start_time=`date  -d -2day "+%Y-%m-%d 00:00:00"`
start_date=`date  -d yesterday "+%Y-%m-%d"`
start_time=`date  -d yesterday "+%Y-%m-%d 00:00:00"`
today_date=`date "+%Y-%m-%d"`
today_time=`date "+%Y-%m-%d 00:00:00"`

#configuration file
reoportdata_mysql_url=`grep 'reoportdata_mysql_url=' $configUrl`
reoportdata_url=${reoportdata_mysql_url##*=}
sqoop_mysql_url=`grep 'sqoop_exp_express_IP=' $configUrl`
mysql_url=${sqoop_mysql_url#*=}
sqoop_mysql_user=`grep 'sqoop_exp_USER=' $configUrl`
mysql_user=${sqoop_mysql_user##*=}
sqoop_mysql_password=`grep 'sqoop_exp_PW=' $configUrl`
mysql_password=${sqoop_mysql_password##*=}

hive_data=tubobo_reportdata

hive_table=tubobo_express_increase_store_num_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=express_increase_store_num_info
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${two_start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "store_id,store_status,province,city,create_date"
$?


hive_table=tubobo_express_num_abnormality
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=express_num_abnormality
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${two_start_date} --username ${mysql_user} -password ${mysql_password} -m 5 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,area_code,store_name,store_id,service_provider_name,area,express_in_num,yesterday_in_num,yesterday_increase,yesterday_reduce"
$?


hive_table=tubobo_express_store_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=express_store_info
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${two_start_date}  --username ${mysql_user} -password ${mysql_password} -m 5 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "area_code,date,province_code,city_code,district_code,area,store_id,store_name,join_time,service_provider_id,service_provider_name,province,city,district,latitude,longitude,latitude_and_longitude,express_in_num,express_sign_num,today_express_sign_num,send_message_num,total_send_message_num,stagnation_num,express_company_num,express_company"
$?

