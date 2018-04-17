create database IF NOT EXISTS ds_tubobo_express;
use  ds_tubobo_express;
create table bas_waybillsentity_pd
(
id                String                 comment "序列ID",         
waybillNo         String                 comment "运单号",         
waybillStatus     int                    comment "运单状态",        
remainStatus      int                    comment "滞留件扫描次数(区分是否滞留件)",         
fromRemainFlag    String                 comment "是否来自滞留件",         
remainReason      String                 comment "滞留原因",         
returnBackReason  int                    comment "退回原因(0:默认1:无法联系2:超时 3:拒收4:错分5:改地址6:其他)",
normalUserId      String                 comment "用户ID",         
expressCompany    string                 comment "快递公司",         
belongStore       string                 comment "门店",         
inTime            Timestamp              comment "入库时间",         
inOperator        string                 comment "入库人",         
outTime           Timestamp              comment "出库时间",         
outOperator       string                 comment "出库人",         
signTime          Timestamp              comment "签收时间",         
signOperator      string                 comment "签收人",         
returnTime        Timestamp              comment "退回时间",         
returnOperator    string                 comment "退回人",         
updateOperator    string                 comment "最新操作人",         
areaNum           string                 comment "作为搜索字段的取件码",         
areaNumShow       string                 comment "作为显示字段的取件码",         
pickupType        string                 comment "配送类型 0:自提件:1:配送件",         
dispatchingWay    string                 comment "配送方式:0自取,1代拿,2隔天取,3白天送,4夜间送",
evaluationFlag    string                 comment "估价标示",
appointTime       string                 comment "预约配送时间",         
equipmentId       string                 comment "设备id",         
equipmentName     string                 comment "设备名称",         
equipmentTemp     string                 comment "设备温度",         
senderName        string                 comment "寄件人姓名",         
senderPhone       string                 comment "寄件人手机号",         
senderAddress     string                 comment "寄件人地址",         
receiverName      string                 comment "收件人姓名",         
receiverPhone     string                 comment "收件人手机号",         
receiverAddress   string                 comment "收件人地址",         
paymentMethod     string                 comment "付款方式",         
shipment          string                 comment "寄件物",         
insurePrice       string                 comment "保价金额 单位:元:数字",         
weight            string                 comment "单位:KG:数字",
payment           string                 comment "代收货款",
payFreight        string                 comment "代收运费",
sendSmsDay        string                 comment "发送短信时间",
unNoticeFlag      string                 comment "未发送取件通知标记",
remark            string                 comment "备注",
delFlag           string                 comment "删除标示",
createDate        Timestamp              comment "录入时间",
createBy          string                 comment "录入人",
updateDate        Timestamp              comment "更新时间",
updateBy          string                 comment "更新人"
)
comment '快递订单信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_waybillsentity_idld
(
id                String                 comment "序列ID",         
waybillNo         String                 comment "运单号",         
waybillStatus     int                    comment "运单状态",        
remainStatus      int                    comment "滞留件扫描次数(区分是否滞留件)",        
fromRemainFlag    String                 comment "是否来自滞留件",         
remainReason      String                 comment "滞留原因",         
returnBackReason  int                    comment "退回原因(0:默认1:无法联系2:超时 3:拒收4:错分5:改地址6:其他)",
normalUserId      String                 comment "用户ID",         
expressCompany    string     comment "快递公司",         
belongStore       string     comment "门店",         
inTime            Timestamp              comment "入库时间",         
inOperator        string     comment "入库人",         
outTime           Timestamp              comment "出库时间",         
outOperator       string     comment "出库人",         
signTime          Timestamp              comment "签收时间",         
signOperator      string     comment "签收人",         
returnTime        Timestamp              comment "退回时间",         
returnOperator    string     comment "退回人",         
updateOperator    string     comment "最新操作人",         
areaNum           string                 comment "作为搜索字段的取件码",         
areaNumShow       string                 comment "作为显示字段的取件码",         
pickupType        string                 comment "配送类型 0:自提件:1:配送件",         
dispatchingWay    string                 comment "配送方式:0自取,1代拿,2隔天取,3白天送,4夜间送",
evaluationFlag    string                 comment "估价标示",
appointTime       string                 comment "预约配送时间",         
equipmentId       string                 comment "设备id",         
equipmentName     string                 comment "设备名称",         
equipmentTemp     string                 comment "设备温度",         
senderName        string                 comment "寄件人姓名",         
senderPhone       string                 comment "寄件人手机号",         
senderAddress     string                 comment "寄件人地址",         
receiverName      string                 comment "收件人姓名",         
receiverPhone     string                 comment "收件人手机号",         
receiverAddress   string                 comment "收件人地址",         
paymentMethod     string                 comment "付款方式",         
shipment          string                 comment "寄件物",         
insurePrice       string                 comment "保价金额 单位:元:数字",         
weight            string                 comment "单位:KG:数字",
payment           string                 comment "代收货款",
payFreight        string                 comment "代收运费",
sendSmsDay        string                 comment "发送短信时间",
unNoticeFlag      string                 comment "未发送取件通知标记",
remark            string                 comment "备注",
delFlag           string                 comment "删除标示",
createDate        Timestamp              comment "录入时间",
createBy          string                 comment "录入人",
updateDate        Timestamp              comment "更新时间",
updateBy          string                 comment "更新人"
)
comment '快递订单信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;
create table bas_waybillsentity_init
(
id                String                 comment "序列ID",         
waybillNo         String                 comment "运单号",         
waybillStatus     int                    comment "运单状态",        
remainStatus      int                    comment "滞留件扫描次数(区分是否滞留件)",         
fromRemainFlag    String                 comment "是否来自滞留件",         
remainReason      String                 comment "滞留原因",         
returnBackReason  int                    comment "退回原因(0:默认1:无法联系2:超时 3:拒收4:错分5:改地址6:其他)",
normalUserId      String                 comment "用户ID",         
expressCompany    string     comment "快递公司",         
belongStore       string     comment "门店",         
inTime            Timestamp              comment "入库时间",         
inOperator        string     comment "入库人",         
outTime           Timestamp              comment "出库时间",         
outOperator       string     comment "出库人",         
signTime          Timestamp              comment "签收时间",         
signOperator      string     comment "签收人",         
returnTime        Timestamp              comment "退回时间",         
returnOperator    string     comment "退回人",         
updateOperator    string     comment "最新操作人",         
areaNum           string                 comment "作为搜索字段的取件码",         
areaNumShow       string                 comment "作为显示字段的取件码",         
pickupType        string                 comment "配送类型 0:自提件:1:配送件",         
dispatchingWay    string                 comment "配送方式:0自取,1代拿,2隔天取,3白天送,4夜间送",
evaluationFlag    string                 comment "估价标示",
appointTime       string                 comment "预约配送时间",         
equipmentId       string                 comment "设备id",         
equipmentName     string                 comment "设备名称",         
equipmentTemp     string                 comment "设备温度",         
senderName        string                 comment "寄件人姓名",         
senderPhone       string                 comment "寄件人手机号",         
senderAddress     string                 comment "寄件人地址",         
receiverName      string                 comment "收件人姓名",         
receiverPhone     string                 comment "收件人手机号",         
receiverAddress   string                 comment "收件人地址",         
paymentMethod     string                 comment "付款方式",         
shipment          string                 comment "寄件物",         
insurePrice       string                 comment "保价金额 单位:元:数字",         
weight            string                 comment "单位:KG:数字",
payment           string                 comment "代收货款",
payFreight        string                 comment "代收运费",
sendSmsDay        string                 comment "发送短信时间",
unNoticeFlag      string                 comment "未发送取件通知标记",
remark            string                 comment "备注",
delFlag           string                 comment "删除标示",
createDate        Timestamp              comment "录入时间",
createBy          string                 comment "录入人",
updateDate        Timestamp              comment "更新时间",
updateBy          string                 comment "更新人"
)
comment '快递订单信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;
