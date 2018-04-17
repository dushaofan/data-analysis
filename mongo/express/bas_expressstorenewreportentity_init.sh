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
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}
table=ExpressStoreNewReportEntity
hdfs_path=/apps/hive/warehouse/tubobo_express.mongo/${table}/
#download-mongo-to-loacal-path
source /etc/profile
#mongodump -h ${connect_url} -d tubobo-reportdata -c ExpressStoreNewReportEntity 
mongodump -h dds-uf6af3093566bfc41.mongodb.rds.aliyuncs.com:3717 -u reportdata -p reportdata_root  -d tubobo-reportdata -c ${table} 

#删除旧的文件目录
source /etc/profile
hadoop fs -rmr ${hdfs_path};
#创建HDFS临时路径
hadoop fs -mkdir ${hdfs_path};
#把本地文件存放在HDFS临时路径
hadoop fs -put ${local_path}/dump/tubobo-reportdata/${table}.bson  ${hdfs_path}
source /etc/profile
#把HDFS临时文件写入到初始化表中
hive -f /xinguang/mongo/express/mongo_expressstorenewreportentity_hive_init.sql

