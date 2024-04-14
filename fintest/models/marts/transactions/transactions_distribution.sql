with line_dis as (
    select * from {{ ref('line__items_data') }}
), 
client_dis as (
   select * from {{ref ('client__transactions_data')}}
)

SELECT t.client_name, date(t.booked_time) as date,
count(t.id) as number_of_transactions,
sum(l.quantity) as avg_quantity_spend,
avg(l.total_price) as avg_total_spend, 
LISTAGG(l.name, ', ') AS all_item_bought
FROM client_dis as t
LEFT JOIN line_dis l on l.transaction_id = t.id    
GROUP BY 1,2
ORDER BY 2 asc