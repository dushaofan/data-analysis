use mongo_tmp_tubobo_express;
alter table mongo_tmp_tubobo_express.waybillsentity set location '/apps/hive/warehouse/tubobo_express.mongo/WayBillSEntity/';

insert overwrite table ds_tubobo_express.bas_waybillsentity_idld 
select 
 a.id                    as id                      
,a.waybillNo             as waybillNo       
,a.waybillStatus         as waybillStatus   
,a.remainStatus          as remainStatus    
,a.fromRemainFlag        as fromRemainFlag  
,a.remainReason          as remainReason    
,a.returnBackReason      as returnBackReason
,a.normalUserId          as normalUserId    
,a.expressCompany["$id"] as expressCompany  
,a.belongStore["$id"]    as belongStore         
,a.inTime                as inTime          
,a.inOperator["$id"]     as inOperator           
,a.outTime               as outTime         
,a.outOperator["$id"]    as outOperator         
,a.signTime              as signTime        
,a.signOperator["$id"]   as signOperator       
,a.returnTime            as returnTime      
,a.returnOperator["$id"] as returnOperator   
,a.updateOperator["$id"] as updateOperator   
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

