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
connect=`grep 'tbb_account_IP=' $configUrl`
connect_url=${connect##*=}
username=`grep 'tbb_account_USER=' $configUrl`
db_username=${username##*=}
password=`grep 'tbb_account_PW=' $configUrl`
db_password=${password##*=}
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}


hive_table=bas_t_account_ops_idld
hive_database=ds_tubobo_account
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_t_account_ops_idld
#增量的脚本
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --query "select id,account_id,order_id,related_op_id,target,amount,amount_from_withdrawable,commission,type,sub_type,status,title,details,remarks,channel,third_system_order_id,client_ip,del_flag,create_time,update_time from t_account_ops where create_time>='${start_time}' and create_time<'${today_time}' or update_time<'${today_time}' and update_time>='${start_time}' and  \$CONDITIONS " -m 1 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?

##bas_t_account_record_idld
hive_table=bas_t_account_record_idld
hive_database=ds_tubobo_account
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_t_account_record_idld
#idld shell
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --query "select id,account_id,ops_id,amount,type,sub_type,current_balance,current_withdrawable,current_frozen,current_deposit,remarks,del_flag,create_time,charge_time from t_account_record where charge_time>='${start_time}' and charge_time<'${today_time}' or create_time>='${start_time}' and create_time<'${today_time}' and  \$CONDITIONS " -m 1 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?

##bas_tubobo_merchant_info_idld
connect=`grep 'tubobo_merchant_IP=' $configUrl`
connect_url=${connect##*=}
username=`grep 'tubobo_merchant_USER=' $configUrl`
db_username=${username##*=}
password=`grep 'tubobo_merchant_PW=' $configUrl`
db_password=${password##*=}
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
##bas_tubobo_order_detail_idld
hive_table=bas_tubobo_order_detail_idld
hive_database=ds_tubobo_merchant
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_tubobo_order_detail_idld
#增量的脚本
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --query "select id,order_no,order_remark,user_id,sender_phone,sender_address,sender_longitude,sender_latitude,dispatch_radius,create_date,update_date,del_flag,receiver_address_name,sender_address_detail,sender_address_province,sender_address_name,sender_address_city,sender_address_district,sender_address_street,sender_address_room_no,cancel_reason,expired_minute,expired_compensation,wait_pick_cancel_type,cancel_fine,cancel_compensation,pickup_distance,unsettled_reason,mer_message,resend_target_no,platform_fee,rider_fee,cancel_source_delivery_fee,cancel_source_delivery_subsidy,cancel_source_order_no from tubobo_order_detail  where create_date>='${start_time}' and create_date<'${today_time}' or update_date>='${start_time}' and update_date<'${today_time}' and  \$CONDITIONS " -m 1 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?

##bas_tubobo_order_idld
hive_table=bas_tubobo_order_idld
hive_database=ds_tubobo_merchant
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_tubobo_order_idld
#idld shell
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --query "select id,order_status,order_no,order_type,pay_amount,delivery_fee,tip_fee,pay_status,pay_method,pay_time,order_time,cancel_time,grab_order_time,grab_item_time,finish_order_time,user_id,sender_name,receiver_name,receiver_phone,receiver_longitude,receiver_latitude,rider_id,rider_name,rider_phone,create_by,create_date,update_date,del_flag,receiver_address_name,receiver_address_province,receiver_address_street,receiver_address_detail,receiver_address_city,receiver_address_district,pay_id,delivery_distance,receiver_address_room_no,expect_finish_time,rated_flag,origin_order_id,origin_order_view_id,platform_code,weather_over_fee,peek_over_fee,sender_adcode,unsettled_status,unsettled_time,short_message,provider_id,order_feature from tubobo_order where create_date>='${start_time}' and create_date<'${today_time}' or update_date>='${start_time}' and update_date<'${today_time}' and  \$CONDITIONS " -m 1 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?


#database and table configure
mysql_table=tubobo_merchant_info
hive_table=bas_tubobo_merchant_info_idld
hive_database=ds_tubobo_merchant
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_tubobo_merchant_info_idld
#sqoop idld  shell
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --table ${mysql_table} -m 5 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?

##bas_tubobo_rider_info_idld
connect=`grep 'tubobo_rider_IP=' $configUrl`
connect_url=${connect##*=}
username=`grep 'tubobo_rider_USER=' $configUrl`
db_username=${username##*=}
password=`grep 'tubobo_rider_PW=' $configUrl`
db_password=${password##*=}
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
#database and table configure
mysql_table=tubobo_rider_info
hive_table=bas_tubobo_rider_info_idld
hive_database=ds_tubobo_rider
target_dir=/user/hive/warehouse/tmp.db/${hive_table}
source /etc/profile
hadoop dfs -rmr ${target_dir}
hadoop dfs -rmr /user/hive/warehouse/tmp.db/bas_tubobo_rider_info_idld
#sqoop idld  shell
#增量的脚本
source /etc/profile
sqoop import --connect ${connect_url} --username ${db_username} --password ${db_password} --table ${mysql_table} -m 5 --hive-table ${hive_database}.${hive_table} --hive-drop-import-delims --target-dir ${target_dir} --hive-overwrite --null-string '\\N' --null-non-string '\\N' --fields-terminated-by "\001" --hive-import;
echo $?


# inert bas table 
spark-sql --master ${spark_url} -e "
insert overwrite table ds_tubobo_account.bas_t_account_ops_pd partition (day='${start_date}')
select  * from ds_tubobo_account.bas_t_account_ops_idld;

insert overwrite table ds_tubobo_account.bas_t_account_record_pd partition (day='${start_date}') 
select * from ds_tubobo_account.bas_t_account_record_idld;

insert overwrite table ds_tubobo_merchant.bas_tubobo_order_detail_pd partition (day='${start_date}')
select * from ds_tubobo_merchant.bas_tubobo_order_detail_idld;

insert overwrite table ds_tubobo_merchant.bas_tubobo_order_pd partition (day='${start_date}')
select * from ds_tubobo_merchant.bas_tubobo_order_idld;

insert overwrite table ds_tubobo_merchant.bas_tubobo_merchant_info_pd partition (day='${start_date}')
select * from ds_tubobo_merchant.bas_tubobo_merchant_info_idld;

insert overwrite table ds_tubobo_rider.bas_tubobo_rider_info_pd  partition (day='${start_date}')
select * from ds_tubobo_rider.bas_tubobo_rider_info_idld;
"
echo $?