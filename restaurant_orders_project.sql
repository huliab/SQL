## USE restaurant_orders;
-- 1. View the menu_items table
SELECT *
FROM menu_items;

-- 2. Find the number of items on the menu
SELECT DISTINCT(COUNT(item_name))
FROM menu_items;

-- 3. What are the least and most expensive items on the menu ?

SELECT item_name,category,price
FROM menu_items
ORDER BY price ASC;

SELECT item_name,category,price
FROM menu_items
ORDER BY price desc;

-- 4. How many Italian dishes are on the menu?
SELECT DISTINCT (COUNT(item_name))
FROM menu_items
WHERE category = 'Italian';

-- 5. What are the least and most expensive Italian dishes on the menu ?

SELECT  item_name,price
FROM menu_items
WHERE category = "Italian"
ORDER BY price ASC;

SELECT  item_name,price
FROM menu_items
WHERE category = "Italian"
ORDER BY price DESC;

-- 6. How many dishes are in each category?

SELECT DISTINCT(COUNT(item_name)), category 
FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category ?
SELECT category, AVG(price) AS avg_price
FROM menu_items
GROUP BY category;

-- 1. View the order_details table. What is the date range of the table ?

SELECT *
FROM order_details;

SELECT MIN(order_date ), MAX(order_date)
FROM order_details;

-- 2. How many orders were made within this date range ? How many items were ordered within this date range ?
SELECT COUNT(DISTINCT(order_id))
FROM order_details;

SELECT COUNT(*)
FROM order_details;
-- 3. Which orders had the most number of items ?
SELECT order_id, COUNT(item_id ) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id ) DESC;

-- 4. How many orders had more than 12 items ?
SELECT COUNT(order_id) FROM
(SELECT order_id, COUNT(item_id ) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders ;


## Analyze Customer Behavior
-- 1. Combine the menu_items and order_details tables into single table
SELECT * FROM menu_items;
SELECT * FROM order_details;

SELECT *
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id;

-- 2. What were the least and most ordered items ? What categories were they in ?
SELECT category,item_name,COUNT(ï»¿order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases DESC
;
SELECT category,item_name,COUNT(ï»¿order_details_id) AS num_purchases
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
GROUP BY item_name,category
ORDER BY num_purchases ASC;

-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price) AS total_spend
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
limit 5 ;

-- 4. View the details of the highest spend order . What insight can you gather from the results ?
SELECT category,COUNT(item_id)
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
WHERE order_id = 440
GROUP BY category ;



-- 5: View the details of the top 5 highest spend orders. What insights can you gather from the results ?

SELECT category,COUNT(item_id)
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
WHERE order_id IN (440, 2075,1957,330,2675)
GROUP BY category ;

SELECT category,item_name, COUNT(item_id)
FROM order_details od LEFT JOIN menu_items mi
   ON od.item_id = mi.ï»¿menu_item_id
WHERE order_id IN (440, 2075,1957,330,2675)
GROUP BY category,item_name;