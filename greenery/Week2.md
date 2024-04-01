# DBT project Submission Week 2

## Part 1

* Question 1: What is our user repeat rate?
  
  * TWO_PLUS_PURCHASE : 99
  * NUM_USER	 : 124
  * REPEAT_RATE: 0.798387

``` sql WITH count_users as (
SELECT 
  o.user_id as user 
, count(o.order_id) as num_purchase
FROM dev_db.dbt_sonali_gupta.stg_postgres__orders o 
GROUP BY 1) 

SELECT  
count(case when num_purchase >= 2 then user end ) as two_plus_purchase
, count(user) as num_user 
, div0(two_plus_purchase, num_user) as repeat_rate
FROM count_users;
``` 

* Question 2: What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again?
  
  * User who purchase 2 or more times are likely to purchase again. and Can also use RFM technique: Recency, Frequency, Monetory value( spend amount)
    
    * TWO_PLUS_PURCHASE : 99

  * User who purchase or more times are likely to purchase again.
      * ONE_LESS_PURCHASE: 25

* Question 3: Explain the product mart models you added. Why did you organize the models in the way you did?

I added fact_page_view product mart models. It is connected with two source one is with events and other with order_items. Create intermediate sql on events. This model will answer number of page_views and converting into purchases.

## Part 2

* What assumptions are you making about each model? (i.e. why are you adding each test?)
    * Apply test on addresses (address id)
    * Apply test on event_id (not null, unique)
    * Apply test on event type (accepeted_value)

### Part 3. 
   * dbt Snapshots 

``` sql
select name , count(name)
from dev_db.dbt_sonali_gupta.product_snapshot
where dbt_valid_to is not null
group by 1 ;
```
* Pothos
* Philodendron
* Monstera
* String of pearls
  








    
