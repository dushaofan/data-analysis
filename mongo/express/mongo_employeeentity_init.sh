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
table=EmployeeEntity
hdfs_path=/apps/hive/warehouse/tubobo_express.mongo/${table}/
#download-mongo-to-loacal-path
source /etc/profile
#mongodump -h ${connect_url} -d express-admin -c EmployeeEntity 
mongodump -h ${connect_url} -u ${username} -p ${password}  -d ${database} -c ${table} 

source /etc/profile
#删除旧的文件目录
hadoop fs -rm -r ${hdfs_path};
source /etc/profile
#创建HDFS临时路径
hadoop fs -mkdir ${hdfs_path};
source /etc/profile
#把本地文件上传到HDFS临时路径
hadoop fs -put ${local_path}/dump/${database}/${table}.bson  ${hdfs_path}
source /etc/profile
#把临时路径的数据写入到hive原表中
hive -f /xinguang/mongo/express/mongo_employeeentity_hive_init.sql
#从原表提取数据到初始化表中，这一步把map 的id取出 .belongStore[$id] [] 只能在hive中执行，不能在spark执行

#把初始化数据存放在全量表中，按天分区存储
spark-sql --master ${spark_url}  -e "
insert overwrite table ds_tubobo_express.bas_employeeentity_pd partition(day='${two_start_date}')
select * from ds_tubobo_express.bas_employeeentity_init;" 


