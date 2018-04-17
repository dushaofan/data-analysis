#!/bin/sh
source /www/data-analysis/conf/config.sh
two_start_date=`date  -d -2day "+%Y-%m-%d"`
two_start_time=`date  -d -2day "+%Y-%m-%d 00:00:00"`
start_date=`date  -d yesterday "+%Y-%m-%d"`
start_time=`date  -d yesterday "+%Y-%m-%d 00:00:00"`
start_old_time=`date  -d yesterday "+%Y-%m-%d 23:59:59"`
today_date=`date "+%Y-%m-%d"`
today_time=`date "+%Y-%m-%d 00:00:00"`
start_date_time=`date -d "$start_time" +%s`000
end_date_time=`date -d "$today_time" +%s`000
begin_time_8=`expr $start_date_time + 28800000`
end_time_8=`expr $end_date_time + 28800000`

spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}

spark-sql --master ${spark_url} -e "
set mapred.min.split.size=128000000;
set mapred.min.split.size.per.node=128000000;
set mapred.min.split.size.per.rack=128000000;
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;
set hive.exec.reducers.bytes.per.reducer=100000000;
set hive.groupby.skewindata=true;
insert overwrite table tubobo_reportdata.tubobo_express_store_info partition (day='${start_date}')
select 
 aaa.areaCode               as area_code
