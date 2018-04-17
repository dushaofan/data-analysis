create table tubobo_reportdata.zhongbao_total_recharge_merchant_ids_info
(
create_date                   string comment  "创建时间",
address_province              string comment  "省份",
address_city                  string comment  "城市",
total_recharge_merchant_ids   int comment  "充值商家id"
)
comment '众包发单店铺信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;

create table tubobo_reportdata.zhongbao_total_receiver_rider_ids_info
(
create_date                   string comment  "创建时间",
address_province              string comment  "省份",
address_city                  string comment  "城市",
total_receiver_rider_ids       int comment  "接单骑手ID"
)
comment '众包发单店铺信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;

create table tubobo_reportdata.zhongbao_platform_income_details
(
create_date                           string comment "创建时间",
province                              string comment "省份",
city                                  string comment "市",
total_recharge_account                string comment "商家充值",
total_deposit_account                 string comment "缴纳押金",
total_rider_fine_account               string comment "骑手罚单",
total_insurance_account               string comment "购买保险",
total_commission_account              string comment "订单佣金",
total_gift_account                    string comment "充值满送",
total_rider_withdraw_account          string comment "骑手提现",
total_create_num                      string comment "创搭单量",
total_finish_num                      string comment "完成单量",
income_total_amount                   string comment "平台总收入",
outcome_total_amount                  string comment "平台总支出"
)
COMMENT '平台收入明细表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001'  STORED AS TEXTFILE;


create table tubobo_reportdata.zhongbao_merchant_order_heat_entity
(
create_date         string comment  "创建时间",
province            string comment  "省份",
city                string comment  "城市",
district            string comment  "区域",
longitude           string comment  "精度",
latitude            string comment  "纬度",
finish_num          int    comment  "完成单量",
cancel_num          int    comment  "取消单量"
)
comment '众包店铺热力图'
partitioned by(day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;


create table tubobo_reportdata.zhongbao_total_send_merchant_ids_info
(
create_date                   string comment  "创建时间",
address_province              string comment  "省份",
address_city                  string comment  "城市",
total_send_merchant_ids       int comment  "发单商家"
)
comment '众包发单店铺信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;
