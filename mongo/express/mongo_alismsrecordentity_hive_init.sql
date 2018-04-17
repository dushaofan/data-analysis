use mongo_tmp_tubobo_express;
create table alismsrecordentity
(
id                       String   
,appId                    String   
,aliSmsId                 String   
,aliSignName              String   
,smsType                  String   
,storeId                  String   
,operator                 String   
,immediate                String   
,phone                    String   
,jsonParams               String   
,smsStatus                String   
,bizId                    String   
,bizResultCode            String   
,bizSuccesstrue           String   
,bizMsg                   String   
,taobaoResponseErrorCode  String   
,taobaoResponseMsg        String   
,taobaoResponseSubCode    String   
,taobaoResponseSubMsg     String   
,sendTime                 String   
,receiverTime             String   
,createDate               Timestamp
,updateDate               Timestamp
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id","appId":"appId","aliSmsId":"aliSmsId","aliSignName":"aliSignName","smsType":"smsType","storeId":"storeId","operator":"operator","immediate":"immediate","phone":"phone","jsonParams":"jsonParams","smsStatus":"smsStatus","bizId":"bizId","bizResultCode":"bizResultCode","bizSuccesstrue":"bizSuccesstrue","bizMsg":"bizMsg","taobaoResponseErrorCode":"taobaoResponseErrorCode","taobaoResponseMsg":"taobaoResponseMsg","taobaoResponseSubCode":"taobaoResponseSubCode","taobaoResponseSubMsg":"taobaoResponseSubMsg","sendTime":"sendTime","receiverTime":"receiverTime","createDate":"createDate","updateDate":"updateDate"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/AliSmsRecordEntity/';