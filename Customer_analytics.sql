-- 13. How many *unique customers* have placed orders?
-- 14. What is the *average number of orders per customer*?
-- 15. Who are the *top 10 customers by lifetime spend*?
-- 16. What percentage of total revenue comes from the *top 10% of customers*?
-- 17. How many customers are *repeat buyers*?
-- 18. What is the *average customer lifetime value (LTV)*?

-- 13
SELECT
    COUNT(DISTINCT customer_id) AS total_unique_customers
FROM orders;

-- 14
SELECT
    ROUND(
        COUNT(order_id) / COUNT(DISTINCT customer_id),
        2
    ) AS avg_orders_per_customer
FROM orders
WHERE order_status = 'delivered';

-- 15
with customer_total_spend as
(select 
  o.customer_id,
  sum(oi.price+oi.freight_value) as total_spend
from orders o
join order_items oi
  on o.order_id=oi.order_id
where o.order_status='delivered'
group by o.customer_id),
ranked_spend as(
select 
  customer_id,
  total_spend,
rank() over(order by total_spend desc) as rnk
from customer_total_spend
)
select 
  customer_id,total_spend,rnk
from ranked_spend
where rnk<=10
order by total_spend desc;

-- 16
with customer_total_spend as
(select 
  o.customer_id,
  sum(oi.price+oi.freight_value) as total_spend
from orders o
join order_items oi
  on o.order_id=oi.order_id
where o.order_status='delivered'
group by o.customer_id),
ranked_spend as(
select 
  customer_id,
  total_spend,
rank() over(order by total_spend desc) as rnk
from customer_total_spend
),
counts as(
  select count(*) as total_customers
from ranked_spend
)
select 
  round((sum(case when rnk<=(select total_customers*0.1 from counts) 
    then total_spend else 0 end)/sum(total_spend))*100,2)
  as top_10_customer_spend_percentage
from ranked_spend;

-- 17
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) >= 2
) AS repeat_buyers;

-- 18
WITH customer_ltv AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price + oi.freight_value) AS lifetime_spend
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    ROUND(AVG(lifetime_spend), 2) AS avg_customer_ltv
FROM customer_ltv;












