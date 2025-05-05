CREATE DATABASE restaurant_analysis;

USE restaurant_analysis;

-- Creating customer_ratings table
CREATE TABLE Customer_Ratings (
    Consumer_ID VARCHAR(50),
    Restaurant_ID VARCHAR(50),
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT
);

-- Creating customer_details table
CREATE TABLE Customer_Details(
    Consumer_ID VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    Smoker VARCHAR(50),
    Drink_Level VARCHAR(50),
    Transportation_Method VARCHAR(50),
    Marital_Status VARCHAR(50),
    Children VARCHAR(50),
    Age INT,
    Occupation VARCHAR(50),
    Budget VARCHAR(50)
);

-- Creating customer_preference table
CREATE TABLE Customer_Preference(
    Consumer_ID VARCHAR(50),
    Preferred_Cuisine VARCHAR(50)
);

-- Creating restaurants table
CREATE TABLE Restaurants (
    Restaurant_ID VARCHAR(50),
    Name VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    Zip_Code VARCHAR(50),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    Alcohol_Service VARCHAR(50),
    Smoking_Allowed VARCHAR(50),
    Price VARCHAR(50),
    Franchise VARCHAR(50),
    Area VARCHAR(50),
    Parking VARCHAR(100)
);

-- Creating restaurant_cuisines table
CREATE TABLE restaurant_cuisines (
    Restaurant_ID VARCHAR(50),
    Cuisine VARCHAR(50)
);


-- 1. Total restaurants in each state

select count(restaurant_ID) no_restaurants, State from  restaurants
group by state
order by no_restaurants desc;

-- 2. Total restaurants in each city

select count(restaurant_ID) no_restaurants, City from  restaurants
group by City
order by no_restaurants desc;

-- 3. Restaurants COUNT by alcohol service

select  count(*), Alcohol_Service from  restaurants
group by Alcohol_Service;

-- 4. Restaurants Count by Smoking Allowed
select count(restaurant_ID) as no_restaurants , smoking_allowed from restaurants
group by Smoking_allowed
order by no_restaurants DESC;

-- 5. Alcohol & Smoking analysis
select smoking_allowed, Alcohol_Service,  count(restaurant_ID) as no_restaurants  from restaurants
group by Smoking_allowed, Alcohol_Service
order by no_restaurants DESC;

-- 6. Restaurants COUNT by Price
Select Price, count(restaurant_ID) as no_restaurants from Restaurants
Group BY Price
ORDER BY no_restaurants;

-- 7. Restaurants COUNT by packing

Select Parking, count(restaurant_ID) as no_restaurants from Restaurants
Group BY Parking
ORDER BY no_restaurants DESC;

-- 8. Count of Restaurants by cuisines
Select Cuisine, count(restaurant_ID) as no_restaurants from Restaurant_cuisines
Group BY Cuisine
ORDER BY no_restaurants DESC;

-- 9. Preferred cuisines of each customer
Select Preferred_Cuisine, count(Consumer_ID) as no_restaurants from customer_preference
Group BY Preferred_Cuisine
ORDER BY no_restaurants;
-- 10. Restaurant Price-Analysis for each cuisine
select  count(r.Restaurant_ID) from restaurants r 
join restaurant_cuisines c using( Restaurant_ID)
#group by c.Cusine
;
select * from customer_preference;
select * from restaurants;


-- 11. Finding out COUNT of each cuisine in each state