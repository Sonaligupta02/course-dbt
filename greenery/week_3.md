## part 1 
- conversion rate
``` sql
select 
count(distinct case when checkout = 1 then session_id end) / count( distinct session_id) * 100 as conversion_rate
from {{ref ('fact_page_views')}}
 ```
#### Ans: CONVERSION_RATE = 62.4567
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
#### Ans: CONVERSION_RATE BY PRODUCT
* String of pearls	60.937500
* Arrow Head	55.555600
* Cactus	54.545500
* ZZ Plant	53.968300
* Bamboo	53.731300
* Rubber Plant	51.851900
* Monstera	51.020400
* Calathea Makoyana	50.943400
* Fiddle Leaf Fig	50.000000
* Majesty Palm	49.253700
* Aloe Vera	49.230800
* Devil's Ivy	48.888900
* Philodendron	48.387100
* Jade Plant	47.826100
* Pilea Peperomioides	47.457600
* Spider Plant	47.457600
* Dragon Tree	46.774200
* Money Tree	46.428600
* Orchid	45.333300
* Bird of Paradise	45.000000
* Ficus	42.647100
* Birds Nest Fern	42.307700
* Pink Anthurium	41.891900
* Boston Fern	41.269800
* Alocasia Polly	41.176500
* Peace Lily	40.909100
* Ponytail Palm	40.000000
* Snake Plant	39.726000
* Angel Wings Begonia	39.344300
* Pothos	34.426200


## Part 2: 
``` sql
{% macro sum_of(col_name, col_value) %}

sum(case when {{ col_name }} = '{{ col_value }}' then 1 else 0 end)

{% endmacro%}
 ```
``` sql
{% macro grant(role) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
      GRANT SELECT ON {{ this }} TO ROLE {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}
 ```
## Part 3:
+post-hook:
      - "{{ grant(role='reporting') }}"

## Part 4:
packages:
  - package: dbt-labs/dbt_utils
    version: 1.1.1
  - package: calogica/dbt_expectations
    version: 0.10.3  

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
