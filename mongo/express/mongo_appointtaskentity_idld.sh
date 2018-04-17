#!/bin/sh
#date
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
#dump-path
local_path=`pwd`
#mongo数据库信息
connect=`grep 'mongo_express_IP=' $configUrl`
connect_url=${connect##*=}
user=`grep 'mongo_express_USER=' $configUrl`
username=${user##*=}
pw=`grep 'mongo_express_PW=' $configUrl`
password=${pw##*=}
db_name=`grep 'mongo_db=' $configUrl`
database=${db_name##*=}
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
table=AppointTaskEntity
hdfs_path=/apps/hive/warehouse/tubobo_express.mongo/${table}/
#download-mongo-to-loacal-path
source /etc/profile
#mongodump -h ${connect_url} -d ${database} -c ${table} -q "{'updateDate':{\$gte:Date(${begin_time_8}),\$lt:Date(${end_time_8})}}"
mongodump -h ${connect_url} -u ${username} -p ${password}  -d express-admin -c ${table} -q "{'updateDate':{\$gte:Date(${begin_time_8}),\$lt:Date(${end_time_8})}}"
#删除旧的文件目录
source /etc/profile
hadoop fs -rmr ${hdfs_path};
hadoop fs -mkdir -p ${hdfs_path};

hadoop fs -put ${local_path}/dump/${database}/${table}.bson  ${hdfs_path}
source /etc/profile

hive -f /xinguang/mongo/express/mongo_appointtaskentity_hive_idld.sql

hive -e "
insert overwrite table ds_tubobo_express.bas_appointtaskentity_idld
select 
 a.id                       
,a.taskNo                   
,a.taskType
,a.normalUserId        
,a.store           
,a.operator            
,a.wayBillS                 
,a.wayBillR                 
,a.senderName         
,a.senderPhone         
,a.senderPcdCode        
,a.senderPcdName        
,a.senderAddress         
,a.receiverName         
,a.receiverPhone         
,a.receiverPcdCode    
,a.receiverPcdName    
,a.receiverAddress        
,a.appointTime     
,a.appointTimeType    
,a.finishTime         
,a.shipment         
,a.insureFlag         
,a.insurePrice     
,a.weight          
,a.size          
,a.source                
,a.remark          
,a.bigPackage         
,a.payment      
,a.payFreight         
,a.evaluationFlag        
,a.delFlag                  
,a.createDate            
,a.createBy          
,a.updateDate      
,a.updateBy       
,a.senderAddressProvince    
,a.senderAddressCity        
,a.senderAddressDistrict    
,a.senderAddressStreet      
,a.senderAddressRoomNo      
,a.senderAddressDetail      
,a.receiverAddressProvince  
,a.receiverAddressCity      
,a.receiverAddressDistrict  
,a.receiverAddressStreet    
,a.receiverAddressRoomNo    
,a.receiverAddressDetail    
,a.senderLongitude          
,a.senderLatitude           
,a.receiverLongitude        
,a.receiverLatitude         
,a.deliveryDistance    
,a.pickUpDistance     
,a.orderTime     
,a.acceptTime      
,a.pickTime     
,a.cancelTime      
,a.peekOverFee    
,a.weatherOverFee     
,a.platformSubsidyFee    
,a.bigParcelFee    
,a.payDoor     
,a.payDistribution   
,a.cancelCompensation   
,a.cancelFine           
,a.cancelReason           
,a.sendStatus      
,a.sendType      
,a.sendCode      
,a.distributionStatus    
,a.distributionType    
,a.pickupCode      
,a.areaNum     
,a.paidFlag      
,a.refundFlag      
,a.printFlag      
,a.commonFlag      
,a.riderFlag      
,a.payId       
,a.expressCompanyId    
,a.senderAdcode
,a.cityCode
from mongo_tmp_tubobo_express.appointtaskentity a;"

spark-sql --master ${spark_url} -e "
insert overwrite table ds_tubobo_express.bas_appointtaskentity_pd partition (day='${start_date}')
select * from ds_tubobo_express.bas_appointtaskentity_idld;"




