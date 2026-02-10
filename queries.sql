/* A1.1 O2C connect rate for WhatsApp */
SELECT
  SUM(CASE WHEN clicked = TRUE OR replied = TRUE THEN 1 ELSE 0 END) * 1.0
  / SUM(CASE WHEN delivered = TRUE THEN 1 ELSE 0 END) AS o2c_connect_rate
FROM communication_logs
WHERE channel = 'WhatsApp';


/* A1.2 Top 5 cities with lowest O2C connect rate */
SELECT
  o.city,
  SUM(CASE WHEN c.clicked = TRUE OR c.replied = TRUE THEN 1 ELSE 0 END) * 1.0
  / SUM(CASE WHEN c.delivered = TRUE THEN 1 ELSE 0 END) AS o2c_connect_rate
FROM communication_logs c
JOIN orders o ON c.order_id = o.order_id
WHERE c.channel = 'WhatsApp'
GROUP BY o.city
ORDER BY o2c_connect_rate ASC
LIMIT 5;


/* A2.1 Repeat purchase rate by city */
SELECT
  city,
  SUM(CASE WHEN is_repeat_customer = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS repeat_purchase_rate
FROM orders
GROUP BY city;


/* A2.1 Repeat purchase rate by product_category */
SELECT
  product_category,
  SUM(CASE WHEN is_repeat_customer = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS repeat_purchase_rate
FROM orders
GROUP BY product_category;


/* A2.2 Cohort table: first purchase month × repeat purchase month */
WITH first_purchase AS (
  SELECT
    customer_id,
    DATE_TRUNC('month', MIN(order_date)) AS first_purchase_month
  FROM orders
  GROUP BY customer_id
)
SELECT
  fp.first_purchase_month,
  DATE_TRUNC('month', o.order_date) AS repeat_purchase_month,
  COUNT(DISTINCT o.customer_id) AS customers
FROM orders o
JOIN first_purchase fp ON o.customer_id = fp.customer_id
GROUP BY fp.first_purchase_month, repeat_purchase_month
ORDER BY fp.first_purchase_month, repeat_purchase_month;


/* A3.1 Promised vs actual delivery gap in days */
SELECT
  order_id,
  DATE_PART('day', actual_delivery_date - promised_delivery_date) AS delivery_gap_days
FROM orders;


/* A3.2 Orders delayed due to courier delay */
SELECT
  order_id
FROM supply_chain
WHERE courier_delay_flag = TRUE;


/* A3.3 Rank courier partners by avg shipment TAT */
SELECT
  o.shipment_partner,
  AVG(s.shipment_tat_hours) AS avg_shipment_tat_hours,
  RANK() OVER (ORDER BY AVG(s.shipment_tat_hours)) AS tat_rank
FROM orders o
JOIN supply_chain s ON o.order_id = s.order_id
GROUP BY o.shipment_partner;


/* A4 Communication channel metrics */
SELECT
  channel,
  SUM(CASE WHEN delivered = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS delivery_rate,
  SUM(CASE WHEN read = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS read_rate,
  SUM(CASE WHEN clicked = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ctr,
  SUM(CASE WHEN replied = TRUE THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS reply_rate
FROM communication_logs
GROUP BY channel;


/* A5 Support ticket analysis */
SELECT
  issue_category,
  AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600) AS avg_resolution_hours,
  SUM(CASE WHEN resolution_status = 'Escalated' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS escalation_rate,
  AVG(csat_score) AS avg_csat_score,
  COUNT(*) AS ticket_volume
FROM support_tickets
GROUP BY issue_category;


/* A6.1 % of orders with vet consult within 72 hours of delivery */
SELECT
  COUNT(DISTINCT v.order_id) * 1.0 / COUNT(DISTINCT o.order_id) AS pct_orders_with_vet_within_72h
FROM orders o
LEFT JOIN vet_calls v
  ON o.order_id = v.order_id
 AND v.call_start_time <= o.actual_delivery_date + INTERVAL '72 hours';


/* A6.2 Average duration of successful vet transfers (minutes) */
SELECT
  AVG(call_duration_secs) / 60.0 AS avg_duration_minutes
FROM vet_calls
WHERE vet_transfer_success = TRUE;
