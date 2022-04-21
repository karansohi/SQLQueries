-- 1
SELECT c.category_name, COUNT(i.category_id) AS products_total, MAX(i.list_price) AS max_product
FROM sportinggoods_categories AS c ,sportinggoods_inventory AS i
WHERE i.category_id = c.category_id
GROUP BY c.category_id
ORDER BY COUNT(*) DESC;

-- 2
SELECT a.email_address AS email, SUM(aoi.item_price*aoi.quantity) AS tot_price, SUM(aoi.discount_amount*aoi.quantity) AS tot_discount
FROM athletes a JOIN athlete_orders ao ON a.athlete_id = ao.athlete_id 
JOIN athlete_order_items aoi ON ao.order_id = aoi.order_id
GROUP BY a.email_address
ORDER BY tot_price DESC;

-- 3
SELECT a.email_address, COUNT(ao.order_id) AS tot_orders, SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) AS tot_amount
FROM athletes a JOIN athlete_orders ao ON a.athlete_id = ao.athlete_id 
JOIN athlete_order_items aoi ON  ao.order_id = aoi.order_id
GROUP BY a.email_address
HAVING COUNT(ao.order_id) > 1
ORDER BY tot_amount DESC;

-- 4
SELECT a.email_address, COUNT(ao.order_id) AS tot_orders, SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) AS tot_amount
FROM athletes a JOIN athlete_orders ao ON a.athlete_id = ao.athlete_id 
JOIN athlete_order_items aoi ON ao.order_id = aoi.order_id 
WHERE aoi.item_price > 400
GROUP BY a.email_address
HAVING COUNT(ao.order_id) > 1
ORDER BY tot_amount DESC;

-- 5
SELECT si.sportinggoods_name, SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) AS tot_amount
FROM sportinggoods_inventory si JOIN athlete_order_items aoi ON si.sportinggoods_id = aoi.sportinggoods_id
GROUP BY si.sportinggoods_name WITH ROLLUP;

-- 6
SELECT a.email_address, COUNT(distinct aoi.sportinggoods_id) AS distinct_orders
FROM athletes a JOIN athlete_orders ao ON a.athlete_id = ao. athlete_id
JOIN athlete_order_items aoi ON ao.order_id = aoi.order_id
GROUP BY a.email_address
HAVING distinct_orders > 1;

-- 7
SELECT IF(GROUPING(c.category_name) = 1, 'Category_Total', c.category_name) AS Category_Name,
IF(GROUPING(si.sportinggoods_name) = 1, 'SG_total', si.sportinggoods_name) AS SG_Name,
SUM(distinct si.sportinggoods_id) AS tot_quantity
FROM sportinggoods_categories c JOIN sportinggoods_inventory si ON c.category_id = si.category_id
JOIN athlete_order_items aoi ON si.sportinggoods_id = aoi.sportinggoods_id
GROUP BY c.category_name, si.sportinggoods_name WITH ROLLUP;

-- 8
SELECT aoi.order_id, (aoi.item_price - aoi.discount_amount)*aoi.quantity AS item_amount,
 SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) OVER(PARTITION BY aoi.order_id) AS order_amount
FROM athlete_order_items aoi
ORDER BY order_id;

-- 9
SELECT aoi.order_id, (aoi.item_price - aoi.discount_amount)*aoi.quantity  AS item_amount,
 SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) OVER(PARTITION BY aoi.order_id) AS order_amount,
 ROUND(AVG((aoi.item_price - aoi.discount_amount)*aoi.quantity) OVER(PARTITION BY order_id),2)
FROM athlete_order_items aoi
ORDER BY order_id, item_amount;

-- 10
SELECT ao.athlete_id, ao.order_date, (aoi.item_price - aoi.discount_amount)*aoi.quantity AS total_amt,
SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) OVER(PARTITION BY ao.athlete_id) AS athlete_total,
SUM((aoi.item_price - aoi.discount_amount)*aoi.quantity) OVER(PARTITION BY ao.order_date) AS athlete_total_by_date
FROM athlete_orders ao JOIN athlete_order_items aoi ON ao.order_id = aoi.order_id
ORDER BY ao.athlete_id;





