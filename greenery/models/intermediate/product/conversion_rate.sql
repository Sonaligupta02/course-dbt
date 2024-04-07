select 
count(distinct case when checkout = 1 then session_id end) / count( distinct session_id) * 100 as conversion_rate
from {{ref ('fact_page_views')}}