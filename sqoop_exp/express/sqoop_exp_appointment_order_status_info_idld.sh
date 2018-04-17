#!/bin/sh
source /www/data-analysis/conf/config.sh
two_start_date=`date  -d -2day "+%Y-%m-%d"`
two_start_time=`date  -d -2day "+%Y-%m-%d 00:00:00"`
start_date=`date  -d yesterday "+%Y-%m-%d"`
start_time=`date  -d yesterday "+%Y-%m-%d 00:00:00"`
today_date=`date "+%Y-%m-%d"`
today_time=`date "+%Y-%m-%d 00:00:00"`
start_date_time=`date -d "$start_time" +%s`000
end_date_time=`date -d "$today_time" +%s`000
begin_time_8=`expr $start_date_time + 28800000`
end_time_8=`expr $end_date_time + 28800000`

spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
reoportdata_mysql_url=`grep 'reoportdata_mysql_url=' $configUrl`
reoportdata_url=${reoportdata_mysql_url##*=}
sqoop_mysql_url=`grep 'sqoop_exp_IP=' $configUrl`
mysql_url=${sqoop_mysql_url#*=}
sqoop_mysql_user=`grep 'sqoop_exp_USER=' $configUrl`
mysql_user=${sqoop_mysql_user##*=}
sqoop_mysql_password=`grep 'sqoop_exp_PW=' $configUrl`
mysql_password=${sqoop_mysql_password##*=}

hive_data=tubobo_reportdata  
hive_table=express_appointment_order_status_info
export_dir=/user/hive/warehouse/${hive_data}.db/${hive_table}
echo ${export_dir}
sqoop_table=appointment_order_status_info

#mysql -h${reoportdata_url} -P3306 -u${mysql_user} -p${mysql_password} $report  -e "truncate table report.${sqoop_table}"
source /etc/profile
sqoop export --connect ${mysql_url} --table ${sqoop_table} --export-dir ${export_dir}/day=${start_date}  --username ${mysql_user} -password ${mysql_password} -m 1 --fields-terminated-by '\001' --input-null-string '\\N' --input-null-non-string '\\N' --columns "create_time,Province,City,create_order,big_bag,common_bag,init_order,cancel_order,waiting_grab_order,waiting_pick_order,deliverying_order,close_order,finish_order,other_order,grab_overtime_cancel,grab_sender_cancel,pay_overtime_cancel,admin_cancel,pay_sender_cancel,pick_rider_cancel,store_cancel,other_cancel"
