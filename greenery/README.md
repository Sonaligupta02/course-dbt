# Welcome to dbt project 1!

## All SQL Queries

```sql
-- Query: How many users do we have?
SELECT COUNT(user_guid) as num_of_users
FROM dev_db.dbt_sonali_gupta.stg_postgres__users;

-- Query: On average, how many orders do we receive per hour?
WITH avg_orders AS (
    SELECT DATE_TRUNC('hour', created_at) as hour,
           COUNT(*) as num_of_orders
    FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
    GROUP BY 1
) 
SELECT AVG(num_of_orders) as avg_orders_receive
FROM avg_orders;

-- Query: On average, how long does an order take from being placed to being delivered?
SELECT AVG(DATEDIFF(day, current_date, delivered_at)) as avg_order_being_placed
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders
WHERE status = 'delivered';

-- Query: How many users have made one purchase, two purchases, or three or more purchases?
WITH count_users as (
    SELECT o.user_id as user, count(o.order_id) as num_purchase
    FROM dev_db.dbt_sonali_gupta.stg_postgres__orders o 
    GROUP BY 1
) 
SELECT  COUNT(CASE WHEN num_purchase = 1 THEN user END) as one_purchase,
        COUNT(CASE WHEN num_purchase = 2 THEN user END) as two_purchase,
        COUNT(CASE WHEN num_purchase >= 3 THEN user END) as three_or_more_purchase
FROM count_users;

-- Query: On average, how many unique sessions do we have per hour?
WITH avg_session AS (
    SELECT DATE_TRUNC('hour', created_at) as hour,
           COUNT(DISTINCT session_id) as unique_sessions
    FROM dev_db.dbt_sonali_gupta.stg_postgres__events
    GROUP BY 1
)
SELECT AVG(unique_sessions) as avg_unique_sessions_hour
FROM avg_session;
