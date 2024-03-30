{{
  config(
    materialized='table'
  )
}}

SELECT
product_id
NAME , 
PRICE, 
INVENTORY 
from 
{{ source('postgres','products')}}