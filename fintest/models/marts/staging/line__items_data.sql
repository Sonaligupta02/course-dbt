{{
  config(
    materialized='table'
  )
}}

select * 
from  {{ source('postgres','line_item') }}
