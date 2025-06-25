-- 1. Top 5 best-selling items by revenue
SELECT itemname, SUM(revenue) AS total_revenue
FROM zara_sales
GROUP BY itemname
ORDER BY total_revenue DESC
LIMIT 5;

-- 2. Total sales and revenue per section
SELECT section, SUM(sales_volume) AS total_sales, SUM(revenue) AS total_revenue
FROM zara_sales
GROUP BY section;

-- 3. Most common item types sold
SELECT item_type, COUNT(*) AS frequency
FROM zara_sales
GROUP BY item_type
ORDER BY frequency DESC;

-- 4. Average price per item type
SELECT item_type, AVG(price) AS average_price
FROM zara_sales
GROUP BY item_type;

-- 5. Items with seasonal tag and their total sales
SELECT itemname, SUM(sales_volume) AS total_sales
FROM zara_sales
WHERE seasonal_tag = 'Yes'
GROUP BY itemname
ORDER BY total_sales DESC;

-- 6. Revenue per promotion type
SELECT promotion_type, SUM(revenue) AS total_revenue
FROM zara_sales
GROUP BY promotion_type;

-- 7. Most expensive item sold per section
WITH ranked_items AS (
  SELECT itemname, section, price,
         RANK() OVER (PARTITION BY section ORDER BY price DESC) AS rank
  FROM zara_sales
)
SELECT itemname, section, price
FROM ranked_items
WHERE rank = 1;

-- 8. Compare average revenue of promotional vs non-promotional items
SELECT promotion_type, AVG(revenue) AS avg_revenue
FROM zara_sales
GROUP BY promotion_type;

-- 9. Top 3 jackets with highest sales_volume
WITH jacket_sales AS (
  SELECT itemname, sales_volume,
         RANK() OVER (ORDER BY sales_volume DESC) AS rank
  FROM zara_sales
  WHERE item_type = 'Jacket'
)
SELECT itemname, sales_volume
FROM jacket_sales
WHERE rank <= 3;

-- 10. Cumulative revenue per section
SELECT section, itemname, revenue,
       SUM(revenue) OVER (PARTITION BY section ORDER BY revenue DESC) AS cumulative_revenue
FROM zara_sales;

-- 11. % rank of each item by revenue
SELECT itemname, revenue,
       PERCENT_RANK() OVER (ORDER BY revenue DESC) AS percent_rank
FROM zara_sales;

-- 12. Classify items as top/mid/low sellers
SELECT itemname, sales_volume,
       CASE 
         WHEN sales_volume > 50000 THEN 'Top Seller'
         WHEN sales_volume BETWEEN 10000 AND 50000 THEN 'Mid Seller'
         ELSE 'Low Seller'
       END AS sales_classification
FROM zara_sales;


