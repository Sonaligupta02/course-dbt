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
