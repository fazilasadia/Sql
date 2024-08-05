create database library; 
use library;

create table books (
	book_id int primary key,
	title varchar(50),
	author_id int,
	category_id int,
	price int,
  stock_quantity int
);


INSERT INTO Books 
(book_id, title, author_id, category_id, price, stock_quantity)
VALUES 
(1, 'Harry Potter and the Philosopher''s Stone', 1, 1, 12.99, 50),
(2, '1984', 2, 1, 9.99, 30),
(3, 'To Kill a Mockingbird', 3, 1, 8.99, 40), 
(4, 'The Hobbit', 4, 3, 11.99, 25),
(5, 'Harry Potter and the Chamber of Secrets', 1, 1, 14.99, 45), 
(6, 'Animal Farm', 2, 1, 7.99, 35),
(7, 'The Fellowship of the Ring', 4, 3, 10.99, 20);


select * from books;

create table Authors(
	author_id int primary key,
	author_name varchar(30)
);


insert into Authors
(author_id, author_name)
VALUES
(1, 'J.K. Rowling'), 
(2, 'George Orwell'), 
(3, 'Harper Lee'),
(4, 'J.R.R. Tolkien');


select * from Authors;



create table Categories (
	category_id int primary key,
	category_name varchar(20)
);


insert into categories
(category_id, category_name)
VALUES 
	(1, 'Fiction'), 
	(2, 'Non-Fiction'),
	(3, 'Fantasy'), 
	(4, 'Science Fiction');

select * from categories;


create table transactions(
	transaction_id int primary key, 
	book_id int,
	transaction_date date,
	total_price int,
	quantity int
);


insert into transactions
(transaction_id, book_id, transaction_date, quantity, total_price) 
VALUES 
(1, 1, '2024-02-10', 3, 38.97), 
(2, 3, '2024-02-11', 2, 17.98),
(3, 5, '2024-02-12', 1, 14.99), 
(4, 2, '2024-02-13', 5, 49.95), 
(5, 4, '2024-02-14', 2, 23.98), 
(6, 7, '2024-02-15', 3, 32.97);

select * from transactions;
