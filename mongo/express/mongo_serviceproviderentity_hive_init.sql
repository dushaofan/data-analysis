use mongo_tmp_tubobo_express;
create table serviceproviderentity
(
 id             String   
,phone          String   
,name           String   
,password       String   
,serviceCode    String   
,serviceName    String   
,serviceStatus  String   
,provinceCode   String   
,province       String   
,cityCode       String   
,city           String   
,districtCode   String   
,district       String   
,createDate     Timestamp
,createBy       String   
,updateDate     Timestamp
,updateBy       String   
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id","phone":"phone","name":"name","password":"password","serviceCode":"serviceCode","serviceName":"serviceName","serviceStatus":"serviceStatus","provinceCode":"provinceCode","province":"province","cityCode":"cityCode","city":"city","districtCode":"districtCode","district":"district","createDate":"createDate","createBy":"createBy","updateDate":"updateDate","updateBy":"updateBy"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/ServiceProviderEntity/';
