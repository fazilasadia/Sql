-- Displays all book information along with the author and category.

select b.title,  c. category_name, a.author_name from books b
	join categories c
	on b.category_id = c.category_id
	join authors a
	on a.author_id = b.author_id;


-- Displays the total revenue from book sales per category.

select c.category_name, sum((t.total_price * t.quantity)) as revenue from transactions t
	join books b
	on b.book_id = t.book_id
	join categories c
	on b.category_id = c.category_id
	group by c.category_name
	;

-- Displays the top 5 bestsellers (based on the number of sales)
select b.title,  t.quantity as sales from transactions t
	join books b
	on b.book_id = t.book_id
	order by sales desc limit 5
	;


-- Displays a list of authors who have more than one book in the catalog

select author_name from
(
select a.author_name, row_number() over(partition by a.author_id) as r from books b
	join authors a
	on b.author_id = a.author_id) tab
	where r >1
	;    

-- Displays the total revenue from sales per month.

select Extract(month from transaction_date) as month, sum(total_price * quantity) as revenue from transactions
	group by month;

