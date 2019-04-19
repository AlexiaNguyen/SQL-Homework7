Select first_name, last_name From actor;

Select CONCAT(first_name, ' ', last_name) As 'Actor Name' From actor;

Select actor_id, first_name, last_name From actor Where first_name = "JOE";

Select * From actor Where last_name like '%GEN%';

Select * From actor Where last_name like '%LI%'
Order By last_name ASC, first_name ASC;

Select country_id, country From country
Where country In ('Afghanistan', 'Bangladesh', 'China');

Alter Table actor
Add Column descript Mediumblob;

Alter Table actor
Drop Column descript;

Select last_name, Count(*) As 'count'
From actor
Group By last_name;

Select last_name, Count(*) As 'count'
From actor
Group By last_name
HAVING COUNT(*) >= 2;

Select * From actor
Where first_name = "GROUCHO" And last_name = "WILLIAMS";

Update actor
Set first_name = "HARPO"
Where first_name = "GROUCHO" And last_name = "WILLIAMS";

Select * From actor
Where first_name = "HARPO" And last_name = "WILLIAMS";

Update actor
Set first_name = "GROUCHO"
Where first_name = "HARPO" And last_name = "WILLIAMS";

Select * From actor
Where first_name = "HARPO" And last_name = "WILLIAMS";

SHOW CREATE TABLE address;

Select staff.first_name, staff.last_name, staff.address_id, address.address
From staff
Inner Join address On 
staff.address_id = address.address_id;

Select * From payment;

Select staff.first_name, staff.last_name, staff.staff_id, sum(payment.amount)
From staff
Inner Join payment On
staff.staff_id = payment.staff_id
Where payment.payment_date Like "%2005-08%"
Group By staff.staff_id;

Select film.title, Count(film_actor.actor_id)
From film
Inner Join film_actor On
film.film_id = film_actor.film_id
Group By film.title;

Select film.title, Count(inventory.inventory_id)
From film
Inner Join inventory On
film.film_id = inventory.film_id And
film.title = "Hunchback Impossible"
Group By film.title;

Select * From customer;
Select * From payment;

Select customer.first_name, customer.last_name, Sum(payment.amount)
From customer
Join payment On customer.customer_id = payment.customer_id
Group By customer.first_name, customer.last_name
Order By customer.last_name ASC;

Select title
From 
	(Select film.title, film.language_id, language.name
    From film
    Inner Join language On film.language_id = language.language_id
    Where language.name = "English") as S
Where title Like "K%" Or title Like "Q%";

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

Select * From address;
Select * From city;
Select * From country;
Select * From customer;

Select customer.first_name, customer.last_name, customer.email
From customer
Inner Join address On customer.address_id = address.address_id
Inner Join city On address.city_id = city.city_id
Inner Join country On city.country_id = country.country_id
Where country.country = "Canada";

Select * From film;
Select * From film_category;
Select * From category;

Select film.title
From film
Inner Join film_category On film.film_id = film_category.film_id
Inner Join category On film_category.category_id = category.category_id
Where category.name = "Family";

Select * From rental;
Select * From inventory;
Select * From film;

Select film.title, Count(inventory.inventory_id) As "Count"
From film
Inner Join inventory On film.film_id = inventory.film_id
Inner Join rental On inventory.inventory_id = rental.inventory_id
Group By film.title
Order By Count DESC;

Select * From store;
Select * From customer;
Select * From payment;

Select store.store_id, Sum(payment.amount) As "Amount"
From store
Inner Join customer On store.store_id = customer.store_id
Inner Join payment On customer.customer_id = payment.customer_id
Group By store.store_id;

Select store.store_id, city.city, country.country
From store
Inner Join address On store.address_id = address.address_id
Inner Join city On address.city_id = city.city_id
Inner Join country On city.country_id = country.country_id;

#category, film_category, inventory, payment, and rental

Select category.name, Sum(payment.amount) As "Amount"
From category
Inner Join film_category On category.category_id = film_category.category_id
Inner Join inventory On film_category.film_id = inventory.film_id
Inner Join rental On inventory.inventory_id = rental.inventory_id
Inner Join payment On rental.rental_id = payment.rental_id
Group By category.name
Order By Amount DESC;

Create View top_five_genres As
Select category.name, Sum(payment.amount) As "Amount"
From category
Inner Join film_category On category.category_id = film_category.category_id
Inner Join inventory On film_category.film_id = inventory.film_id
Inner Join rental On inventory.inventory_id = rental.inventory_id
Inner Join payment On rental.rental_id = payment.rental_id
Group By category.name
Order By Amount DESC LIMIT 5;

Select * From top_five_genres;

Drop View top_five_genres;

