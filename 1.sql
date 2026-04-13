
# window function on category of pizza_type
select category, name, count(category) over(partition by category) 
from pizza_types;
  
# running total/ cumulative revenue

WITH a AS (
    SELECT 
        orders.order_date,
        ROUND(SUM(order_details.quantity * pizzas.price), 2) AS sales
    FROM orders
    JOIN order_details USING(order_id)
    JOIN pizzas USING(pizza_id)
    GROUP BY orders.order_date
)

SELECT 
    order_date,
    sales,
    SUM(sales) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM a;
