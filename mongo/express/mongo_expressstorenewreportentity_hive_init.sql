use mongo_tmp_tubobo_express;
create table mongo_tmp_tubobo_express.expressstorenewreportentity
(
id                       String   
,areaCode                String   
,`date`                    String   
,provinceCode            String   
,cityCode                String   
,districtCode            String   
,area                    String   
,storeId                 String   
,storeName               String   
,joinTime                Timestamp
,serviceProviderId       String   
,serviceProviderName     String   
,createDate              Timestamp
,updateDate              Timestamp
,province                String   
,city                    String   
,district                String   
,latitude                String   
,Stringitude             String   
,latitudeAndStringitude  String   
,expressInNum            String   
,expressSignNum          String   
,todayExpressSignNum     String   
,sendMessageNum          String   
,totalSendMessageNum     String   
,stagnationNum           String   
,expressCompanyNum       String   
,expressCompany          String   
,YesterdayIncrease       String   
,YesterdayReduce         String   
,YesterdayInNum          String              
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id","areaCode":"areaCode","date":"date","provinceCode":"provinceCode","cityCode":"cityCode","districtCode":"districtCode","area":"area","storeId":"storeId","storeName":"storeName","joinTime":"joinTime","serviceProviderId":"serviceProviderId","serviceProviderName":"serviceProviderName","createDate":"createDate","updateDate":"updateDate","province":"province","city":"city","district":"district","latitude":"latitude","Stringitude":"Stringitude","latitudeAndStringitude":"latitudeAndStringitude","expressInNum":"expressInNum","expressSignNum":"expressSignNum","todayExpressSignNum":"todayExpressSignNum","sendMessageNum":"sendMessageNum","totalSendMessageNum":"totalSendMessageNum","stagnationNum":"stagnationNum","expressCompanyNum":"expressCompanyNum","expressCompany":"expressCompany","YesterdayIncrease":"YesterdayIncrease","YesterdayReduce":"YesterdayReduce","YesterdayInNum":"YesterdayInNum"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/ExpressStoreNewReportEntity/';

insert overwrite table ds_tubobo_express.bas_expressstorenewreportentity_init
select
 a.id                      
,a.areacode                
,a.`date`                  
,a.provincecode            
,a.citycode                
,a.districtcode            
,a.area                    
,a.storeid                 
,a.storename               
,a.jointime                
,a.serviceproviderid       
,a.serviceprovidername     
,a.createdate              
,a.updatedate              
,a.province                
,a.city                    
,a.district                
,a.latitude                
,a.stringitude             
,a.latitudeandstringitude  
,a.expressinnum            
,a.expresssignnum          
,a.todayexpresssignnum     
,a.sendmessagenum          
,a.totalsendmessagenum     
,a.stagnationnum           
,a.expresscompanynum       
,a.expresscompany          
,a.yesterdayincrease       
,a.yesterdayreduce         
,a.yesterdayinnum          
from mongo_tmp_tubobo_express.expressstorenewreportentity a;