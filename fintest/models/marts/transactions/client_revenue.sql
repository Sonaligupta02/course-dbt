WITH euro_exchange_rates AS (
    SELECT
        date,
        rate
    FROM 
     {{ref('exchange__rate_data')}}
    WHERE
        buy_currency = 'EUR'
)
, converted_revenue AS (
    SELECT
        t.id,
        t.booked_time,
        t.client_name,
        t.revenue,
        t.currency,
        er.rate AS exchange_rate_to_eur,
        CASE
            WHEN t.currency = 'EUR' THEN t.revenue
            ELSE t.revenue * er.rate
        END AS revenue_in_eur
    FROM
     {{ref ('client__transactions_data')}} as t
    LEFT JOIN
        euro_exchange_rates er ON t.booked_time::DATE = er.date
)
SELECT
    TO_CHAR(booked_time, 'YYYY-MMMM') AS year_month,
    client_name,
    SUM(revenue_in_eur) AS total_revenue_in_eur
FROM
    converted_revenue
GROUP BY year_month,
    client_name
ORDER BY year_month,
    client_name