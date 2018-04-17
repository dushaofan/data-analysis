use mongo_tmp_tubobo_express;
create table employeeentity
(
 id                     String            
,employeeCode           String            
,phone                  String            
,name                   String            
,employeeType           String            
,password               String            
,initPasswdChange       String            
,belongStore            map<string,string>
,delFlag                String            
,idCard                 String            
,riderStatus            String            
,riderDelFlag           String            
,workFlowId             String            
,provinceCode           String            
,cityCode               String            
,createDate             Timestamp         
,createBy               String            
,updateDate             Timestamp         
,updateBy               String            
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id","employeeCode":"employeeCode","phone" :"phone" ,"name":"name","employeeType":"employeeType","password":"password","initPasswdChange":"initPasswdChange","belongStore":"belongStore","delFlag":"delFlag","idCard":"idCard","riderStatus":"riderStatus","riderDelFlag":"riderDelFlag","workFlowId":"workFlowId","provinceCode":"provinceCode","cityCode":"cityCode","createDate":"createDate","createBy":"createBy","updateDate":"updateDate","updateBy":"updateBy"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/EmployeeEntity/';

insert overwrite table ds_tubobo_express.bas_employeeentity_init
select 
 a.id                as id                
,a.employeeCode      as employeeCode    
,a.phone             as phone
,a.name              as name
,a.employeeType      as employeeType    
,a.password          as password        
,a.initPasswdChange  as initPasswdChange
,a.belongStore['$id']  as belongStore
,a.delFlag           as delFlag         
,a.idCard            as idCard          
,a.riderStatus       as riderStatus     
,a.riderDelFlag      as riderDelFlag    
,a.workFlowId        as workFlowId      
,a.provinceCode      as provinceCode    
,a.cityCode          as cityCode        
,a.createDate        as createDate      
,a.createBy          as createBy        
,a.updateDate        as updateDate      
,a.updateBy          as updateBy        
from mongo_tmp_tubobo_express.employeeentity a;
