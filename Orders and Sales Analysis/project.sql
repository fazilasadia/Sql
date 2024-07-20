create database pizzeria;
 
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);

create table orders_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);

-- Retrieve the total number of orders placed.
select count(order_id) total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
select round(sum(p.price * d.quantity)) revenue
from pizzas p
join orders_details d 
on p.pizza_id = d.pizza_id;

-- Identify the highest-priced pizza.

select pt.name, p.price from pizza_types pt
Join pizzas p 
on pt.pizza_type_id = p.pizza_type_id
order by p.price desc limit 1;

-- Identify the most common pizza size ordered.
select p.size, sum(d.quantity) from pizzas p
Join orders_details d
on p.pizza_id = d.pizza_id
group by p.size
order by sum(d.quantity) desc limit 1;

-- List the top 5 most ordered pizza types along with their quantities.
select  pt.name ,  sum(d.quantity) as quant from pizzas p 
Join orders_details d 
on p.pizza_id = d.pizza_id 
Join pizza_types pt
on pt.pizza_type_id = p.pizza_type_id
group by pt.name
order by quant desc limit 5;


-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category, sum(d.quantity) quant from pizza_types pt
join pizzas p
on pt.pizza_type_id = p.pizza_type_id
Join orders_details d
on d.pizza_id = p.pizza_id
group by pt.category;

-- Determine the distribution of orders by hour of the day.

select hour(o.order_time), sum(d.quantity) quant from orders o 
Join orders_details d
on o.order_id = d.order_id
group by hour(o.order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select pt.category, pt.name, sum(d.quantity) quant from pizza_types pt
Join pizzas p
on p.pizza_type_id = pt.pizza_type_id
join orders_details d
on p.pizza_id = d.pizza_id
group by  pt.name, pt.category
order by quant desc;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(av) from 
(select o.order_date, sum(d.quantity) av from orders o
join orders_details d
on o.order_id = d.order_id
group by o.order_date) as avg_orders;

-- Determine the top 3 most ordered pizza types based on revenue.
select pt.name, sum(p.price * d.quantity) rev from pizzas p
Join orders_details d 
on p.pizza_id = d.pizza_id
Join pizza_types pt
On p.pizza_type_id = pt.pizza_type_id
group by pt.name 
order by rev desc limit 3;


-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.



-- Analyze the cumulative revenue generated over time.

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, category, rnk from (select name , rev, category, rank() over(partition by category order by rev desc) rnk from (select pt.name, pt.category, round(sum(p.price * d.quantity)) rev from pizzas p
Join orders_details d 
on p.pizza_id = d.pizza_id
Join pizza_types pt
On p.pizza_type_id = pt.pizza_type_id
group by   pt.category, pt.name
order by  rev desc) as tab) as b
where rnk <=3
order by  category ;