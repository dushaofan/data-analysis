create database IF NOT EXISTS ds_tubobo_express;
use ds_tubobo_express;
create table  bas_expresscompanyentity_init
(
companyId           String       comment "快递公司ID",
companyName         String       comment "快递公司名称",
contractPhone       String       comment "协议电话",
regularExpression   String       comment "正则表达式",
createDate          Timestamp    comment "创建时间",
createBy            String       comment "创建者",
updateDate          Timestamp    comment "更新时间",
updateBy            String       comment "更新者"
)
comment '快递公司信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table  bas_expresscompanyentity_idld
(
companyId           String       comment "快递公司ID",
companyName         String       comment "快递公司名称",
contractPhone       String       comment "协议电话",
regularExpression   String       comment "正则表达式",
createDate          Timestamp    comment "创建时间",
createBy            String       comment "创建者",
updateDate          Timestamp    comment "更新时间",
updateBy            String       comment "更新者"
)
comment '快递公司信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;


create table  bas_expresscompanyentity_pd
(
companyId           String       comment "快递公司ID",
companyName         String       comment "快递公司名称",
contractPhone       String       comment "协议电话",
regularExpression   String       comment "正则表达式",
createDate          Timestamp    comment "创建时间",
createBy            String       comment "创建者",
updateDate          Timestamp    comment "更新时间",
updateBy            String       comment "更新者"
)
comment '快递公司信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;
