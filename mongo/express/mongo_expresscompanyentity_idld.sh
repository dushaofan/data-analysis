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
table=ExpressCompanyEntity
hdfs_path=/apps/hive/warehouse/tubobo_express.mongo/${table}/
#download-mongo-to-loacal-path
source /etc/profile
#mongodump -h ${connect_url} -d ${database} -c ExpressCompanyEntity 
mongodump -h ${connect_url} -u ${username} -p ${password}  -d ${database} -c ${table}

#删除旧的文件目录
source /etc/profile
hadoop fs -rmr ${hdfs_path};
#创建新的HDFS路径存放临时文件
hadoop fs -mkdir ${hdfs_path};
#把本地文件存放在HDFS临时目类下
hadoop fs -put ${local_path}/dump/${database}/${table}.bson  ${hdfs_path}
source /etc/profile
#把增量数据覆写在原表中
hive -f /xinguang/mongo/express/mongo_expresscompanyentity_hive_idld.sql
#把增量数据覆写在增量表中
hive -e "
insert overwrite table ds_tubobo_express.bas_expresscompanyentity_idld
select 
 a.companyId        
,a.companyName      
,a.contractPhone    
,a.regularExpression
,a.createDate       
,a.createBy         
,a.updateDate       
,a.updateBy
from mongo_tmp_tubobo_express.expresscompanyentity a;"
#把增量数据插入到全量表中，按照天分区存储
spark-sql --master ${spark_url} -e "
insert overwrite table ds_tubobo_express.bas_expresscompanyentity_pd partition(day='${start_date}')
select * from ds_tubobo_express.bas_expresscompanyentity_idld;"

