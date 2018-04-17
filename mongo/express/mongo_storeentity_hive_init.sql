use mongo_tmp_tubobo_express;
create table mongo_tmp_tubobo_express.storeentity
(
 storeId                      String                   
,storeName                    String                   
,storeInfoStatus              String                   
,service                      map<string,string>       
,lastStoreStatus              String                   
,storeStatus                  String                   
,areaNumType                  int                      
,storeType                    String                   
,storeSource                  String                   
,storeBusiness                String                   
,storeArea                    String                   
,expressCompanyList           array<map<string,string>>
,storeCode                    String                   
,storeManageName              String                   
,storePhone                   String                   
,telephone                    String                   
,alipayAccount                String                   
,provinceCode                 String                   
,province                     String                   
,cityCode                     String                   
,city                         String                   
,districtCode                 String                   
,district                     String                   
,storeAddressDetail           String                   
,longitude                    String                   
,latitude                     String                   
,picUrlStore                  String                   
,picUrlLicense                String                   
,picUrlOne                    String                   
,serviceTimeStart             String                   
,serviceTimeEnd               String                   
,pickUpType                   String                   
,workFlowId                   String                   
,enterGuideStatus             String                   
,paid                         String                   
,accountId                    String                   
,appointServiceOpened         String                   
,applyContent                 String                   
,applyDate                    Timestamp                
,createDate                   Timestamp                
,createBy                     String                   
,updateDate                   Timestamp                
,updateBy                     String                   
,appointServiceFlowId         String                   
,appointServiceStatus         String                   
,auditStatus                  String                   
,auditType                    String                   
,auditDate                    Timestamp                
,auditWorkFlowId              String                   
,auditFlag                    String                  
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"storeId":"_id","storeName":"storeName","storeInfoStatus":"storeInfoStatus","service":"service","lastStoreStatus":"lastStoreStatus","storeStatus":"storeStatus","areaNumType":"areaNumType","storeType":"storeType","storeSource":"storeSource","storeBusiness":"storeBusiness","storeArea":"storeArea","expressCompanyList":"expressCompanyList","storeCode":"storeCode","storeManageName":"storeManageName","storePhone":"storePhone","telephone":"telephone","alipayAccount":"alipayAccount","provinceCode":"provinceCode","province":"province","cityCode":"cityCode","city":"city","districtCode":"districtCode","district":"district","storeAddressDetail":"storeAddressDetail","longitude":"longitude","latitude":"latitude","picUrlStore":"picUrlStore","picUrlLicense":"picUrlLicense","picUrlOne":"picUrlOne","serviceTimeStart":"serviceTimeStart","serviceTimeEnd":"serviceTimeEnd","pickUpType":"pickUpType","workFlowId":"workFlowId","enterGuideStatus":"enterGuideStatus","paid":"paid","accountId":"accountId","appointServiceOpened":"appointServiceOpened","applyContent":"applyContent","applyDate":"applyDate","createDate":"createDate","createBy":"createBy","updateDate":"updateDate","updateBy":"updateBy","appointServiceFlowId":"appointServiceFlowId","appointServiceStatus":"appointServiceStatus","auditStatus":"auditStatus","auditType":"auditType","auditDate":"auditDate","auditWorkFlowId":"auditWorkFlowId","auditFlag":"auditFlag"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/StoreEntity/';

insert overwrite table  ds_tubobo_express.bas_storeentity_init
select 
 a.storeId                    as storeId               
,a.storeName                  as storeName             
,a.storeInfoStatus            as storeInfoStatus       
,a.service['$id']             as service               
,a.lastStoreStatus            as lastStoreStatus       
,a.storeStatus                as storeStatus           
,a.areaNumType                as areaNumType           
,a.storeType                  as storeType             
,a.storeSource                as storeSource           
,a.storeBusiness              as storeBusiness         
,a.storeArea                  as storeArea             
,a.expressCompanyList         as expressCompanyList    
,a.storeCode                  as storeCode             
,a.storeManageName            as storeManageName       
,a.storePhone                 as storePhone            
,a.telephone                  as telephone             
,a.alipayAccount              as alipayAccount         
,a.provinceCode               as provinceCode          
,a.province                   as province              
,a.cityCode                   as cityCode              
,a.city                       as city                  
,a.districtCode               as districtCode          
,a.district                   as district              
,a.storeAddressDetail         as storeAddressDetail    
,a.longitude                  as longitude             
,a.latitude                   as latitude              
,a.picUrlStore                as picUrlStore           
,a.picUrlLicense              as picUrlLicense         
,a.picUrlOne                  as picUrlOne             
,a.serviceTimeStart           as serviceTimeStart      
,a.serviceTimeEnd             as serviceTimeEnd        
,a.pickUpType                 as pickUpType            
,a.workFlowId                 as workFlowId            
,a.enterGuideStatus           as enterGuideStatus      
,a.paid                       as paid                  
,a.accountId                  as accountId             
,a.appointServiceOpened       as appointServiceOpened  
,a.applyContent               as applyContent          
,a.applyDate                  as applyDate             
,a.createDate                 as createDate            
,a.createBy                   as createBy              
,a.updateDate                 as updateDate            
,a.updateBy                   as updateBy              
,a.appointServiceFlowId       as appointServiceFlowId  
,a.appointServiceStatus       as appointServiceStatus  
,a.auditStatus                as auditStatus           
,a.auditType                  as auditType             
,a.auditDate                  as auditDate             
,a.auditWorkFlowId            as auditWorkFlowId       
,a.auditFlag                  as auditFlag
from mongo_tmp_tubobo_express.storeentity a;
