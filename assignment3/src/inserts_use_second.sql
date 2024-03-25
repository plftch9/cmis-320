-- non dependent table inserts
-- actor inserts
INSERT INTO Actors(first_name, last_name, country) VALUES('tom', 'hardy', 'united kingdom');
INSERT INTO Actors(first_name, last_name, country) VALUES('leonardo', 'dicaprio', 'united states');
INSERT INTO Actors(first_name, last_name, country) VALUES('heath', 'ledger', 'australia');
INSERT INTO Actors(first_name, last_name, country) VALUES('russel', 'crowe', 'new zealand');
INSERT INTO Actors(first_name, last_name, country) VALUES('joaquin', 'phoenix', 'united states');
--

-- award inserts
INSERT INTO Awards(name, issuer) VALUES('best actor', 'academy');
INSERT INTO Awards(name, issuer) VALUES('best director', 'academy');
INSERT INTO Awards(name, issuer) VALUES('best picture', 'academy');
INSERT INTO Awards(name, issuer) VALUES('best costume design', 'academy');
INSERT INTO Awards(name, issuer) VALUES('best sound', 'academy');
--

-- customer inserts
INSERT INTO Customers(first_name, last_name, street_address, city, zip_code, birth_date, phone_number)
VALUES('roger', 'rabit', '123 toon st.', 'los angeles', '99999', TO_DATE('1988-03-11', 'YYYY-MM-DD'), '310-765-1234');
INSERT INTO Customers(first_name, last_name, street_address, city, zip_code, birth_date, phone_number)
VALUES('master', 'roshi', '456 kame house', 'east city', '12345', TO_DATE('1986-05-09', 'YYYY-MM-DD'), '791-432-0723');
INSERT INTO Customers(first_name, last_name, street_address, city, zip_code, birth_date, phone_number)
VALUES('max', 'rockatansky', '789 road warrior st.', 'sydney', '67890', TO_DATE('1976-05-10', 'YYYY-MM-DD'), '234-543-0987');
INSERT INTO Customers(first_name, last_name, street_address, city, zip_code, birth_date, phone_number)
VALUES('spongebob', 'squarepants', '124 conch st.', 'bikini bottom', '08474', TO_DATE('1986-07-14', 'YYYY-MM-DD'), '235-731-0923');
INSERT INTO Customers(first_name, last_name, street_address, city, zip_code, birth_date, phone_number)
VALUES('van', 'wilder', '732 coolidge dr.', 'coolidge', '21043', TO_DATE('2002-04-05', 'YYYY-MM-DD'), '713-210-9842');
--

-- director inserts
INSERT INTO Directors(first_name, last_name, country) VALUES('george', 'martin', 'australia');
INSERT INTO Directors(first_name, last_name, country) VALUES('alejandro', 'inarritu', 'mexico');
INSERT INTO Directors(first_name, last_name, country) VALUES('ridley', 'scott', 'united kingdom');
INSERT INTO Directors(first_name, last_name, country) VALUES('brian', 'helgeland', 'united states');
INSERT INTO Directors(first_name, last_name, country) VALUES('todd', 'philips', 'united states');
--

-- distributor inserts
INSERT INTO Distributors(name, num_sales, catalog, phone_number) VALUES('thriller tent', 10, 'mad max series', '703-941-0375');
INSERT INTO Distributors(name, num_sales, catalog, phone_number) VALUES('russel repository', 8, 'russel crowe movies', '832-831-0932');
INSERT INTO Distributors(name, num_sales, catalog, phone_number) VALUES('adventure collection', 6, 'adventure movies', '841-845-9273');
INSERT INTO Distributors(name, num_sales, catalog, phone_number) VALUES('comedy collective', 12, 'comedy movies', '542-652-5713');
INSERT INTO Distributors(name, num_sales, catalog, phone_number) VALUES('psych sells', 5, 'psychological thrillers', '542-651-0853');
--

-- dependent table inserts (must be done in specific order to satisfy foreign key constraints)
-- sale inserts
INSERT INTO Sales(distributor_id, purchased_products, sale_cost, sale_date) 
VALUES((SELECT id FROM Distributors WHERE name = 'thriller tent'), 'mad max: fury road', 20.00, TO_DATE('2018-10-21', 'YYYY-MM-DD'));

INSERT INTO Sales(distributor_id, purchased_products, sale_cost, sale_date)
VALUES((SELECT id FROM Distributors WHERE name = 'russel repository'), 'gladiator', 25.00, TO_DATE('2002-04-12', 'YYYY-MM-DD'));

INSERT INTO Sales(distributor_id, purchased_products, sale_cost, sale_date)                 
VALUES((SELECT id FROM Distributors WHERE name = 'adventure collection'), 'the revenant', 10.00, TO_DATE('2015-12-21', 'YYYY-MM-DD'));

