## Finmid Test 

#### Tools:
 - Snowflake
 - DBT for pipeline
   
#### Process:
- step 1: First save all the data in excel format in local.
- step 2: Import all the data in snowflake.
- step 3: Create a staging models in dbt for all the raws data.
- step 4: Start creating a code for all part1 and part2.
- step 5: All output avaible as a views in snowflake
  
## Part 1
#### Revenue per month per client - Report how much revenue in EUR earned for each client every month.
- if stakeholder looking this reports, we need to give a view access of client_revenue table in snowflake.
- for query/code open client_revenue.sql in dbt
- for output run a table client_revenue

#### Transaction distribution - Analyse the basket size of transactions to give insights on amounts spent by customer over time.
- if stakeholder looking this reports, we need to give a view access of transactions_distribution table in snowflake.
- for query/code open client_revenue.sql in dbt
- for output run a table client_revenue

## Part 2

- Which days have mismatches of data.
- if stakeholder looking this reports, we need to give a view access of transactions_distribution table in snowflake.

- 
- Potential transactions which might be missing from bank account export.
