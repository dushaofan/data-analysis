create database IF NOT EXISTS ds_tubobo_express;
use  ds_tubobo_express;
create table bas_alismsrecordentity_init
(
id                       String     comment "序列ID",    
appId                    String     comment "应用id",    
aliSmsId                 String     comment "阿里短信模版id",    
aliSignName              String     comment "阿里短信模版签名",    
smsType                  String     comment "短信类型",    
storeId                  String     comment "所属门店",    
operator                 String     comment "操作人",    
immediate                String     comment "是否立即发送标记位",    
phone                    String     comment "接收号码 ",    
jsonParams               String     comment "json参数",    
smsStatus                String     comment "状态 0:待发送1:等待回执2:发送失败3:发送成功10:异常状态",    
bizId                    String     comment "返回结果(短信发送流水)成功时 有效返回信息",    
bizResultCode            String     comment "返回码",    
bizSuccesstrue           String     comment "表示成功,false表示失败",    
bizMsg                   String     comment "返回信息描述",    
taobaoResponseErrorCode  String     comment "失败时 有效返回信息",    
taobaoResponseMsg        String     comment "",
taobaoResponseSubCode    String     comment "",
taobaoResponseSubMsg     String     comment "",
sendTime                 String     comment "发送时间",    
receiverTime             String     comment "接收时间",    
createDate               Timestamp  comment "录入时间",    
updateDate               Timestamp  comment "更新时间"
)
comment '阿里短信表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

create table bas_alismsrecordentity_idld
(
id                       String     comment "序列ID",    
appId                    String     comment "应用id",    
aliSmsId                 String     comment "阿里短信模版id",    
aliSignName              String     comment "阿里短信模版签名",    
smsType                  String     comment "短信类型",    
storeId                  String     comment "所属门店",    
operator                 String     comment "操作人",    
immediate                String     comment "是否立即发送标记位",    
phone                    String     comment "接收号码 ",    
jsonParams               String     comment "json参数",    
smsStatus                String     comment "状态 0:待发送1:等待回执2:发送失败3:发送成功10:异常状态",    
bizId                    String     comment "返回结果(短信发送流水)成功时 有效返回信息",    
bizResultCode            String     comment "返回码",    
bizSuccesstrue           String     comment "表示成功,false表示失败",    
bizMsg                   String     comment "返回信息描述",    
taobaoResponseErrorCode  String     comment "失败时 有效返回信息",    
taobaoResponseMsg        String     comment "",
taobaoResponseSubCode    String     comment "",
taobaoResponseSubMsg     String     comment "",
sendTime                 String     comment "发送时间",    
receiverTime             String     comment "接收时间",    
createDate               Timestamp  comment "录入时间",    
updateDate               Timestamp  comment "更新时间"
)
comment '阿里短信表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;


create table bas_alismsrecordentity_pd
(
id                       String     comment "序列ID",    
appId                    String     comment "应用id",    
aliSmsId                 String     comment "阿里短信模版id",    
aliSignName              String     comment "阿里短信模版签名",    
smsType                  String     comment "短信类型",    
storeId                  String     comment "所属门店",    
operator                 String     comment "操作人",    
immediate                String     comment "是否立即发送标记位",    
phone                    String     comment "接收号码 ",    
jsonParams               String     comment "json参数",    
smsStatus                String     comment "状态 0:待发送1:等待回执2:发送失败3:发送成功10:异常状态",    
bizId                    String     comment "返回结果(短信发送流水)成功时 有效返回信息",    
bizResultCode            String     comment "返回码",    
bizSuccesstrue           String     comment "表示成功,false表示失败",    
bizMsg                   String     comment "返回信息描述",    
taobaoResponseErrorCode  String     comment "失败时 有效返回信息",    
taobaoResponseMsg        String     comment "",
taobaoResponseSubCode    String     comment "",
taobaoResponseSubMsg     String     comment "",
sendTime                 String     comment "发送时间",    
receiverTime             String     comment "接收时间",    
createDate               Timestamp  comment "录入时间",    
updateDate               Timestamp  comment "更新时间"
)
comment '阿里短信表'
partitioned by (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;

