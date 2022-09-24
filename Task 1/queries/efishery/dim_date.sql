SELECT 
    HASHTEXT(CONCAT(payment_number, ',', invoice_number)) AS id,
    date AS date,
    EXTRACT (MONTH FROM date) AS "month",
    EXTRACT (QUARTER FROM date) AS quarter_of_year,
    EXTRACT (YEAR FROM date) AS "year",
    CASE
        WHEN EXTRACT(ISODOW FROM date) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM payments

UNION ALL

SELECT 
    HASHTEXT(CONCAT(invoice_number, ',', order_number)) AS id,
    date AS date,
    EXTRACT (MONTH FROM date) AS "month",
    EXTRACT (QUARTER FROM date) AS quarter_of_year,
    EXTRACT (YEAR FROM date) AS "year",
    CASE
        WHEN EXTRACT(ISODOW FROM date) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM invoices

UNION ALL

SELECT 
    HASHTEXT(CONCAT(order_number, ',', customer_id)) AS id,
    date AS date,
    EXTRACT (MONTH FROM date) AS "month",
    EXTRACT (QUARTER FROM date) AS quarter_of_year,
    EXTRACT (YEAR FROM date) AS "year",
    CASE
        WHEN EXTRACT(ISODOW FROM date) IN (6, 7) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM orders