create database IF NOT EXISTS ds_tubobo_express;
use ds_tubobo_express;
create table bas_employeeentity_init
(
id                     String               comment "序列ID",
employeeCode           String               comment "骑手编号",
phone                  String               comment "骑手电话",    
name                   String               comment "骑手人",      
employeeType           String               comment "骑手类型",
password               String               comment "账号密码",
initPasswdChange       String               comment "初始密码修改过为true",  
belongStore	           String               comment "所属门店",  
delFlag                String               comment "删除1,有效0",   
idCard                 String               comment "骑手身份证号码",  
riderStatus            String               comment "骑手状态",  
riderDelFlag           String               comment "冻结状态",   
workFlowId             String               comment "骑手审核工作流id",   
provinceCode           String               comment "省Code",   
cityCode               String               comment "市Code",   
createDate             Timestamp            comment "创建时间",
createBy               String               comment "创建者",
updateDate             Timestamp            comment "更新时间",
updateBy               String               comment "更新者"
)
comment '骑手信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_employeeentity_idld
(
id                     String               comment "序列ID",
employeeCode           String               comment "骑手编号",
phone                  String               comment "骑手电话",    
name                   String               comment "骑手人",      
employeeType           String               comment "骑手类型",
password               String               comment "账号密码",
initPasswdChange       String               comment "初始密码修改过为true",  
belongStore	           String               comment "所属门店",  
delFlag                String               comment "删除1,有效0",   
idCard                 String               comment "骑手身份证号码",  
riderStatus            String               comment "骑手状态",  
riderDelFlag           String               comment "冻结状态",   
workFlowId             String               comment "骑手审核工作流id",   
provinceCode           String               comment "省Code",   
cityCode               String               comment "市Code",   
createDate             Timestamp            comment "创建时间",
createBy               String               comment "创建者",
updateDate             Timestamp            comment "更新时间",
updateBy               String               comment "更新者"
)
comment '骑手信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_employeeentity_pd
(
id                     String               comment "序列ID",
employeeCode           String               comment "骑手编号",
phone                  String               comment "骑手电话",    
name                   String               comment "骑手人",      
employeeType           String               comment "骑手类型",
password               String               comment "账号密码",
initPasswdChange       String               comment "初始密码修改过为true",  
belongStore	           String               comment "所属门店",  
delFlag                String               comment "删除1,有效0",   
idCard                 String               comment "骑手身份证号码",  
riderStatus            String               comment "骑手状态",  
riderDelFlag           String               comment "冻结状态",   
workFlowId             String               comment "骑手审核工作流id",   
provinceCode           String               comment "省Code",   
cityCode               String               comment "市Code",   
createDate             Timestamp            comment "创建时间",
createBy               String               comment "创建者",
updateDate             Timestamp            comment "更新时间",
updateBy               String               comment "更新者"
)
comment '骑手信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;