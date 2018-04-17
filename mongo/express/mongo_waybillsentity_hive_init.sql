use mongo_tmp_tubobo_express;
create table mongo_tmp_tubobo_express.waybillsentity
(
 id                String
,waybillNo         String
,waybillStatus     int
,remainStatus      int
,fromRemainFlag    String
,remainReason      String
,returnBackReason  int
,normalUserId      String
,expressCompany    map<string,string>
,belongStore       map<string,string>
,inTime            Timestamp
,inOperator        map<string,string>
,outTime           Timestamp
,outOperator       map<string,string>
,signTime          Timestamp               
,signOperator      map<string,string>
,returnTime        Timestamp               
,returnOperator    map<string,string>   
,updateOperator    map<string,string>
,areaNum           string
,areaNumShow       string
,pickupType        string
,dispatchingWay    string                  
,evaluationFlag    string
,appointTime       string                  
,equipmentId       string
,equipmentName     string                  
,equipmentTemp     string
,senderName        string                  
,senderPhone       string                  
,senderAddress     string
,receiverName      string                  
,receiverPhone     string                  
,receiverAddress   string                  
,paymentMethod     string                  
,shipment          string                  
,insurePrice       string                  
,weight            string                  
,payment           string                 
,payFreight        string 
,sendSmsDay        string 
,unNoticeFlag      string 
,remark            string 
,delFlag           string 
,createDate        Timestamp
,createBy          string 
,updateDate        Timestamp 
,updateBy          string 
)
ROW FORMAT SERDE "com.mongodb.hadoop.hive.BSONSerDe"
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"id":"_id","waybillNo":"waybillNo","waybillStatus":"waybillStatus","remainStatus":"remainStatus","fromRemainFlag":"fromRemainFlag","remainReason":"remainReason","returnBackReason":"returnBackReason","normalUserId":"normalUserId","expressCompany":"expressCompany","belongStore":"belongStore","inTime":"inTime","inOperator":"inOperator","outTime":"outTime","outOperator":"outOperator","signTime":"signTime","signOperator":"signOperator","returnTime":"returnTime","returnOperator":"returnOperator","updateOperator":"updateOperator","areaNum":"areaNum","areaNumShow":"areaNumShow","pickupType":"pickupType","dispatchingWay":"dispatchingWay","evaluationFlag":"evaluationFlag","appointTime":"appointTime","equipmentId":"equipmentId","equipmentName":"equipmentName","equipmentTemp":"equipmentTemp","senderName":"senderName","senderPhone":"senderPhone","senderAddress":"senderAddress","receiverName":"receiverName","receiverPhone":"receiverPhone","receiverAddress":"receiverAddress","paymentMethod":"paymentMethod","shipment":"shipment","insurePrice":"insurePrice","weight":"weight","payment":"payment","payFreight":"payFreight","sendSmsDay":"sendSmsDay","unNoticeFlag":"unNoticeFlag","remark":"remark","delFlag":"delFlag","createDate":"createDate","createBy":"createBy","updateDate":"updateDate","updateBy":"updateBy"}')
STORED AS INPUTFORMAT "com.mongodb.hadoop.mapred.BSONFileInputFormat"
OUTPUTFORMAT "com.mongodb.hadoop.hive.output.HiveBSONFileOutputFormat"
location '/apps/hive/warehouse/tubobo_express.mongo/WayBillSEntity/';

insert overwrite table ds_tubobo_express.bas_waybillsentity_init
select 
 a.id                    as id                      
,a.waybillNo             as waybillNo       
,a.waybillStatus         as waybillStatus   
,a.remainStatus          as remainStatus    
,a.fromRemainFlag        as fromRemainFlag  
,a.remainReason          as remainReason    
,a.returnBackReason      as returnBackReason
,a.normalUserId          as normalUserId    
,a.expressCompany['$id'] as expressCompany  
,a.belongStore['$id']    as belongStore         
,a.inTime                as inTime          
,a.inOperator['$id']     as inOperator           
,a.outTime               as outTime         
,a.outOperator['$id']    as outOperator         
,a.signTime              as signTime        
,a.signOperator['$id']   as signOperator       
,a.returnTime            as returnTime      
,a.returnOperator['$id'] as returnOperator   
,a.updateOperator['$id'] as updateOperator   
,a.areaNum               as areaNum         
,a.areaNumShow           as areaNumShow     
,a.pickupType            as pickupType      
,a.dispatchingWay        as dispatchingWay  
,a.evaluationFlag        as evaluationFlag  
,a.appointTime           as appointTime     
,a.equipmentId           as equipmentId     
,a.equipmentName         as equipmentName   
,a.equipmentTemp         as equipmentTemp   
,a.senderName            as senderName      
,a.senderPhone           as senderPhone     
,a.senderAddress         as senderAddress   
,a.receiverName          as receiverName    
,a.receiverPhone         as receiverPhone   
,a.receiverAddress       as receiverAddress 
,a.paymentMethod         as paymentMethod   
,a.shipment              as shipment        
,a.insurePrice           as insurePrice     
,a.weight                as weight          
,a.payment               as payment         
,a.payFreight            as payFreight      
,a.sendSmsDay            as sendSmsDay      
,a.unNoticeFlag          as unNoticeFlag    
,a.remark                as remark          
,a.delFlag               as delFlag         
,a.createDate            as createDate      
,a.createBy              as createBy        
,a.updateDate            as updateDate      
,a.updateBy              as updateBy           
from mongo_tmp_tubobo_express.waybillsentity a;

