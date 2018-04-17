use mongo_tmp_tubobo_express;
alter table mongo_tmp_tubobo_express.storeentity set location '/apps/hive/warehouse/tubobo_express.mongo/StoreEntity/';

insert overwrite table  ds_tubobo_express.bas_storeentity_idld 
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
from mongo_tmp_tubobo_express.storeentity a ;