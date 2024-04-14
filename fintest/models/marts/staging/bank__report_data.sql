{{
  config(
    materialized='table'
  )
}}

select * 
from  {{ source('postgres','bank') }}
