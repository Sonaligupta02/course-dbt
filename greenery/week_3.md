## part 1 
- conversion rate
``` sql
select 
count(distinct case when checkout = 1 then session_id end) / count( distinct session_id) * 100 as conversion_rate
from {{ref ('fact_page_views')}}
 ```
#### Ans: 
- conversion rate by product
``` sql  
  {{ 
    config(
        materialized='table',
        alias='product_conversion_rate'
    )
}}

with page_views as (
    select * from {{ ref('fact_page_views') }}
)

select 
    product_id,
    count(distinct case when checkout = 1 then session_id end) / count(distinct session_id) * 100 as conversion_rate
from 
    page_views
group by 
    1
   ```
#### Ans:

## Part 6. dbt Snapshots

``` sql
select name , count(name)
from dev_db.dbt_sonali_gupta.product_snapshot
where dbt_valid_to is not null
group by 1
 ```

* Product name:
* Pothos
* Philodendron
* Monstera
* String of pearls
* Bamboo
* ZZ Plant
