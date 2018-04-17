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
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
reoportdata_mysql_url=`grep 'reoportdata_mysql_url=' $configUrl`
reoportdata_url=${reoportdata_mysql_url##*=}
sqoop_mysql_url=`grep 'sqoop_exp_zhongbao_IP=' $configUrl`
mysql_url=${sqoop_mysql_url#*=}
sqoop_mysql_user=`grep 'sqoop_exp_USER=' $configUrl`
mysql_user=${sqoop_mysql_user##*=}
sqoop_mysql_password=`grep 'sqoop_exp_PW=' $configUrl`
mysql_password=${sqoop_mysql_password##*=}

hive_data=tubobo_reportdata

##zhongbao_total_send_merchant_ids_info
hive_table=zhongbao_total_send_merchant_ids_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=zhongbao_total_send_merchant_ids_info
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,province,city,total_send_merchant_ids"
echo $?


##zhongbao_total_recharge_merchant_ids_info
hive_table=zhongbao_total_recharge_merchant_ids_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=zhongbao_total_recharge_merchant_ids_info
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,province,city,total_recharge_merchant_ids"
echo $?


##zhongbao_total_receiver_rider_ids_info
hive_table=zhongbao_total_receiver_rider_ids_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=zhongbao_total_receiver_rider_ids_info
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,province,city,total_receiver_rider_ids"
echo $?


##zhongbao_platform_income_details
hive_table=zhongbao_platform_income_details
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=zhongbao_platform_income_details
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,province,city,total_recharge_account,total_deposit_account,total_rider_fine_account,total_insurance_account,total_commission_account,total_gift_account,total_rider_withdraw_account,total_create_num,total_finish_num,income_total_amount,outcome_total_amount"        
echo $?                


##zhongbao_merchant_order_heat_entity
hive_table=zhongbao_merchant_order_heat_entity
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=zhongbao_merchant_order_heat_entity
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_date,province,city,district,longitude,latitude,finish_num,cancel_num"
echo $?

