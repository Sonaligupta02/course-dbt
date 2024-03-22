{{
  config(
    materialized='table'
  )
}}

SELECT
NAME , 
PRICE, 
INVENTORY 
from 
{{ source('postgres','products')}}