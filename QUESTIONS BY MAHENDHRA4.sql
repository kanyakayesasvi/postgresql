-- The manager on employees wants to know which are the products that have been ordered 
-- but are not in stock for all employees reporting into him/her





select first_name from employees where employee_id in
(select reports_to from employees where employee_id in
(select employee_id from order_details od join orders o using(order_id)  
where product_id in
 (select product_id from products where units_in_stock = 0)))
 
 
 
SELECT distinct e1.first_name ||' '|| e1.last_name
FROM employees e1 
JOIN employees e2 ON e1.employee_id = e2.reports_to 
JOIN orders o ON e2.employee_id = o.employee_id 
JOIN order_details od ON o.order_id = od.order_id 
where product_id in
 (select product_id from products where units_in_stock = 0) 
 
 
 
SELECT e1.first_name 
FROM employees e1 
JOIN employees e2 ON e1.employee_id = e2.reports_to 
JOIN orders o ON e2.employee_id = o.employee_id 
JOIN order_details od ON o.order_id = od.order_id 
JOIN products p ON od.product_id = p.product_id 
WHERE p.units_in_stock = 0;







SELECT c.customer_id, c.company_name, SUM(od.quantity) as total_quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN (
    SELECT region, AVG(od.quantity) AS avg_quantity
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY region
) AS region_avgs ON c.region = region_avgs.region
GROUP BY c.customer_id, c.company_name, region_avgs.avg_quantity
HAVING SUM(od.quantity) > region_avgs.avg_quantity;




