use mongo_tmp_tubobo_express;
alter table mongo_tmp_tubobo_express.employeeentity set location '/apps/hive/warehouse/tubobo_express.mongo/EmployeeEntity/';

insert overwrite table ds_tubobo_express.bas_employeeentity_idld
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