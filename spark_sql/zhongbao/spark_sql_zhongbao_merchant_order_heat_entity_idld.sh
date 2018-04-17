#!/bin/sh
#date and time
source /www/data-analysis/conf/config.sh
two_start_date=`date  -d -2day "+%Y-%m-%d"`
two_start_time=`date  -d -2day "+%Y-%m-%d 00:00:00"`
start_date=`date  -d yesterday "+%Y-%m-%d"`
start_time=`date  -d yesterday "+%Y-%m-%d 00:00:00"`
today_date=`date "+%Y-%m-%d"`
today_time=`date "+%Y-%m-%d 00:00:00"`
#configuration file
spark=`grep 'spark_url=' $configUrl`
spark_url=${spark##*=}

spark-sql --master ${spark_url} -e "
insert overwrite table tubobo_reportdata.zhongbao_platform_income_details partition (day='${start_date}')
select
aaa.create_date,
aaa.province,
aaa.city,
aaa.total_recharge_account,
aaa.total_deposit_account,
aaa.total_rider_fine_account,
aaa.total_insurance_account,
aaa.total_commission_account,
aaa.total_gift_account,
aaa.total_rider_withdraw_account,
aaa.total_create_num,
aaa.total_finish_num,
aaa.total_recharge_account+aaa.total_deposit_account+aaa.total_rider_fine_account+aaa.total_insurance_account+aaa.total_commission_account as income_total_amount,
aaa.outcome_total_amount
from 
(select 
dd.create_date,
dd.province,
dd.city,
(case when aa.total_recharge_account is null then '0' else aa.total_recharge_account end) as total_recharge_account,
(case when bb.total_deposit_account        is null then '0' else bb.total_deposit_account        end) as total_deposit_account,
(case when bb.total_riderfine_account      is null then '0' else bb.total_riderfine_account      end) as total_rider_fine_account,
(case when bb.total_insurance_account      is null then '0' else bb.total_insurance_account      end) as total_insurance_account,
(case when cc.total_commission_account     is null then '0' else cc.total_commission_account     end) as total_commission_account,
(case when aa.total_gift_account           is null then '0' else aa.total_gift_account           end) as total_gift_account,
(case when bb.total_rider_withdraw_account is null then '0' else bb.total_rider_withdraw_account end) as total_rider_withdraw_account,
(case when dd.total_create_num             is null then '0' else dd.total_create_num             end) as total_create_num,
(case when dd.total_finish_num             is null then '0' else dd.total_finish_num             end) as total_finish_num,
aa.total_gift_account+bb.total_rider_withdraw_account as outcome_total_amount
from 
(select 
to_date(a.create_date) as create_date,
b.address_province as province,
b.address_city as city,
count(1) as total_create_num,
count(case when a.order_status='FINISH' then 'FINISH' end) as total_finish_num 
from 
(select user_id,order_status,create_date from ds_tubobo_merchant.bas_tubobo_order_pd where day='${start_date}' and to_date(create_date)='${start_date}') a
join 
(select user_id,address_province,address_city from ds_tubobo_merchant.bas_tubobo_merchant_info_pd where day='${start_date}' )b on a.user_id=b.user_id 
group by to_date(a.create_date),b.address_province,b.address_city) dd 
left join 
(SELECT
'${start_date}' as create_date,
b.address_province as province,
b.address_city as city,
SUM(case when a.status='1' and a.type='100' and a.target='300' then a.amount else '0' end) as total_recharge_account,
SUM(case when a.type ='140' then a.amount else '0' end)  as total_gift_account
FROM
(select account_id,amount,status,type,target,create_time from ds_tubobo_account.bas_t_account_ops_pd 
where day='${start_date}' and to_date(create_time)='${start_date}')a
join
(select account_id,address_province,address_city from ds_tubobo_merchant.bas_tubobo_merchant_info_pd  where day='${start_date}') b 
 on  a.account_id = b.account_id group by '${start_date}',b.address_province,b.address_city) aa 
on aa.create_date=dd.create_date and aa.province=dd.province and aa.city=dd.city
left join 
(select 
'${start_date}' as create_date,
b.province,
b.city,
sum(case when a.type ='100' and a.status='1' then a.amount else '0' end) as total_deposit_account,
SUM(case when a.type ='130' and a.sub_type in('finishOverTime','cancelOrder','complainifine') then a.amount else '0' end) as total_riderfine_account,
SUM(case when a.type ='160' and a.sub_type='buyInsurance' then a.amount else '0' end) as total_insurance_account,
SUM(case when a.type ='110' and a.target in ('300','310') then a.amount else '0' end) as total_rider_withdraw_account
from 
(select account_id,amount,sub_type,type,status,target,create_time from ds_tubobo_account.bas_t_account_ops_pd 
where day='${start_date}' and to_date(create_time)='${start_date}')a
join 
(select account_id,split(pcd_name,' ')[0] as province,split(pcd_name,' ')[1] as city from ds_tubobo_rider.bas_tubobo_rider_info_pd where day='${start_date}') b 
 on  a.account_id = b.account_id group by '${start_date}',b.province,b.city) bb 
 on dd.create_date=bb.create_date and dd.province=bb.province and dd.city=bb.city
left join 
(SELECT
'${start_date}' as create_date,
c.address_province as province,
c.address_city as city,
SUM(a.amount) as total_commission_account
 from 
(select ops_id,type,amount,create_time from ds_tubobo_account.bas_t_account_record_pd 
where day='${start_date}' and type = '999' and to_date(create_time)='${start_date}' group by ops_id,type,amount,create_time) a
 LEFT JOIN 
(select id,account_id,create_time from ds_tubobo_account.bas_t_account_ops_pd 
where day='${start_date}' and to_date(create_time)='${start_date}') b ON a.ops_id = b.id
LEFT JOIN 
(select account_id,address_province,address_city from ds_tubobo_merchant.bas_tubobo_merchant_info_pd where day='${start_date}') c 
ON b.account_id = c.account_id
group by '${start_date}',c.address_province,c.address_city) cc 
on dd.create_date==cc.create_date and dd.province=cc.province and dd.city=cc.city)aaa ;"

