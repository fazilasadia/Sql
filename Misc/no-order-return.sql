CREATE TABLE namaste_orders (
    order_id INT,
    city VARCHAR(10),
    sales INT
);

INSERT INTO namaste_orders VALUES 
(1, 'Mysore', 100),
(2, 'Mysore', 200),
(3, 'Bangalore', 250),
(4, 'Bangalore', 150),
(5, 'Mumbai', 300),
(6, 'Mumbai', 500),
(7, 'Mumbai', 800);


CREATE TABLE namaste_returns (
    order_id INT,
    return_reason VARCHAR(20)
);

INSERT INTO namaste_returns VALUES 
(3, 'wrong item'),
(6, 'bad quality'),
(7, 'wrong item');



-- Write SQL query to find cities where not even a single order was returned.

SELECT city
FROM namaste_orders
WHERE order_id NOT IN (SELECT order_id FROM namaste_returns)
GROUP BY city
HAVING COUNT(*) = (
    SELECT COUNT(*) 
    FROM namaste_orders o2 
    WHERE o2.city = namaste_orders.city
);
