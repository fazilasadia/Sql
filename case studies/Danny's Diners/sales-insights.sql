
-- What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id, SUM(m.price) bill
FROM
    sales s
        JOIN
    menu m ON m.product_id = s.product_id
GROUP BY s.customer_id;

-- How many days has each customer visited the restaurant?
SELECT 
    customer_id, SUM(DAY(order_date)) num_days
FROM
    sales
GROUP BY customer_id;

-- What was the first item from the menu purchased by each customer?
select customer_id, product_name 
from (
select customer_id, order_date, product_name,
rank() over(partition by customer_id order by order_date) rnk
from (SELECT 
    s.customer_id, s.order_date, m.product_name
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
ORDER BY s.order_date) all_orders) tab_2
where rnk = 1; 


-- What is the most purchased item on the menu and 
-- how many times was it purchased by all customers?

SELECT 
    menu.product_name, COUNT(sales.product_id) purchase
FROM
    sales
        JOIN
    menu ON menu.product_id = sales.product_id
GROUP BY menu.product_name
ORDER BY purchase DESC
LIMIT 1;

-- Which item was the most popular for each customer?

select customer_id, product_name from (
select *, rank() over(partition by customer_id order by num_order desc) as rnk
 from (select customer_id, m.product_name, count(m.product_id) num_order
from sales
Join menu m 
on sales.product_id = m.product_id
group by customer_id, m.product_name) tab) tab2
where rnk =1 ;

-- Which item was purchased first by the customer after they became a member?

select customer_id, product_name 
from (select *, rank() over(partition by customer_id order by order_date) rnk 
from (SELECT 
    s.customer_id,
    m.product_name,
    s.order_date,
    s.product_id,
    b.join_date
FROM
    sales s
        JOIN
    members b ON s.customer_id = b.customer_id
        JOIN
    menu m ON s.product_id = m.product_id
WHERE
    s.order_date > b.join_date
ORDER BY s.order_date) tab) tab2
where rnk =1;

-- Which item was purchased just before the customer became a member?
select  customer_id, product_name from 
(
select *, rank() over(partition by customer_id order by order_date desc) rnk from 
(SELECT 
    s.customer_id,
    s.order_date,
    m.product_name,
    m.product_id,
    b.join_date
FROM
    sales s
        JOIN
    members b ON s.customer_id = b.customer_id
        JOIN
    menu m ON m.product_id = s.product_id
WHERE
    s.order_date < b.join_date) tab) tab2
where rnk =1;


-- What is the total items and amount spent for each member before they became a member?

select customer_id,  sum(price) as spent,  count( product_id) total_items  from (
select *, rank() over(partition by customer_id order by order_date desc) rnk from 
(SELECT 
    s.customer_id,
    s.order_date,
    m.product_name,
    m.price,
    m.product_id,
    b.join_date
FROM
    sales s
        JOIN
    members b ON s.customer_id = b.customer_id
        JOIN
    menu m ON m.product_id = s.product_id
WHERE
    s.order_date < b.join_date) tab) tab_2
group by customer_id;

-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier 
-- - how many points would each customer have?
SELECT 
    customer_id, SUM(points) points
FROM
    (SELECT 
        *,
            CASE
                WHEN product_name = 'sushi' THEN amount * 20
                ELSE amount * 10
            END AS 'points'
    FROM
        (SELECT 
        s.customer_id, m.product_name, SUM(m.price) amount
    FROM
        sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.customer_id , m.product_name) tab) tab_2
GROUP BY customer_id;


-- In the first week after a customer joins the program (including their join date) 
-- they earn 2x points on all items, not just sushi - 
-- how many points do customer A and B have at the end of January?
SELECT 
    customer_id, SUM(amount * 10 * 2) AS 'points'
FROM
    (SELECT 
        s.customer_id,
            s.order_date,
            m.product_name,
            m.price amount,
            m.product_id,
            b.join_date
    FROM
        sales s
    JOIN members b ON s.customer_id = b.customer_id
    JOIN menu m ON m.product_id = s.product_id
    WHERE
        MONTH(s.order_date) = 1
            AND YEAR(s.order_date) = YEAR(b.join_date)
            AND s.order_date >= b.join_date) tab
GROUP BY customer_id
ORDER BY points DESC;




