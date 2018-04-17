create database  IF NOT EXISTS ds_tubobo_rider;
use  ds_tubobo_rider;
CREATE TABLE bas_tubobo_rider_info_idld
(
id                         string         COMMENT '序列ID',
create_by                  string         COMMENT '创建者',
create_date                string         COMMENT '创建时间',
update_by                  string         COMMENT '更新者',
update_date                string         COMMENT '更新时间',
del_flag                   int            COMMENT '删除标记',
remarks                    string         COMMENT '备注信息',
user_id                    int            COMMENT '用户中心id',
account_id                 int            COMMENT '资金账号ID',
rider_status               string         COMMENT '骑手认证状态',
phone                      int            COMMENT '手机号',
real_name                  string         COMMENT '姓名',
nick_name                  string         COMMENT '昵称',
id_card_no                 string         COMMENT '身份证号',
head_image                 string         COMMENT '头像url',
id_card_image_front        string         COMMENT '手持身份证url正面',
id_card_image_back         string         COMMENT '手持身份证url背面',
apply_date                 string         COMMENT '申请骑士日期',
verify_date                string         COMMENT '审核通过日期',
bd                         int            COMMENT '数据库',
bd_update_date             string         COMMENT '数据库更新时间',
failure_reason             string         COMMENT '失败原因',
pcd_code                   string         COMMENT '骑手邮编',
pcd_name                   string         COMMENT '骑手地址',
provider_id                string         COMMENT '所属服务商ID',
healthy_certificate_image  string         COMMENT '健康证明',
community_rider_status     string         COMMENT '社区骑手标记位',
store_id                   string         COMMENT '门店id'
)
COMMENT '骑手信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;


CREATE TABLE bas_tubobo_rider_info_pd
(
id                         string         COMMENT '序列ID',
create_by                  string         COMMENT '创建者',
create_date                string         COMMENT '创建时间',
update_by                  string         COMMENT '更新者',
update_date                string         COMMENT '更新时间',
del_flag                   int            COMMENT '删除标记',
remarks                    string         COMMENT '备注信息',
user_id                    int            COMMENT '用户中心id',
account_id                 int            COMMENT '资金账号ID',
rider_status               string         COMMENT '骑手认证状态',
phone                      int            COMMENT '手机号',
real_name                  string         COMMENT '姓名',
nick_name                  string         COMMENT '昵称',
id_card_no                 string         COMMENT '身份证号',
head_image                 string         COMMENT '头像url',
id_card_image_front        string         COMMENT '手持身份证url正面',
id_card_image_back         string         COMMENT '手持身份证url背面',
apply_date                 string         COMMENT '申请骑士日期',
verify_date                string         COMMENT '审核通过日期',
bd                         int            COMMENT '数据库',
bd_update_date             string         COMMENT '数据库更新时间',
failure_reason             string         COMMENT '失败原因',
pcd_code                   string         COMMENT '骑手邮编',
pcd_name                   string         COMMENT '骑手地址',
provider_id                string         COMMENT '所属服务商ID',
healthy_certificate_image  string         COMMENT '健康证明',
community_rider_status     string         COMMENT '社区骑手标记位',
store_id                   string         COMMENT '门店id'
)
COMMENT '骑手信息表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;