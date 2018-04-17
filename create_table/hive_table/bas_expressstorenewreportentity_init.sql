create database IF NOT EXISTS ds_tubobo_express;
use ds_tubobo_express;
create table bas_expressstorenewreportentity_init
(
id                      String       comment "",
areaCode                String       comment "",
`date`                  String       comment "日期",            
provinceCode            String       comment "",
cityCode                String       comment "",
districtCode            String       comment "",
area                    String       comment "",
storeId                 String       comment "",
storeName               String       comment "",
joinTime                Timestamp    comment "",
serviceProviderId       String       comment "",
serviceProviderName     String       comment "",
createDate              Timestamp    comment "",
updateDate              Timestamp    comment "",
province                String       comment "",
city                    String       comment "",
district                String       comment "",
latitude                String       comment "",
Stringitude             String       comment "",
latitudeAndStringitude  String       comment "",
expressInNum            String       comment "入库量",         
expressSignNum          String       comment "签收量",         
todayExpressSignNum     String       comment "今日签收量签收量",         
sendMessageNum          String       comment "短信发送量",          
totalSendMessageNum     String       comment "总的短信发送量",      
stagnationNum           String       comment "滞留件",         
expressCompanyNum       String       comment "日单量超过20的接入快递公司数",         
expressCompany          String       comment "日单量超过20的接入快递公司名称",     
YesterdayIncrease       String       comment "与昨日相比增加",     
YesterdayReduce         String       comment "与昨日相比减少",         
YesterdayInNum          String       comment "昨日入库量"     
)
comment '店铺信息表'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS RCFILE;
