create database tubobo_reportdata;
use tubobo_reportdata;
create table tubobo_reportdata.tubobo_express_increase_store_num_info
(
store_id                      String                     comment "店铺ID",
store_status                  String                     comment "门店审核状态成功:SUCCESS",
province                      String                     comment "省中文",
city                          String                     comment "市中文",
create_date                   String                     comment "创建时间"    
)
comment '店铺信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;


create table tubobo_reportdata.tubobo_express_num_abnormality
(
create_date                    string comment "日期",
area_code                      string comment "区域编码",
store_name                     string comment "门店名称",
store_id                       string comment "门店id",
service_provider_name          string comment "服务商",
area                           string comment "地区",
express_in_num                 string comment "总件量",
yesterday_in_num               string comment "前日到店量",
yesterday_increase             string comment "增长百分比",
yesterday_reduce               string comment "减少百分比"
)
comment '快递入库对比昨天增加表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;


create table tubobo_reportdata.tubobo_express_store_info
(
area_code                string comment "区域邮编",
`date`                   string comment "快递记录创建时间",
province_code            string comment "省邮编",
city_code                string comment "城市邮编",
district_code            string comment "区邮编",
area                     string comment "区域",
store_id                 string comment "店铺id",
store_name               string comment "店铺名称",
join_time                string comment "店铺创建时间",
service_provider_id      string comment "服务商id",
service_provider_name    string comment "服务商名称",
province                 string comment "省份",
city                     string comment "城市",
district                 string comment "区域",
latitude                 string comment "纬度",
longitude                string comment "经度",
latitude_and_longitude   string comment "经纬度",
express_in_num           string comment "入库量",
express_sign_num         string comment "签收量",
today_express_sign_num   string comment "今日签收量签收量",
send_message_num         string comment "短信发送量(success)",
total_send_message_num   string comment "总的短信发送量",
stagnation_num           string comment "滞留件",
express_company_num      string comment "日单量超过20的接入快递公司数",
express_company          string comment "日单量超过20的接入快递公司名称" 
)
comment '快递门店统计表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;


CREATE TABLE appointment_order_status_info (
create_time          string   COMMENT '创建时间',
province             string   COMMENT '订单省份',
city                 string   COMMENT '订单城市',
create_order         string   COMMENT '创建单量',
big_bag              string   COMMENT '大件包裹',
common_bag           string   COMMENT '普通包裹',
init_order           string   COMMENT '初始化,待支付状态',
cancel_order         string   COMMENT '取消单量',
waiting_grab_order   string   COMMENT '待接单量',
waiting_pick_order   string   COMMENT '待取单量',
deliverying_order    string   COMMENT '进行中单量',
close_order          string   COMMENT '关闭单量',
finish_order         string   COMMENT '完成单量',
other_order          string   COMMENT '其他单量',
grab_overtime_cancel string   COMMENT '超时未接单取消',
grab_sender_cancel   string   COMMENT '未接单时用户主动取消',
pay_overtime_cancel  string   COMMENT '支付超时取消',
admin_cancel         string   COMMENT '后台取消',
pay_sender_cancel    string   COMMENT '未支付主动取消',
pick_rider_cancel    string   COMMENT '骑手主动取消',
store_cancel         string   COMMENT '门店主动取消',
other_cancel         string   COMMENT '其他取消'
)
comment '预约配送结果表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;