# DBT project Submission

### Question: How many users do we have?
Answer: num_of_users: 130

``` sql
SELECT COUNT(user_guid) as num_of_users
FROM dev_db.dbt_sonali_gupta.stg_postgres__users;
```  
### On average, how many orders do we receive per hour? 
Answer: avg_orders_receive 7.520833
``` sql
WITH avg_orders AS (
SELECT DATE_TRUNC('hour', created_at) as hour,
COUNT(*) as num_of_orders
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
GROUP BY 1 ) 
SELECT avg(num_of_orders) as avg_orders_receive
FROM avg_orders;
```
### On average, how long does an order take from being placed to being delivered?
Answer: avg_day_order_being_placed: 1132.626230

``` sql
with cte as (
SELECT order_id, datediff(day,delivered_at,current_date) as day_order_being_placed, 
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
WHERE status = 'delivered')
select avg(day_order_being_placed)
from cte

```  

### How many users have only made one purchase? Two purchases? Three+ purchases?
Answer: ONE_PURCHASE: 25   TWO_PURCHASE: 28   THREE_PURCHASE : 71
```  sql
WITH count_users as (
SELECT o.user_id as user, count(o.order_id) as num_purchase
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders o 
GROUP BY 1) 
SELECT  count(case when num_purchase = 1 then user end ) as one_purchase,
count(case when num_purchase = 2 then user end ) as two_purchase,
count(case when num_purchase >= 3 then user end ) as three_purchase,
FROM count_users
```  
### On average, how many unique sessions do we have per hour?
Answer: AVG_UNIQUE_SESSIONS_HOUR: 16.327586
```sql
WITH avg_session AS (
SELECT 
DATE_TRUNC('hour', created_at) as hour,
COUNT(distinct session_id) as unique_sessions
FROM dev_db.dbt_sonali_gupta.stg_postgres__events
GROUP BY 1
)
SELECT avg(unique_sessions) as avg_unique_sessions_hour
FROM avg_session
```  



