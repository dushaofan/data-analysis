use mongo_tmp_tubobo_express;
create table expresscompanyentity
(
 companyId           String    
,companyName         String    
,contractPhone       String    
,regularExpression   String    
,createDate          Timestamp 
,createBy            String    
,updateDate          Timestamp 
,updateBy            String    
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"companyId":"_id","companyName":"companyName","contractPhone":"contractPhone","regularExpression":"regularExpression","createDate":"createDate","createBy":"createBy","updateDate":"updateDate","updateBy":"updateBy"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/ExpressCompanyEntity/';