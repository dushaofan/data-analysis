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
insert overwrite table tubobo_reportdata.zhongbao_merchant_order_heat_entity partition(day='${two_start_date}')
select 
a.create_date                    ,
b.address_province  as province  ,
b.address_city      as city      ,
b.address_district  as district  ,
b.longitude                      ,
b.latitude                       ,
a.finish_num ,
a.cancel_num 
from 
(select 
user_id,
to_date(create_date) as create_date,
count(case when order_status='FINISH' then '1' end) as finish_num ,
count(case when order_status in ('CANCEL','RESEND') then '1' end) as cancel_num 
from ds_tubobo_merchant.bas_tubobo_order_pd  where day='${two_start_date}' group by user_id,to_date(create_date)) a 
join 
(select user_id,address_province,address_city,address_district,longitude,latitude 
from ds_tubobo_merchant.bas_tubobo_merchant_info_pd where day='${two_start_date}')b  on a.user_id=b.user_id;"