INSERT INTO Sales(distributor_id, purchased_products, sale_cost, sale_date) 
VALUES((SELECT id FROM Distributors WHERE name = 'psych sells'), 'joker', 16.00, TO_DATE('2019-09-18', 'YYYY-MM-DD'));

INSERT INTO Sales(distributor_id, purchased_products, sale_cost, sale_date)
VALUES((SELECT id FROM Distributors WHERE name = 'comedy collective'), 'a knights tale', 12.00, TO_DATE('2001-09-25', 'YYYY-MM-DD'));
--

-- movie inserts
INSERT INTO Movies(sale_id, director_id, is_dvd, is_vhs, genre, catalog_id, name, rating, runtime, year_released)
VALUES((SELECT id FROM Sales WHERE purchased_products = 'mad max: fury road'), (SELECT id FROM Directors WHERE last_name = 'martin'), 'Y', 'N', 'thriller', '011231', 'mad max: fury road', 8.8, 120, 2015);
INSERT INTO Movies(sale_id, director_id, is_dvd, is_vhs, genre, catalog_id, name, rating, runtime, year_released)
VALUES((SELECT id FROM Sales WHERE purchased_products = 'gladiator'), (SELECT id FROM Directors WHERE last_name = 'philips'), 'N', 'Y', 'action', '110011010', 'gladiator', 9.2, 155, 2000);
INSERT INTO Movies(sale_id, director_id, is_dvd, is_vhs, genre, catalog_id, name, rating, runtime, year_released)
VALUES((SELECT id FROM Sales WHERE purchased_products = 'the revenant'), (SELECT id FROM Directors WHERE last_name = 'inarritu'), 'Y', 'N', 'adventure', '6326424', 'the revenant', 9.0, 156, 2015);
INSERT INTO Movies(sale_id, director_id, is_dvd, is_vhs, genre, catalog_id, name, rating, runtime, year_released)
VALUES((SELECT id FROM Sales WHERE purchased_products = 'joker'), (SELECT id FROM Directors WHERE last_name = 'scott'), 'Y', 'N', 'psychological', '9756535', 'joker', 8.2, 122, 2019);
INSERT INTO Movies(sale_id, director_id, is_dvd, is_vhs, genre, catalog_id, name, rating, runtime, year_released)
VALUES((SELECT id FROM Sales WHERE purchased_products = 'a knights tale'), (SELECT id FROM Directors WHERE last_name = 'helgeland'), 'N', 'Y', 'comedy', '813598102', 'a knights tale', 7.9, 132, 2001);
--

-- rental inserts
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax) 
VALUES((SELECT id FROM Customers WHERE phone_number = '310-765-1234'), (SELECT id FROM Movies WHERE name = 'a knights tale'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-22', 'YYYY-MM-DD'), 5.50, (5.50 * 0.06));
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax) 
VALUES((SELECT id FROM Customers WHERE phone_number = '791-432-0723'), (SELECT id FROM Movies WHERE name = 'gladiator'), TO_DATE('2022-12-11', 'YYYY-MM-DD'), TO_DATE('2022-12-18', 'YYYY-MM-DD'), 7.00, (7.00 * 0.06));
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax) 
VALUES((SELECT id FROM Customers WHERE phone_number = '234-543-0987'), (SELECT id FROM Movies WHERE name = 'mad max: fury road'), TO_DATE('2023-02-05', 'YYYY-MM-DD'), TO_DATE('2023-02-12', 'YYYY-MM-DD'), 5.00, (5.00 * 0.06));
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax)
VALUES((SELECT id FROM Customers WHERE phone_number = '791-432-0723'), (SELECT id FROM Movies WHERE name = 'mad max: fury road'), TO_DATE('2023-02-12', 'YYYY-MM-DD'), TO_DATE('2023-02-19', 'YYYY-MM-DD'), 5.00, (5.00 * 0.06));
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax)
VALUES((SELECT id FROM Customers WHERE phone_number = '235-731-0923'), (SELECT id FROM Movies WHERE name = 'joker'), TO_DATE('2022-11-10', 'YYYY-MM-DD'), TO_DATE('2022-11-17', 'YYYY-MM-DD'), 6.50, (6.50 * 0.06));
INSERT INTO Rentals(customer_id, movie_id, rental_date, due_date, rental_price, tax)
VALUES((SELECT id FROM Customers WHERE phone_number = '713-210-9842'), (SELECT id FROM Movies WHERE name = 'the revenant'), TO_DATE('2021-05-13', 'YYYY-MM-DD'),TO_DATE('2021-05-20', 'YYYY-MM-DD'), 6.00, (6.00 * 0.06));
--

