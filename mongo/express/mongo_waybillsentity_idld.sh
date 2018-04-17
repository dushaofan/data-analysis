#!bin/sh
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
table=WayBillSEntity
hdfs_path=/apps/hive/warehouse/tubobo_express.mongo/${table}/
#download-mongo-to-loacal-path
source /etc/profile
#mongodump -h ${connect_url} -d express-admin -c WayBillSEntity -q "{'updateDate':{\$gte:Date(${begin_time_8}),\$lt:Date(${end_time_8})}}"
mongodump -h ${connect_url} -u ${username} -p ${password}  -d ${database} -c ${table}  -q "{'updateDate':{\$gte:Date('${begin_time_8}'),\$lte:Date('${end_time_8}')}}"

#删除旧的文件目录
source /etc/profile
hadoop fs -rmr ${hdfs_path};
#创建HDFS临时路径
hadoop fs -mkdir ${hdfs_path};
#把本地数据上传到HDFS临时路径
hadoop fs -put ${local_path}/dump/${database}/${table}.bson  ${hdfs_path}
#把临时路径下的数据load到原表
source /etc/profile
hive -f /xinguang/mongo/express/mongo_waybillsentity_hive_idld.sql
#把原表数据写入到初始化表中
spark-sql --master ${spark_url} -e "
insert overwrite table ds_tubobo_express.bas_waybillsentity_pd 
select
 id              
,waybillNo       
,waybillStatus   
,remainStatus    
,fromRemainFlag  
,remainReason    
,returnBackReason
,normalUserId    
,expressCompany  
,belongStore     
,inTime          
,inOperator      
,outTime         
,outOperator     
,signTime        
,signOperator    
,returnTime      
,returnOperator  
,updateOperator  
,areaNum         
,areaNumShow     
,pickupType      
,dispatchingWay  
,evaluationFlag  
,appointTime     
,equipmentId     
,equipmentName   
,equipmentTemp   
,senderName      
,senderPhone     
,senderAddress   
,receiverName    
,receiverPhone   
,receiverAddress 
,paymentMethod   
,shipment        
,insurePrice     
,weight          
,payment         
,payFreight      
,sendSmsDay      
,unNoticeFlag    
,remark          
,delFlag         
,createDate      
,createBy        
,updateDate      
,updateBy        
from
(select
 a.id              
,a.waybillNo       
,a.waybillStatus   
,a.remainStatus    
,a.fromRemainFlag  
,a.remainReason    
,a.returnBackReason
,a.normalUserId    
,a.expressCompany  
,a.belongStore     
,a.inTime          
,a.inOperator      
,a.outTime         
,a.outOperator     
,a.signTime        
,a.signOperator    
,a.returnTime      
,a.returnOperator  
,a.updateOperator  
,a.areaNum         
,a.areaNumShow     
,a.pickupType      
,a.dispatchingWay  
,a.evaluationFlag  
,a.appointTime     
,a.equipmentId     
,a.equipmentName   
,a.equipmentTemp   
,a.senderName      
,a.senderPhone     
,a.senderAddress   
,a.receiverName    
,a.receiverPhone   
,a.receiverAddress 
,a.paymentMethod   
,a.shipment        
,a.insurePrice     
,a.weight          
,a.payment         
,a.payFreight      
,a.sendSmsDay      
,a.unNoticeFlag    
,a.remark          
,a.delFlag         
,a.createDate      
,a.createBy        
,a.updateDate      
,a.updateBy        
from 
(select * from ds_tubobo_express.bas_waybillsentity_pd) a
left join 
(select * from ds_tubobo_express.bas_waybillsentity_idld) b on a.id=b.id where b.id is null)
union all 
select * from ds_tubobo_express.bas_waybillsentity_idld;"
