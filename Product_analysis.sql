-- 7 Which are the top 10 products by total revenue?
-- 8 Which product categories generate the highest revenue?
-- 9 Which product categories have the highest number of orders?
-- 10 Which products have high order volume but low revenue?
-- 11 What percentage of total revenue comes from the top 5 product categories?
-- 12 Which product categories have the highest average item price?

-- 7
select 
  round(sum(oi.price+oi.freight_value),2) as total_revenue, 
  oi.product_id
from order_items oi 
join orders o 
  on oi.order_id=o.order_id
where o.order_status='delivered'
group by oi.product_id
order by total_revenue desc
limit 10;

-- 8
select 
  round(sum(oi.price+oi.freight_value),2) as total_revenue, 
  p.product_category_name
from order_items oi 
join products p 
  on oi.product_id=p.product_id
join orders o 
  on o.order_id=oi.order_id
where o.order_status='delivered'
group by p.product_category_name
order by total_revenue desc;

-- 9
select 
  count(oi.order_id) as total_count,
  p.product_category_name
from order_items oi
join products p
  on oi.product_id=p.product_id
group by p.product_category_name
order by total_count desc;

-- 10
SELECT
    oi.product_id,
    COUNT(oi.order_id) AS order_volume,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY oi.product_id
ORDER BY order_volume DESC, total_revenue ASC
LIMIT 10;

-- 11
with category_revenue as
(select 
   p.product_category_name,
   sum(oi.price+oi.freight_value) as category_revenue
from order_items oi 
join products p 
   on oi.product_id=p.product_id
join orders o
   on o.order_id=oi.order_id
where o.order_status='delivered'
group by p.product_category_name),
ranked_categories as(
  select product_category_name,
  category_revenue,
  rank() over (order by category_revenue desc) as rnk
from category_revenue
)
SELECT
    ROUND(
        (SUM(CASE WHEN rnk <= 5 THEN category_revenue ELSE 0 END)
        / SUM(category_revenue)) * 100,
        2
    ) AS top_5_category_revenue_percentage
FROM ranked_categories;

-- 12
SELECT
    p.product_category_name,
    ROUND(AVG(oi.price), 2) AS avg_item_price
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY avg_item_price DESC;