,aaa.create_date            as date
,aaa.provinceCode          as province_code
,aaa.cityCode              as city_code
,aaa.districtCode          as district_code
,aaa.area                  as area
,aaa.storeCode              as store_id
,aaa.storeName             as store_name
,aaa.joinTime              as join_time
,aaa.serviceProviderId     as service_provider_id
,aaa.serviceProviderName   as service_provider_name
,aaa.province              as province
,aaa.city                  as city
,aaa.district              as district
,aaa.latitude              as latitude
,aaa.longitude             as longitude
,case when aaa.latitudeAndLongitude is null then '0' else aaa.latitudeAndLongitude end as latitude_and_longitude
,case when aaa.expressInNum is null then '0' else aaa.expressInNum end as express_in_num
,case when aaa.expressSignNum is null then '0' else aaa.expressSignNum end as express_sign_num
,case when aaa.todayExpressSignNum is null then '0' else aaa.todayExpressSignNum end  as today_express_sign_num
,case when bb.sendMessageNum is null then '0' else bb.sendMessageNum end as send_message_num
,case when bb.totalSendMessageNum is null then '0' else bb.totalSendMessageNum end  as total_send_message_num
,case when aaa.stagnationNum is null then '0' else aaa.stagnationNum end as stagnation_num
,case when cc.expressCompanyNum  is null then '0' else cc.expressCompanyNum end as express_company_num
,case when cc.expressCompany is null then '0' else cc.expressCompany end as express_company
from 
(select 
bb.create_date                                                           ,
bb.storeName                                                             ,
bb.storeId                                                               ,
bb.storeCode                                                             ,
bb.service             as serviceProviderId                              ,
bb.serviceName         as serviceProviderName                            ,
bb.province                                                              ,
bb.joinTime                                                              ,
bb.city                                                                  ,
bb.district                                                              ,
bb.latitude                                                              ,
bb.longitude                                                             ,
bb.provinceCode                                                          ,
bb.cityCode                                                              ,
bb.districtCode                                                          ,
concat_ws('',bb.latitude,bb.longitude) as latitudeAndLongitude           ,
concat_ws(' ',bb.province,bb.city,bb.district) as area                   ,
concat_ws(' ',bb.provinceCode,bb.cityCode,bb.districtCode) as areaCode   ,
aa.expressInNum                                                          ,
aa.todayExpressSignNum                                                   ,
aa.expressSignNum                                                        ,
aa.stagnationNum
from 
( 
select 
b.create_date,
b.storeName,
b.province,
b.city,
b.district,
b.longitude,
b.latitude,
b.storeid,
b.storeCode,
b.service,
b.provinceCode,
b.cityCode,
b.districtCode,
b.joinTime,
c.serviceName
from 
(select create_date,storeName,service,province,city,district,longitude,latitude,storeid,storeCode,storeStatus,provinceCode,
        cityCode,districtCode,to_date(createDate) as joinTime
    from da_tubobo_express.bas_storeentity_and_ues_create_date where day='${start_date}' and create_date='${start_date}' and storeStatus='SUCCESS')b
join
(select id,serviceName from ds_tubobo_express.bas_serviceproviderentity_pd where day='${start_date}')c on b.service=c.id) bb
left join
(
select
to_date(a.createDate) as createDate 
a.belongStore,
count(case when to_date(a.createDate)='${start_date}' then '1' end) as expressInNum,
count(case when to_date(a.createDate)=to_date(a.inTime) and to_date(a.createDate)=to_date(a.signTime) then '1' end) as todayExpressSignNum,	
count(case when to_date(a.createDate)=to_date(a.signTime) then '1' end) as expressSignNum,	
count(case when a.createDate>='2017-10-01' and a.createDate<='${start_old_time}' and 
(a.waybillStatus='1' or a.signTime>='${start_old_time}' or to_date(a.outTime)>='${start_old_time}') 
then 'stagnationNum' end) as stagnationNum	
from 
(select to_date(createDate),inTime,signTime,outTime,belongStore,waybillStatus from ds_tubobo_express.bas_waybillsentity_pd)a 
left join 
(select storeid,province,city,storeStatus,create_date from da_tubobo_express.bas_storeentity_and_ues_create_date 
where day='${start_date}' and create_date='${start_date}' and storeStatus='SUCCESS')b on a.belongStore=b.storeid
group by
to_date(a.createDate),
a.belongStore) aa 
on aa.belongStore=bb.storeid and aa.createDate =bb.create_date
)aaa
left join 
(
select 
b.create_date,
b.storeid,
aa.sendMessageNum,
aa.totalSendMessageNum
from
(
select
a.createDate,
a.storeid,
count(1) as totalSendMessageNum,
count(case when a.smsstatus in ('1','3') then '1' end) as sendMessageNum
from (select storeId,to_date(createDate) as createDate,smsstatus from ds_tubobo_express.bas_alismsrecordentity_pd 
where day='${start_date}' and to_date(createDate)='${start_date}')a where a.createDate is not null  group by a.createDate,a.storeid)aa
right join 
(select storeid,province,city,storeStatus,create_date from da_tubobo_express.bas_storeentity_and_ues_create_date 
where day='${start_date}' and create_date='${start_date}' and storeStatus='SUCCESS')b 
on aa.storeId=b.storeid and aa.createDate=b.create_date
)bb 
on aaa.create_date=bb.create_date and aaa.storeid=bb.storeid
left join
(select 
aa.belongStore,
aa.createdate,
count(aa.expressCompany) as expressCompanyNum,
concat_ws(',',collect_set(c.companyName)) as expressCompany
from 
(
select 
b.expressCompany,
a.belongStore,
a.createdate
from 
(select count(1),belongStore,to_date(createDate) as createdate from ds_tubobo_express.bas_waybillsentity_pd where day='${start_date}'
group by belongStore,to_date(createDate) having count(1)>20) a
join
(select expressCompany,belongStore,to_date(createDate) as createdate 
from ds_tubobo_express.bas_waybillsentity_pd where day='${start_date}' group by expressCompany,belongStore,to_date(createDate)) b
on a.belongStore=b.belongStore and a.createdate=b.createdate)aa
 join 
(select companyId,companyName from ds_tubobo_express.bas_expresscompanyentity_pd where day='${start_date}') c on aa.expressCompany=c.companyId
 group by aa.createdate,aa.belongStore)cc 
on aaa.create_date=cc.createdate and cc.belongStore=aaa.storeid;"
