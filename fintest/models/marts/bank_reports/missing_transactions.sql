select id as transactions_missing, currency,
date (booked_time) as date, 
from {{ref('client__transactions_data')}}
where 
not exists 
( 
select date
from {{ref('bank__report_data')}}
where date = date(booked_time))