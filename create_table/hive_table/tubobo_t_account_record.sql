create database  IF NOT EXISTS ds_tubobo_account;
use ds_tubobo_account;
CREATE TABLE bas_t_account_record_idld
(
id                      int      comment '序列ID',
account_id              int      comment '账号ID',
ops_id                  int      comment '操作记录Id',
amount                  int      comment '交易金额',
type                    int      comment '交易类型：充值、支付、收款、提现',
sub_type                string   ,
current_balance         int      comment '当前余额',
current_withdrawable    int      comment '当前可抽出的',
current_frozen          int      comment '当前冻结额度',
current_deposit         int      comment '当前押金',
remarks                 string   comment '评论',
del_flag                int      comment '数据属否有效,0有效 1无效',
create_time             string   comment '创建时间',
charge_time             string   comment '更新时间'
)
COMMENT '记账流水表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001'  STORED AS TEXTFILE;

CREATE TABLE bas_t_account_record_init
(
id                      int      comment '序列ID',
account_id              int      comment '账号ID',
ops_id                  int      comment '操作记录Id',
amount                  int      comment '交易金额',
type                    int      comment '交易类型：充值、支付、收款、提现',
sub_type                string   ,
current_balance         int      comment '当前余额',
current_withdrawable    int      comment '当前可抽出的',
current_frozen          int      comment '当前冻结额度',
current_deposit         int      comment '当前押金',
remarks                 string   comment '评论',
del_flag                int      comment '数据属否有效,0有效 1无效',
create_time             string   comment '创建时间',
charge_time             string   comment '更新时间'
)
COMMENT '记账流水表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001'  STORED AS TEXTFILE;

CREATE TABLE bas_t_account_record_pd
(
id                      int      comment '序列ID',
account_id              int      comment '账号ID',
ops_id                  int      comment '操作记录Id',
amount                  int      comment '交易金额',
type                    int      comment '交易类型：充值、支付、收款、提现',
sub_type                string   ,
current_balance         int      comment '当前余额',
current_withdrawable    int      comment '当前可抽出的',
current_frozen          int      comment '当前冻结额度',
current_deposit         int      comment '当前押金',
remarks                 string   comment '评论',
del_flag                int      comment '数据属否有效,0有效 1无效',
create_time             string   comment '创建时间',
charge_time             string   comment '更新时间'
)
COMMENT '记账流水表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001'  STORED AS RCFILE;