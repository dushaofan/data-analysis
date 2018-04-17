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

spark-sql --master ${spark_url} -e "
insert overwrite table tubobo_reportdata.zhongbao_total_receiver_rider_ids_info partition (day='${start_date}')
select
'${start_date}' as create_date,
b.province,
b.city,
b.user_id as total_receiver_rider_ids
from
(select rider_id from ds_tubobo_merchant.bas_tubobo_order_pd where day='${start_date}' and to_date(grab_order_time)='${start_date}' group by rider_id)a
join 
(select user_id,split(pcd_name,' ')[0] as province,split(pcd_name,' ')[1] as city from ds_tubobo_rider.bas_tubobo_rider_info_pd where day='${start_date}') b
on a.rider_id=b.user_id;"
