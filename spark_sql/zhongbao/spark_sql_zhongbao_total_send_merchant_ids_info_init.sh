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
insert overwrite table tubobo_reportdata.zhongbao_total_send_merchant_ids_info partition (day='${two_start_date}')
select
a.create_date,
b.address_province as province,
b.address_city as city,
b.user_id as total_send_merchant_ids
from
(select user_id,to_date(create_date) as create_date from ds_tubobo_merchant.bas_tubobo_order_pd 
where day='${two_start_date}' group by to_date(create_date),user_id)a
join 
(select user_id,address_province,address_city from ds_tubobo_merchant.bas_tubobo_merchant_info_pd where day='${two_start_date}') b
on a.user_id=b.user_id;"
