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
insert overwrite table da_tubobo_express.bas_storeentity_and_ues_create_date partition (day='${start_date}')
select 
a.create_date
,b.storeId                 
,b.storeName               
,b.storeInfoStatus         
,b.service                 
,b.lastStoreStatus         
,b.storeStatus             
,b.areaNumType             
,b.storeType               
,b.storeSource             
,b.storeBusiness           
,b.storeArea               
,b.expressCompanyList      
,b.storeCode               
,b.storeManageName         
,b.storePhone              
,b.telephone               
,b.alipayAccount           
,b.provinceCode            
,b.province                
,b.cityCode                
,b.city                    
,b.districtCode            
,b.district                
,b.storeAddressDetail      
,b.longitude               
,b.latitude                
,b.picUrlStore             
,b.picUrlLicense           
,b.picUrlOne               
,b.serviceTimeStart        
,b.serviceTimeEnd          
,b.pickUpType              
,b.workFlowId              
,b.enterGuideStatus        
,b.paid                    
,b.accountId               
,b.appointServiceOpened    
,b.applyContent            
,b.applyDate               
,b.createDate              
,b.createBy                
,b.updateDate              
,b.updateBy                
,b.appointServiceFlowId    
,b.appointServiceStatus    
,b.auditStatus             
,b.auditType               
,b.auditDate               
,b.auditWorkFlowId         
,b.auditFlag               
from 
(select create_date from ds_tubobo_express.ues_create_date where to_date(create_date)<'${today_date}') a 
CROSS join 
(select * from ds_tubobo_express.bas_storeentity_pd where day='${start_date}') b ;"