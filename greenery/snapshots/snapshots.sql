{{
  config(
    target_database = 'dev_db',
    target_schema = dbt_sonali_gupta,
    strategy='check',
    unique_key='product_id',
    check_cols=['inventory'],
   )
}} 

select * from 
{{source('postgres', 'products')}}