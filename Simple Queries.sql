-- 1
SELECT sportinggoods_name, list_price, date_added
FROM sportinggoods_inventory
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added DESC;

-- 2
SELECT item_id, item_price, discount_amount, quantity, item_price*quantity AS price_total, 
discount_amount*quantity AS discount_total, (item_price-discount_amount)*quantity AS item_total
FROM athlete_order_items
WHERE (item_price-discount_amount)*quantity > 500
ORDER BY item_total DESC;

-- 3
SELECT NOW() AS today_unformatted, Date_format(NOW(),'%D %M %Y') AS today_formatted, date_format(NOW(), '%M %Y') AS 'MM/YYYY', date_format(NOW(), '%D %M %Y') AS 'DATE MONTH YEAR';
-- 4
SELECT first_name, last_name, line1, city, state, zip_code
FROM athlete_addresses ads JOIN athletes ath
ON ads.athlete_id = ath.athlete_id
WHERE ath.email_address = 'david.goldstein@hotmail.com';

-- 5
SELECT first_name, last_name, line1, city, state, zip_code
FROM athletes ath JOIN athlete_addresses ads
ON ath.athlete_id = ads.athlete_id
WHERE ath.billing_address_id = ads.address_id;

-- 6
SELECT last_name, first_name, order_date, sportinggoods_name, item_price, discount_amount, quantity
FROM athletes a, athlete_orders o, athlete_order_items aoi, sportinggoods_inventory si
WHERE a.athlete_id = o.athlete_id AND o.order_id = aoi.order_id AND aoi.sportinggoods_id = si.sportinggoods_id
ORDER BY last_name, order_date, sportinggoods_name;

-- 7
SELECT si1.sportinggoods_name, si1.list_price
FROM sportinggoods_inventory si1 JOIN sportinggoods_inventory si2
WHERE si1.sportinggoods_id != si2.sportinggoods_id AND si1.list_price = si2.list_price
ORDER BY si1.sportinggoods_name;

-- 8
SELECT 'SHIPPED' AS ship_date, order_ID, order_date
FROM athlete_orders
WHERE ship_date IS NOT NULL
UNION
SELECT 'NOT SHIPPED' AS ship_date, order_ID, order_date
FROM athlete_orders
WHERE ship_date IS NULL;



