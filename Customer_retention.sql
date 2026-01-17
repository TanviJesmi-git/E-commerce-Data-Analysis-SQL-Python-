-- 19. What is the *last purchase date* for each customer?
-- 20. How many customers have *not purchased in the last 90 days*?
-- 21. Among repeat customers, how many are *at churn risk*?
-- 22. What is the *average time gap between purchases* for repeat customers?
-- 23. Which states have the *highest number of churn-risk customers*?

-- 19
select 
 max(date_format(o.order_purchase_timestamp,'%Y-%m-%d')) as last_purchase_date,
 c.customer_unique_id
from orders o 
join customers c
  on o.customer_id=c.customer_id
group by c.customer_unique_id
order by last_purchase_date;

-- 20
WITH last_purchase AS (
    SELECT
        c.customer_unique_id,
        DATE(MAX(o.order_purchase_timestamp)) AS last_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),
reference_date AS (
    SELECT
        DATE(MAX(order_purchase_timestamp)) AS ref_date
    FROM orders
)
SELECT
    COUNT(*) AS inactive_customers_90_days
FROM last_purchase,reference_date
WHERE DATEDIFF(ref_date,last_purchase_date) > 90;

-- 21
WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count,
        DATE(MAX(o.order_purchase_timestamp)) AS last_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
),
reference_date AS (
    SELECT
        DATE(MAX(order_purchase_timestamp)) AS ref_date
    FROM orders
)
SELECT
    COUNT(*) AS repeat_customers_at_churn_risk
FROM customer_orders co
CROSS JOIN reference_date rd
WHERE
    co.order_count >= 2
    AND DATEDIFF(rd.ref_date, co.last_purchase_date) > 90;

-- 22
WITH ordered_purchases AS (
    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        LAG(o.order_purchase_timestamp) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS previous_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
)
SELECT
    AVG(DATEDIFF(order_purchase_timestamp, previous_purchase_date)) 
        AS avg_days_between_purchases
FROM ordered_purchases
WHERE previous_purchase_date IS NOT NULL;

-- 23
WITH customer_last_purchase AS (
    SELECT
        c.customer_unique_id,
        c.customer_state,
        DATE(MAX(o.order_purchase_timestamp)) AS last_purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY
        c.customer_unique_id,
        c.customer_state
),
reference_date AS (
    SELECT
        DATE(MAX(order_purchase_timestamp)) AS ref_date
    FROM orders
)

SELECT
    clp.customer_state,
    COUNT(*) AS churn_risk_customers
FROM customer_last_purchase clp
CROSS JOIN reference_date rd
WHERE DATEDIFF(rd.ref_date, clp.last_purchase_date) > 90
GROUP BY clp.customer_state
ORDER BY churn_risk_customers DESC;


    



