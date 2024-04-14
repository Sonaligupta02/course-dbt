{{
  config(
    materialized='table'
  )
}}

select * 
from  {{ source('postgres','exchange_rates') }}

