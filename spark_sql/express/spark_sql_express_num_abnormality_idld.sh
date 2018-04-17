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

spark-sql --master ${spark_url} -e "
insert overwrite table tubobo_reportdata.tubobo_express_num_abnormality partition (day='${start_date}')
select 
 a.create_date
,a.area_code
,a.store_name
,a.store_id
,a.service_provider_name
,a.area
,a.express_in_num
,b.yesterday_in_num
,round(case when b.yesterday_in_num='0' and (a.express_in_num-b.yesterday_in_num)=0 then '0' 
            when (a.express_in_num-b.yesterday_in_num)>'0' then (a.express_in_num-b.yesterday_in_num)/b.yesterday_in_num  else '0' end,2) as yesterday_increase
,round(case when (a.express_in_num-b.yesterday_in_num)<'0' then (a.express_in_num-b.yesterday_in_num)/b.yesterday_in_num else '0' end,2) as yesterday_reduce
from
(select to_date(date) as create_date,store_name,store_id,service_provider_name,area,express_in_num,area_code
from tubobo_reportdata.tubobo_express_store_info where day='${start_date}') a 
join 
(select date_add(to_date(date),1) as before_date,store_id,express_in_num as yesterday_in_num from 
tubobo_reportdata.tubobo_express_store_info where day='${two_date_ago}')b on a.store_id=b.store_id and a.create_date=b.before_date;"

