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
insert overwrite table tubobo_reportdata.tubobo_express_num_abnormality partition (day='${two_start_date}')
select
 a.createDate            as   create_date          
,a.areaCode              as   area_code            
,a.storeName             as   store_name           
,a.storeId               as   store_id             
,a.serviceProviderName   as   service_provider_name
,a.area                  as   area                 
,a.expressInNum          as   express_in_num       
,a.YesterdayInNum        as   yesterday_in_num     
,a.YesterdayIncrease     as   yesterday_increase   
,a.YesterdayReduce       as   yesterday_reduce     
from ds_tubobo_express.bas_expressstorenewreportentity_init a;"

