create database  IF NOT EXISTS ds_tubobo_account;
use ds_tubobo_account;
CREATE TABLE bas_t_account_ops_idld
(
id                          int      comment '序列唯一ID',
account_id                  int      comment '账户唯一ID',
order_id                    int      comment '对应的业务Id',
related_op_id               string   ,
target                      int      comment '操作目标：余额、保证金',
amount                      int      comment '交易金额',
amount_from_withdrawable    int      comment '从可提现余额扣除的金额',
commission                  int      comment '佣金,默认为0',
type                        int      comment '交易类型：充值i、支付、收款、提现',
sub_type                    string   ,
status                      int      comment '操作状态：处理中、成功、失败、取消',
title                       string   comment '内容',
details                     string   comment '详细',
remarks                     string   comment '备注',
channel                     string   comment '充值提现与之交互的三方系统',
third_system_order_id       string   comment '对应三方系统的流水单',
client_ip                   string   comment '顾客',
del_flag                    int      comment '数据属否有效,0有效 1无效',
create_time                 string   comment '创建时间',
update_time                 string   comment '更新时间'
)
COMMENT '账户资金操作表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;

CREATE TABLE bas_t_account_ops_init
(
id                          int      comment '序列唯一ID',
account_id                  int      comment '账户唯一ID',
order_id                    int      comment '对应的业务Id',
related_op_id               string   ,
target                      int      comment '操作目标：余额、保证金',
amount                      int      comment '交易金额',
amount_from_withdrawable    int      comment '从可提现余额扣除的金额',
commission                  int      comment '佣金,默认为0',
type                        int      comment '交易类型：充值、支付、收款、提现',
sub_type                    string   ,
status                      int      comment '操作状态：处理中、成功、失败、取消',
title                       string   comment '内容',
details                     string   comment '详细',
remarks                     string   comment '备注',
channel                     string   comment '充值提现与之交互的三方系统',
third_system_order_id       string   comment '对应三方系统的流水单',
client_ip                   string   comment '顾客',
del_flag                    int      comment '数据属否有效,0有效 1无效',
create_time                 string   comment '创建时间',
update_time                 string   comment '更新时间'
)
COMMENT '账户资金操作表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;

CREATE TABLE bas_t_account_ops_pd
(
id                          int      comment '序列唯一ID',
account_id                  int      comment '账户唯一ID',
order_id                    int      comment '对应的业务Id',
related_op_id               string   ,
target                      int      comment '操作目标：余额、保证金',
amount                      int      comment '交易金额',
amount_from_withdrawable    int      comment '从可提现余额扣除的金额',
commission                  int      comment '佣金,默认为0',
type                        int      comment '交易类型：充值、支付、收款、提现',
sub_type                    string   ,
status                      int      comment '操作状态：处理中、成功、失败、取消',
title                       string   comment '内容',
details                     string   comment '详细',
remarks                     string   comment '备注',
channel                     string   comment '充值提现与之交互的三方系统',
third_system_order_id       string   comment '对应三方系统的流水单',
client_ip                   string   comment '顾客',
del_flag                    int      comment '数据属否有效,0有效 1无效',
create_time                 string   comment '创建时间',
update_time                 string   comment '更新时间'
)
COMMENT '账户资金操作表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;