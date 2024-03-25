-- query 1: display list of customers name, address (street ans zip only), and coount number, order by account number
SELECT TRIM(id) AS account_number, TRIM(first_name) AS first_name, TRIM(last_name) AS last_name, TRIM(street_address) AS street_address, TRIM(zip_code) AS zip_code FROM Customers
ORDER BY id;

-- query 2: display all videos rented in last 30 days, listed in chronological order
SELECT * FROM Rentals WHERE rental_date > SYSDATE - 30
ORDER BY rental_date;

-- query 3: display list of distributor info ordered by alphabetical name
SELECT * FROM Distributors
ORDER BY name;

-- query 4: change last name of a customer
SELECT * FROM Customers
WHERE id = 1;

SAVEPOINT beforeUpdate;

UPDATE Customers
SET last_name = 'column data changed'
WHERE id = 1;

SELECT * FROM Customers 
WHERE id = 1;

ROLLBACK TO SAVEPOINT beforeUpdate;


-- query 5: delete customer from database
SELECT * FROM Customers;

SAVEPOINT beforeDelete;

DELETE FROM Customers WHERE id = 1;

SELECT * FROM Customers;

ROLLBACK TO SAVEPOINT beforeDelete;
