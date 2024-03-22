# Welcome to your new dbt project!

## Query: How many users do we have?

```sql
SELECT COUNT(user_guid) as num_of_users
FROM dev_db.dbt_sonali_gupta.stg_postgres__users;
