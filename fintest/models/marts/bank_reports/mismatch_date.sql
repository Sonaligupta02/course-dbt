WITH postgres_data AS (
    SELECT
        DATE(booked_time) AS transaction_day,
        SUM(revenue) AS total_amount_postgres, 
        currency
    FROM
        {{ref('client__transactions_data')}}
    GROUP BY
        DATE(booked_time),3
),
csv_data AS (
    -- Extract total transaction amounts for each day from CSV export
    SELECT
        date::date AS transaction_day,
        SUM(amount) AS total_amount_csv,
        currency
    FROM
    {{ref('bank__report_data')}}
    GROUP BY
        date::date,3
)
-- Combine results to identify days with data mismatches
SELECT
    COALESCE(p.transaction_day, c.transaction_day) AS mismatched_day
FROM
    postgres_data p
FULL JOIN
    csv_data c ON p.transaction_day = c.transaction_day
WHERE
    p.total_amount_postgres IS NULL OR c.total_amount_csv IS NULL OR p.total_amount_postgres != c.total_amount_csv
ORDER BY
    mismatched_day