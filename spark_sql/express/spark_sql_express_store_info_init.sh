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
insert overwrite table tubobo_reportdata.tubobo_express_store_info partition (day='${two_start_date}')
select 
a.areaCode                   as      area_code             
,a.date                      as      date              
,a.provinceCode              as      province_code         
,a.cityCode                  as      city_code             
,a.districtCode              as      district_code         
,a.area                      as      area                  
,a.storeId                   as      store_id              
,a.storeName                 as      store_name            
,a.joinTime                  as      join_time             
,a.serviceProviderId         as      service_provider_id   
,a.serviceProviderName       as      service_provider_name 
,a.province                  as      province              
,a.city                      as      city                  
,a.district                  as      district              
,a.latitude                  as      latitude              
,a.Stringitude               as      longitude             
,a.latitudeAndStringitude    as      latitude_and_longitude
,a.expressInNum              as      express_in_num        
,a.expressSignNum            as      express_sign_num      
,a.todayExpressSignNum       as      today_express_sign_num
,a.sendMessageNum            as      send_message_num      
,a.totalSendMessageNum       as      total_send_message_num
,a.stagnationNum             as      stagnation_num        
,a.expressCompanyNum         as      express_company_num   
,a.expressCompany            as      express_company       
from ds_tubobo_express.bas_expressstorenewreportentity_init a;"
