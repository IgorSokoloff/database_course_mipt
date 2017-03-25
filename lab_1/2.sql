--Выбрать список штатов в порядке увеличения объема продаж в штате. Включить в список только те штаты, в которых было не менее 10 продаж.

SELECT customer.state, SUM(ITEM.total) as TOTAL, COUNT(ITEM.item_id) as NUMBER 
FROM CUSTOMER INNER JOIN SALES_ORDER ON SALES_ORDER.customer_id = CUSTOMER.customer_id
			  INNER JOIN ITEM ON ITEM.order_id = SALES_ORDER.order_id
			  GROUP BY customer.state
			  HAVING COUNT(ITEM.item_id) >= 10
			  ORDER BY SUM(ITEM.total)