USE sakila;

SELECT actor_id, first_name, last_name FROM actor;

SELECT CONCAT(first_name, ' ', last_name) as 'Actor Name'
FROM actor;

SELECT * 
FROM actor
WHERE first_name = "JOE";

SELECT * 
FROM actor
WHERE last_name LIKE "%GEN%";

SELECT last_name, first_name
FROM actor
WHERE last_name LIKE "%LI%";

SELECT country_id, country 
FROM country
WHERE country
IN ("Afghanistan", "Bangladesh", "China");

ALTER TABLE actor
ADD description BLOB;

ALTER TABLE actor
DROP description;

SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

SELECT * 
FROM actor
WHERE first_name = "GROUCHO";

UPDATE actor
SET first_name = "HARPO"
WHERE (first_name = "GROUCHO") AND (last_name = "WILLIAMS");

SELECT * 
FROM actor
WHERE first_name = "HARPO";

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

SELECT * 
FROM actor
WHERE first_name = "GROUCHO";

SHOW CREATE TABLE staff;

SELECT first_name, last_name, address
FROM staff as s
JOIN address as a
ON s.address_id = a.address_id;

SELECT * FROM payment;

SELECT first_name, last_name, SUM(amount)
FROM staff as s
JOIN payment as p
ON s.staff_id = p.staff_id
WHERE p.payment_date BETWEEN "2005-08-01" AND "2005-08-31"
GROUP BY s.staff_id;

SELECT * FROM film;

SELECT title, COUNT(actor_id)
FROM film as f
INNER JOIN film_actor as a
ON f.film_id = a.film_id
GROUP BY title;

SELECT * FROM inventory;

SELECT title, COUNT(i.film_id)
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY f.title;

SELECT * FROM customer;

SELECT c.first_name, c.last_name, SUM(p.amount) as "Total Amount Paid"
FROM customer as c
JOIN payment as p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;

SELECT * FROM film;

SELECT title
FROM film
WHERE language_id IN
	(
	SELECT language_id
	FROM language
	WHERE name = "English"
	) AND (title LIKE "K%") OR (title LIKE "Q%");

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id 
	FROM film_actor
	WHERE film_id IN
		(
		SELECT film_id
		FROM film
		WHERE title = "Alone Trip"
		)
	);
    
SELECT first_name, last_name, email
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city y
ON a.city_id = y.city_id
JOIN country t
ON y.country_id = t.country_id
WHERE t.country = "Canada";

SELECT f.title, COUNT(r.rental_id) AS "rental frequency"
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

SELECT t.store_id, SUM(p.amount) AS "total earnings"
FROM payment p
JOIN staff s
ON p.staff_id = s.staff_id
JOIN store t
ON s.store_id = t.store_id
GROUP BY t.store_id;

SELECT s.store_id, c.city, y.country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country y
ON c.country_id = y.country_id
ORDER BY s.store_id;

SELECT g.name AS "genre", SUM(p.amount) AS "gross revenue"
FROM category g
JOIN film_category f
ON g.category_id = f.category_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY g.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;


CREATE VIEW top_five_genres AS
SELECT g.name AS "genre", SUM(p.amount) AS "gross revenue"
FROM category g
JOIN film_category f
ON g.category_id = f.category_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY g.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;