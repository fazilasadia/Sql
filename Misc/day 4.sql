USE food;
-- pareto principle says '80% of your sales comes from 20% of your products'

-- so the question is : 
-- give me those top products which generates 80% of total sales

select * from superstore;
select sum(sales) * 0.8 from superstore;

-- sales per product  

select Product_ID, sum(Sales) from superstore
group by Product_ID;

--  Calculate Running Sales and Compare with 80% Threshold

select sum(sales) over(order by )