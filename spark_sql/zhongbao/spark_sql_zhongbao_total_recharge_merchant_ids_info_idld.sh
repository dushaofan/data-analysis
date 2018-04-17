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
insert overwrite table tubobo_reportdata.zhongbao_total_recharge_merchant_ids_info partition (day='${start_date}')
select 
'${start_date}' as create_date,
b.address_province as province,
b.address_city as city,
a.account_id as total_recharge_merchant_ids
from 
(SELECT account_id from ds_tubobo_account.bas_t_account_ops_pd where day='${start_date}' and type='100' and status='1' and  target='300' group by account_id) a
join 
(select account_id,address_province,address_city from ds_tubobo_merchant.bas_tubobo_merchant_info_pd  where day='${start_date}') b
on a.account_id=b.account_id;"
