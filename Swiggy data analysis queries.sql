USE newschema1;
SELECT * FROM swiggy;

#q1: no. of restaurants with rating greater than 4.5
SELECT COUNT(DISTINCT restaurant_name)
AS Top_Rated_Restaurants
FROM swiggy
WHERE rating>4.5;

#q2: list of restaurants with rating >4.5
SELECT DISTINCT restaurant_name
AS Top_Rated_Restaurant
FROM swiggy
WHERE rating>4.5;

#q3 Top city with more no. of restaurants
SELECT city, COUNT(DISTINCT restaurant_name)
AS restaurant_count
FROM swiggy
GROUP BY city
ORDER BY restaurant_count DESC

#q4 Limit top city by 1
SELECT city, COUNT(DISTINCT restaurant_name)
AS restaurant_count
FROM swiggy
GROUP BY city
ORDER BY restaurant_count DESC
LIMIT 1;

#q5 List of Restaurants with name having pizza

SELECT DISTINCT restaurant_name
AS pizzaname_restaurants
FROM swiggy
WHERE restaurant_name LIKE '%pizza%';

#q6 Count of restaurants with pizza in name
SELECT COUNT(DISTINCT restaurant_name)
AS pizzaname_restaurants
FROM swiggy
WHERE restaurant_name LIKE '%pizza%';

#q7 List count of most common cuisine among restaurants
SELECT cuisine,COUNT(*) AS cuisine_count
FROM swiggy
GROUP BY cuisine
ORDER BY cuisine_count DESC;

#q8 count of most common cuisine
SELECT cuisine,COUNT(*) AS cuisine_count
FROM swiggy
GROUP BY cuisine
ORDER BY cuisine_count DESC
LIMIT 1;

#q9  Average rating of restaurants in each city
SELECT city, AVG(rating) AS restaurant_rating
FROM swiggy 
GROUP BY city;

#q10 veg restaurant avg rating city wise
SELECT city, veg_or_nonveg, AVG(rating) AS restaurant_rating
FROM swiggy
WHERE veg_or_nonveg='VEG'
GROUP BY city;

#q11 list of highest price cuisine in recommended category of each restaurant
SELECT DISTINCT restaurant_name, menu_category, MAX(price) AS highest_price
FROM swiggy
WHERE menu_category='recommended'
GROUP BY restaurant_name, menu_category;

# q12 high priced recommended item name restaurant wise
SELECT DISTINCT restaurant_name, menu_category, item, MAX(price) AS highest_price
FROM swiggy
WHERE menu_category='recommended'
GROUP BY restaurant_name, menu_category, item;

#q13 list of all recommended items ordered in ascending order based on item price
SELECT DISTINCT restaurant_name, menu_category, item, MAX(price) AS highest_price
FROM swiggy
WHERE menu_category='recommended'
GROUP BY restaurant_name, menu_category, item
ORDER BY item;

#q14 Top 5 most expensive restaurants that offer other than Indian cuisine
SELECT DISTINCT restaurant_name, cost_per_person
FROM swiggy
WHERE cuisine<>'Indian'
ORDER BY cost_per_person DESC
LIMIT 5;

#q15 restaurants that have avg cost greater than total avg cost of all restaurants 
SELECT DISTINCT restaurant_name, cost_per_person
FROM swiggy 
WHERE cost_per_person>(SELECT AVG(cost_per_person) FROM swiggy);

#q16 restaurants with same name but in different cities
SELECT DISTINCT t1.restaurant_name, t1.city AS city1, t2.city AS city2
FROM swiggy t1 JOIN swiggy t2
ON t1.restaurant_name=t2.restaurant_name AND t1.city<>t2.city;

#q17 Restaurant in first place that offers most no.of items in main course category
SELECT DISTINCT restaurant_name, menu_category, COUNT(item) AS no_of_items
FROM swiggy
WHERE menu_category='Main Course'
GROUP BY restaurant_name, menu_category
ORDER BY no_of_items DESC
LIMIT 1;

#q18 Restaurant in second place that offers most no.of items in main course category
SELECT DISTINCT restaurant_name, menu_category, COUNT(item) AS no_of_items
FROM swiggy
WHERE menu_category='Main Course'
GROUP BY restaurant_name, menu_category
ORDER BY no_of_items DESC
LIMIT 1 OFFSET 1;

#q19 List of Restaurant that offers most no.of items in main course category in descednind order
SELECT DISTINCT restaurant_name, menu_category, COUNT(item) AS no_of_items
FROM swiggy
WHERE menu_category='Main Course'
GROUP BY restaurant_name, menu_category
ORDER BY no_of_items DESC;

#q20 list of restaurants providing veg foods 
SELECT DISTINCT restaurant_name, veg_or_nonveg
FROM swiggy 
WHERE veg_or_nonveg='veg';

#q20 list of restaurants providing 100% veg foods alone
SELECT DISTINCT restaurant_name,
(COUNT(CASE WHEN veg_or_nonveg='veg' THEN 1 END)*100/COUNT(*))
AS vegetarian_percentage
FROM swiggy 
GROUP BY restaurant_name
HAVING vegetarian_percentage=100.00
ORDER BY restaurant_name;

#q21 Restaurant providing lowest average price for all items
SELECT DISTINCT restaurant_name, AVG(price) AS average_price
FROM swiggy
GROUP BY restaurant_name
ORDER BY average_price
LIMIT 1;

#q22 Top 5 restaurants giving highest number of categories
SELECT DISTINCT restaurant_name, COUNT(DISTINCT menu_category) AS no_of_category
FROM swiggy
GROUP BY restaurant_name
ORDER BY no_of_category DESC
LIMIT 5;

#q22 lIST OF restaurants and number of categories in descending order
SELECT DISTINCT restaurant_name, COUNT(DISTINCT menu_category) AS no_of_category
FROM swiggy
GROUP BY restaurant_name
ORDER BY no_of_category DESC;

#q25 Top restaurant providing 100% nonveg foods alone
SELECT DISTINCT restaurant_name,
(COUNT(CASE WHEN veg_or_nonveg='non-veg' THEN 1 END)*100/COUNT(*))
AS nonvegetarian_percentage
FROM swiggy 
GROUP BY restaurant_name
ORDER BY nonvegetarian_percentage DESC 
LIMIT 1;