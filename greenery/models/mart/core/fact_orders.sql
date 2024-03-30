with 
orders as (
    select * from {{ref('stg_postgres__orders')}}
), 
addresses as (
    select * from {{ref('stg_postgres__addresses')}}
), 
products_orders as (
    select order_id, count(product_id) as num_product
    from {{ref('stg_postgres__order_items')}}
    group by 1
)

select o.order_id,
o.user_id,
o.promo_id,
o.address_id,
a.country, 
o.created_at,
o.order_cost,
o.shipping_cost,
o.order_total, 
o.tracking_id,
o.shipping_service,
o.estimated_delivery_at,
o.delivered_at, 
o.status,
p.num_product
from orders o
left join addresses a on a.address_id = o.address_id
left join products_orders p on p.order_id = o.order_id