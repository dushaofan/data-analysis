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

source /etc/profile
spark-sql --master ${spark_url} -e "
insert overwrite table tubobo_reportdata.express_appointment_order_status_info partition (day='${start_date}')
select 
to_date(createDate) as create_time,                                                                             
receiverAddressProvince as Province,                                                                        
receiverAddressCity as City,
count(1) as create_order,                                                                                       
count(case when bigPackage='true' then 'big_bag' end) as big_bag,                                               
count(case when bigPackage='false' then 'common_bag' end) as common_bag,                                        
count(case when distributionStatus='INIT' then 'INIT' end) as init_order,
count(case when distributionStatus='CANCEL' then 'CANCEL' end) as cancel_order,                                   
count(case when distributionStatus='RECEIVE' then 'WAITING_GRAB' end) as waiting_grab_order,               
count(case when distributionStatus='WAITING_PICK' then 'WAITING_PICK' end) as waiting_pick_order,               
count(case when distributionStatus in ('DISTRIBUTION','PICKUP') then 'DISTRIBUTION' end) as deliverying_order,                  
count(case when distributionStatus='CLOSE' then 'CLOSE' end) as close_order,                                    
count(case when distributionStatus='FINISH' then 'FINISH' end) as finish_order,                                 
count(case when distributionStatus is null  then 'other' end) as other_order,                                   
count(case when cancelReason='GRAB_OVERTIME_CANCEL' then 'grab_overtime_cancel' end) as grab_overtime_cancel,   
count(case when cancelReason='GRAB_SENDER_CANCEL' then 'grab_sender_cancel' end) as grab_sender_cancel,         
count(case when cancelReason='PAY_OVERTIME_CANCEL' then 'pay_overtime_cancel' end) as pay_overtime_cancel,      
count(case when cancelReason='ADMIN_CANCEL' then 'admin_cancel' end) as admin_cancel,                           
count(case when cancelReason='PAY_SENDER_CANCEL' then 'pay_sender_cancel' end) as pay_sender_cancel,            
count(case when cancelReason='PICK_RIDER_CANCEL' then 'pick_rider_cancel' end) as pick_rider_cancel,            
count(case when cancelReason='STORE_CANCEL' then 'STORE_CANCEL' end) as store_cancel,                           
count(case when cancelReason is null  then 'other' end) as other_cancel                                      
from ds_tubobo_express.bas_appointtaskentity_pd where day='${start_date}' and taskType='DISTRIBUTION'
group by to_date(createDate),receiverAddressProvince,receiverAddressCity;"

