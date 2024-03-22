# Project 1 Answer
 
 Q1: How many users do we have? 
 Ans: 130

``` 
SELECT COUNT(user_guid) as num_of_users
FROM dev_db.dbt_sonali_gupta.stg_postgres__users
```

Q2: On average, how many orders do we receive per hour? 
Ans: AVG_ORDERS_RECEIVE  7.520833

```
WITH avg_orders AS (
SELECT DATE_TRUNC('hour', created_at) as hour,
COUNT(*) as num_of_orders
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
GROUP BY 1 ) 
SELECT avg(num_of_orders) as avg_orders_receive
FROM avg_orders 
```


Q3:On average, how long does an order take from being placed to being delivered?
Ans:  AVG_ORDER_BEING_PLACED -1131.626230

```
SELECT avg(datediff(day,current_date,delivered_at)) as avg_order_being_placed, 
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
WHERE status = 'delivered'
```


Q4:How many users have only made one purchase? Two purchases? Three+ purchases?
Ans: ONE_PURCHASE: 25	TWO_PURCHASE: 28	THREE_PURCHASE : 71

```
WITH count_users as (
SELECT o.user_id as user, count(o.order_id) as num_purchase
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders o 
GROUP BY 1) 
SELECT  count(case when num_purchase = 1 then user end ) as one_purchase,
count(case when num_purchase = 2 then user end ) as two_purchase,
count(case when num_purchase >= 3 then user end ) as three_purchase,
FROM count_users
```

Q5: On average, how many unique sessions do we have per hour?
Ans:  AVG_UNIQUE_SESSIONS_HOUR 16.327586

```
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