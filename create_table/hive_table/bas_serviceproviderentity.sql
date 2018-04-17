create database IF NOT EXISTS ds_tubobo_express;
use  ds_tubobo_express;
create table bas_serviceproviderentity_init
(
id             String       comment "序列ID",
phone          String       comment "联系电话",  
name           String       comment "联系人", 
password       String       comment "密码",
serviceCode    String       comment "服务商编号",        
serviceName    String       comment "服务商名称",        
serviceStatus  String       comment "服务商状态,成功:SUCCESS 失败:FAIL 审核中:INIT",      
provinceCode   String       comment "省code",     
province       String       comment "省中文",     
cityCode       String       comment "市code",     
city           String       comment "市中文",     
districtCode   String       comment "区code",     
district       String       comment "区中文",     
createDate     Timestamp    comment "创建时间",
createBy       String       comment "创建者",
updateDate     Timestamp    comment "更新时间",
updateBy       String       comment "更新者"
)
comment '服务商信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_serviceproviderentity_idld
(
id             String       comment "序列ID",
phone          String       comment "联系电话",  
name           String       comment "联系人", 
password       String       comment "密码",
serviceCode    String       comment "服务商编号",        
serviceName    String       comment "服务商名称",        
serviceStatus  String       comment "服务商状态,成功:SUCCESS 失败:FAIL 审核中:INIT",      
provinceCode   String       comment "省code",     
province       String       comment "省中文",     
cityCode       String       comment "市code",     
city           String       comment "市中文",     
districtCode   String       comment "区code",     
district       String       comment "区中文",     
createDate     Timestamp    comment "创建时间",
createBy       String       comment "创建者",
updateDate     Timestamp    comment "更新时间",
updateBy       String       comment "更新者"
)
comment '服务商信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_serviceproviderentity_pd
(
id             String       comment "序列ID",
phone          String       comment "联系电话",  
name           String       comment "联系人", 
password       String       comment "密码",
serviceCode    String       comment "服务商编号",        
serviceName    String       comment "服务商名称",        
serviceStatus  String       comment "服务商状态,成功:SUCCESS 失败:FAIL 审核中:INIT",      
provinceCode   String       comment "省code",     
province       String       comment "省中文",     
cityCode       String       comment "市code",     
city           String       comment "市中文",     
districtCode   String       comment "区code",     
district       String       comment "区中文",     
createDate     Timestamp    comment "创建时间",
createBy       String       comment "创建者",
updateDate     Timestamp    comment "更新时间",
updateBy       String       comment "更新者"
)
comment '服务商信息表'
partitioned by(day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;






