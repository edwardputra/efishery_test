SELECT 
    HASHTEXT(CONCAT(o.order_number, ',', o.customer_id)) AS order_date_id,
    HASHTEXT(CONCAT(i.invoice_number, ',', i.order_number)) AS invoice_date_id,
    HASHTEXT(CONCAT(p.payment_number, ',', p.invoice_number)) AS payment_date_id,
    customer_id,
    o.order_number,
    i.invoice_number,
    p.payment_number,
    SUM(quantity) AS total_order_quantity,
    SUM(usd_amount) AS total_order_usd_amount,
    i.date - o.date AS order_to_invoice_lag_days,
    p.date - i.date AS invoice_to_payment_lag_days
    
FROM customers c 
JOIN orders o ON c.id = o.customer_id
JOIN order_lines ol ON o.order_number = ol.order_number
JOIN invoices i ON o.order_number = i.order_number
JOIN payments p ON i.invoice_number = p.invoice_number

GROUP BY order_date_id, invoice_date_id, payment_date_id, customer_id, o.order_number, i.invoice_number, p.payment_number, order_to_invoice_lag_days, invoice_to_payment_lag_days