-- 1. Total Customers in each state

select State, count(Consumer_ID) as customers from customer_details
group by State;

-- 2. Total Customers in each city
select City, count(Consumer_ID) as customers from customer_details
group by City;

-- 3. Budget level of customers
select Budget, count(Consumer_ID) as customers from customer_details
group by Budget;

-- 4. Total Smokers by Occupation
select Smoker, count(Consumer_ID) as customers from customer_details
group by Smoker;

-- 5. Drinking level of students
select Drink_Level, count(Consumer_ID) as students from customer_details
where Occupation = "Student"
group by Drink_Level;

-- 6. Transportation methods of customers
select Transportation_Method, count(Consumer_ID) as customers from customer_details
group by Transportation_Method;

-- 7. Adding Age Bucket Column

Alter table customer_details
add column Age_Bucket varchar(50);

-- 8. Updating the Age Bucket column with case when condition
Update customer_details
SET age_bucket = 
		 CASE WHEN age > 60 then '61 and Above'
		      WHEN age > 40 then '41 - 60'	
		      WHEN age > 25 then '26 - 40'
		      WHEN age >= 18 then '18 - 25'
		    END
WHERE age_bucket is null	;


-- 9. Total customers in each age bucket
-- 10. Total customers COUNT & smokers COUNT in each age percent
select * from customer_details;
-- 11. Top 10 preferred cuisines
-- 12. Preferred cuisines of each customer
-- 13. Customer Budget analysis for each cuisine
-- 14. Finding out number of preferred cuisine in each state