-- return inserts
INSERT INTO Returns(rental_id, return_date, is_damaged, is_late, added_fees)
VALUES((SELECT id FROM Rentals WHERE customer_id = 1 AND movie_id= 5), TO_DATE('2023-01-24', 'YYYY-MM-DD'), 'Y', 'Y', 8.50);
INSERT INTO Returns(rental_id, return_date, is_damaged, is_late, added_fees)
VALUES((SELECT id FROM Rentals WHERE customer_id = 2 AND movie_id= 2), TO_DATE('2022-12-18', 'YYYY-MM-DD'), 'N', 'N', 0);
INSERT INTO Returns(rental_id, return_date, is_damaged, is_late, added_fees)
VALUES((SELECT id FROM Rentals WHERE customer_id = 3 AND movie_id= 1), TO_DATE('2023-02-12', 'YYYY-MM-DD'), 'N', 'N', 0);
INSERT INTO Returns(rental_id, return_date, is_damaged, is_late, added_fees)
VALUES((SELECT id FROM Rentals WHERE customer_id = 4 AND movie_id= 4), TO_DATE('2022-11-22', 'YYYY-MM-DD'), 'N', 'Y', 2.50);
INSERT INTO Returns(rental_id, return_date, is_damaged, is_late, added_fees)
VALUES((SELECT id FROM Rentals WHERE customer_id = 5 AND movie_id= 3), TO_DATE('2021-05-20', 'YYYY-MM-DD'), 'Y', 'N', 6.00);
--

-- bridge table inserts
-- actor_award inserts
INSERT INTO actor_awards(award_id, actor_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best actor'),(SELECT id FROM Actors WHERE  last_name = 'crowe'), 2000);
INSERT INTO actor_awards(award_id, actor_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best actor'),(SELECT id FROM Actors WHERE  last_name = 'hardy'), 2010);
INSERT INTO actor_awards(award_id, actor_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best actor'),(SELECT id FROM Actors WHERE  last_name = 'phoenix'), 2019);
INSERT INTO actor_awards(award_id, actor_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best actor'),(SELECT id FROM Actors WHERE  last_name = 'dicaprio'), 2015);
INSERT INTO actor_awards(award_id, actor_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best actor'),(SELECT id FROM Actors WHERE  last_name = 'ledger'), 2012);
--

-- director_award inserts
INSERT INTO director_awards(award_id, director_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best director'),(SELECT id FROM Directors WHERE last_name = 'martin'), 2015);
INSERT INTO director_awards(award_id, director_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best director'),(SELECT id FROM Directors WHERE last_name = 'inarritu'), 2016);
INSERT INTO director_awards(award_id, director_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best director'),(SELECT id FROM Directors WHERE last_name = 'scott'), 2019);
INSERT INTO director_awards(award_id, director_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name = 'best director'),(SELECT id FROM Directors WHERE last_name = 'helgeland'), 2002);
INSERT INTO director_awards(award_id, director_id, year_awarded) 
VALUES((SELECT id FROM Awards WHERE name = 'best director'),(SELECT id FROM Directors WHERE last_name = 'philips'), 2000);
--

--movie_award inserts
INSERT INTO movie_awards(award_id, movie_id, year_awarded) 
VALUES((SELECT id FROM Awards WHERE name ='best costume design'),(SELECT id FROM Movies WHERE name ='mad max: fury road'), 2015);
INSERT INTO movie_awards(award_id, movie_id, year_awarded) 
VALUES((SELECT id FROM Awards WHERE name ='best picture'),(SELECT id FROM Movies WHERE name ='gladiator') , 2000);
INSERT INTO movie_awards(award_id, movie_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name ='best sound'),(SELECT id FROM Movies WHERE name ='joker'), 2019);
INSERT INTO movie_awards(award_id, movie_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name ='best picture'),(SELECT id FROM Movies WHERE name ='mad max: fury road'), 2015);
INSERT INTO movie_awards(award_id, movie_id, year_awarded)
VALUES((SELECT id FROM Awards WHERE name ='best sound'),(SELECT id FROM Movies WHERE name ='the revenant'), 2015);
--

-- movie actor inserts
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='mad max: fury road'),(SELECT id FROM Actors WHERE last_name = 'hardy'), 'mad max');
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='the revenant'),(SELECT id FROM Actors WHERE last_name = 'hardy'), 'john fitzgerald');
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='the revenant'),(SELECT id FROM Actors WHERE last_name = 'dicaprio'), 'hugh glass');
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='gladiator'),(SELECT id FROM Actors WHERE last_name = 'crowe'), 'maximus');
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='joker'),(SELECT id FROM Actors WHERE last_name = 'phoenix'), 'arthur fleck');
INSERT INTO Movie_Actors(movie_id, actor_id, casting)
VALUES((SELECT id FROM Movies WHERE name ='a knights tale'),(SELECT id FROM Actors WHERE last_name = 'ledger'), 'william thatcher');
