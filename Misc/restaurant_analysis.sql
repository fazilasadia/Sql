-- Top Outlet by cuisine type without using limit and top function

with cte as (
SELECT 
    Restaurant_id, Cuisine, COUNT(*) AS no_of_orders
FROM
    Orders
group by Restaurant_id, Cuisine
)
select Restaurant_id, Cuisine from (
select *,  row_number() OVer (partition by cuisine order by no_of_orders DESC) as rn from cte) a
where rn = 1;


-- Find the new daily customer count from launch date

with cte as
(SELECT 
    customer_code,
    CAST(MIN(Placed_at) AS DATE) AS first_order_date
FROM
    orders
GROUP BY customer_code)

SELECT 
    COUNT(customer_code) AS new_customers, first_order_date
FROM
    cte
GROUP BY first_order_date
ORDER BY first_order_date;



-- Count of all the users who were acquired in Jan 2025 and placed only one order and did not placed any other order after that

SELECT 
    Customer_code, COUNT(customer_code) AS order_count
FROM
    orders
WHERE
    MONTH(Placed_at) = 1
        AND YEAR(Placed_at) = 2025
        AND customer_code NOT IN (SELECT 
            Customer_code
        FROM
            orders
        WHERE
            NOT (MONTH(Placed_at) = 1
                AND YEAR(Placed_at) = 2025))
GROUP BY Customer_code
HAVING order_count = 1;

