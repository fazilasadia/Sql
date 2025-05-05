USE food;
select * from superstore;
select * from returns;

-- 1- write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character (58 rows)
SELECT 
    Customer_Name
FROM
    superstore
WHERE
    Customer_Name LIKE '_a_d%';

-- 2- write a sql to get all the orders placed in the month of dec 2020 (352 rows) 
SELECT 
    *
FROM
    superstore
WHERE
    MONTH(Order_Date) = '12'
        AND YEAR(Order_Date) = '2020';


-- 3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and 
-- ship_date is after nov 2020 (944 rows)

SELECT 
    *
FROM
    superstore
WHERE
    Ship_Mode NOT IN ('Standard Class' , 'First Class')
        AND Ship_Date > '2020-11-30';

-- 4- write a query to get all the orders where customer name neither start with "A" and nor ends with "n" (9815 rows)

SELECT 
    *
FROM
    Superstore
WHERE
    Customer_Name NOT LIKE 'A%n';

-- 5- write a query to get all the orders where profit is negative (1871 rows)
SELECT 
    *
FROM
    superstore
WHERE
    Profit < 0;

-- 6- write a query to get all the orders where either quantity is less than 3 or profit is 0 (3348)
SELECT 
    *
FROM
    superstore
WHERE
    Profit = 0 OR Quantity < 3;

-- 7- your manager handles the sales for South region and he wants you to create a report 
--  of all the orders in his region where some discount is provided to the customers (815 rows)

SELECT 
    *
FROM
    superstore
WHERE
    Region = 'South' AND Discount > 0;

-- 8- write a query to find top 5 orders with highest sales in furniture category 
SELECT 
    *
FROM
    superstore
WHERE
    Category = 'Furniture'
ORDER BY Sales DESC
LIMIT 5;

-- 9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only (1021 rows)
SELECT 
    *
FROM
    superstore
WHERE
    Category IN ('Furniture' , 'Technology')
        AND YEAR(Order_Date) = '2020';

-- 10- write a query to find all the orders where order date is in year 2020 but ship date is in 2021 (33 rows)

SELECT 
    *
FROM
    superstore
WHERE
    YEAR(Order_Date) = '2020'
        AND YEAR(Ship_Date) = '2021';
        



-- write a query to find orders where city is null (2 rows)
SELECT 
    *
FROM
    superstore
WHERE
    city IS NULL;

-- write a query to get total profit, first order date and latest order date for each category

SELECT 
    Category, min(Order_Date) as first, max(Order_Date) as last,  ROUND(SUM(Profit), 2) AS Total_Profit
FROM
    superstore
GROUP BY Category;

-- write a query to find total number of products in each category.
SELECT 
    Category, COUNT(DISTINCT Product_ID) AS no_products
FROM
    superstore
GROUP BY Category
ORDER BY no_products;

-- write a query to find top 5 sub categories in west region by total quantity sold

SELECT 
    Sub_category, SUM(Quantity) AS Total_Quantity
FROM
    superstore
WHERE
    Region = 'West'
GROUP BY Sub_category
ORDER BY Total_Quantity DESC limit 5;

-- write a query to find total sales for each region and ship mode combination for orders in year 2020

SELECT 
    Region, Ship_mode, SUM(Sales) AS Total_Sales
FROM
    superstore
WHERE
    YEAR(Order_Date) = '2020'
GROUP BY Region , Ship_Mode;
