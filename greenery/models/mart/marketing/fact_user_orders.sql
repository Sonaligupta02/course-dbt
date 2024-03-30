with 

users as (
select * from {{ref('stg_postgres__users')}}

), 

order_summary as (
select user_id as user_guid, 
min(created_at) as first_order_dt,
max(created_at) as last_order_dt,
count(order_id) as num_orders, 
sum(order_cost) as total_cost
from 
{{ref('stg_postgres__orders')}}
group by 1

)

, product_purchased as (
  select 
  o.user_id as user_guid, 
  count(oi.product_id) as num_of_products
  from {{ref ('stg_postgres__order_items')}} oi 
  left join {{ref ('stg_postgres__orders')}} o on o.order_id = oi.order_id
  group by 1
)




select
  u.user_guid,
  os.num_orders is not null as is_buyer,
  coalesce(os.num_orders ,0)>=2 as is_frequent_buyer,
  os.first_order_dt,
  os.last_order_dt,
  os.num_orders,
  os.total_cost,
  p.num_of_products
from users u 
left join order_summary os on os.user_guid = u.user_guid
left join product_purchased p on p.user_guid = u.user_guid

