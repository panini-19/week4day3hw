-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT customer.first_name, customer.last_name, address.district
FROM customer
INNER JOIN address ON customer.address_id=address.address_id
WHERE district = 'Texas';
-- Reasoning: Using the address_id to join the customer and address table, we can then access the 
-- district value and search for customers who live in Texas. The results are: Jennifer Davis, Kim Cruz, 
-- Richard Mccrary, Bryan Hardison and Ian Still.

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT payment.amount, customer.first_name, customer.last_name
FROM payment
INNER JOIN customer ON payment.customer_id=customer.customer_id
WHERE amount > 6.99;
-- Reasoning: Using the customer_id to join the customer and payment tables allows us to access the amount
-- value and net the results. Duplicate names do not matter her as we are looking for any amount above
-- $6.99 and a single customer can make multiple different payments.

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) >175
);
-- Reasoning: Using the main query to access the customer table, then a subquery to access the payment table
-- allows us to access the amount value in the payment table. We then have to use the SUM clause to add 
-- together all of the amounts so that they are over 175.

-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT country.country, city.country_id
FROM country
INNER JOIN city ON country.country_id=city.country_id
WHERE country = 'Nepal';

SELECT city.country_id, address.city_id
FROM city
INNER JOIN address ON city.city_id=address.city_id
WHERE country_id = 66;

SELECT address.city_id, customer.address_id
FROM address
INNER JOIN customer ON address.address_id=customer.address_id
WHERE city_id = 81;

SELECT customer.first_name, customer.last_name, customer.address_id
FROM customer
WHERE address_id = 326;
-- Reasoning: I could not figure out how to do this using joins or subqueries so I decided to go the manual 
-- route instead. I joined two tables at a time, the first join netting me the country ID of Nepal, the 
-- second netting me the city id, the third netting me the address id and the final one netting me the 
-- name of the customer that matches said address id.

-- 5. Which staff member had the most
-- transactions?
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(rental.rental_id)
FROM staff
INNER JOIN rental ON staff.staff_id=rental.staff_id
GROUP BY staff.staff_id;
-- Reasoning: Joining together the staff_id value of the staff and rental tables allows me to count the 
-- number of rental_ids that each staff had. This gets me the result of Mike with 8040 rentals.

-- 6. How many movies of each rating are
-- there?
SELECT COUNT(title), rating
FROM film
GROUP BY rating;
-- Reasoning: By counting the titles and grouping by rating, we find that the count for each rating is 
-- as follows: 224 for PG-13, 209 for NC-17, 196 for R, 194 for PG and 178 for G.

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT customer_id, first_name, last_name
FROM customer 
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
);
-- Reasoning: The main query access the information of the customer while the subquery accesses the 
-- amount value in the payment table. The I use WHERE to locate all values above $6.99.

-- 8. How many free rentals did our stores give away

SELECT payment_id, COUNT(amount), amount
FROM payment
GROUP BY payment_id
ORDER BY COUNT(amount) < 0;
-- Reasoning: I assumed that all values which are negative means free rentals. So, I counted the amount
-- value from the payment table where the values were less than 0. This nets me 14596 free rentals 
-- given away.