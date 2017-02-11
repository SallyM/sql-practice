/* Exercises taken from
http://www.programmerinterview.com/index.php/database-sql/practice-interview-question-1/
*/

CREATE TABLE salesperson (
  id INT NOT NULL,
  name VARCHAR(50),
  age INT,
  salary INT,
  PRIMARY KEY (id)
);

INSERT INTO salesperson (id, name, age, salary)
VALUES (1, 'Abe', 61, 140000);
INSERT INTO salesperson (id, name, age, salary)
VALUES (2, 'Bob', 34, 44000);
INSERT INTO salesperson (id, name, age, salary)
VALUES (5, 'Chris', 34, 40000);
INSERT INTO salesperson (id, name, age, salary)
VALUES (7, 'Dan', 41, 52000);
INSERT INTO salesperson (id, name, age, salary)
VALUES (8, 'Ken', 57, 115000);
INSERT INTO salesperson (id, name, age, salary)
VALUES (11, 'Joe', 38, 38000);


CREATE TABLE customer (
  id INT NOT NULL,
  name VARCHAR(50),
  city VARCHAR(50),
  industry_type VARCHAR(50),
  PRIMARY KEY (id)
);

INSERT INTO customer (id, name, city, industry_type)
VALUES (4, 'Samsonic', 'pleasant', 'J');
INSERT INTO customer (id, name, city, industry_type)
VALUES (6, 'Panasung', 'oaktown', 'J');
INSERT INTO customer (id, name, city, industry_type)
VALUES (7, 'Samony', 'jackson', 'B');
INSERT INTO customer (id, name, city, industry_type)
VALUES (9, 'Orange', 'jackson', 'B');


CREATE TABLE orders (
  num INT NOT NULL,
  order_date DATE,
  cust_id INT NOT NULL,
  salesperson_id INT NOT NULL,
  amount FLOAT(100, 4),
  PRIMARY KEY (num)
);

INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (10, '1998-08-02', 4, 2, 540);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (20, '1999-01-30', 4, 8, 1800);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (30, '1995-07-14', 9, 1, 460);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (40, '1998-01-29', 7, 2, 2400);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (50, '1998-02-03', 6, 7, 600);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (60, '1998-03-02', 6, 7, 720);
INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (70, '1998-05-06', 9, 7, 150);


--a. The names of all salespeople that have an order with Samsonic.
SELECT DISTINCT(s.name)
FROM orders AS o
LEFT JOIN salesperson AS s
ON o.salesperson_id = s.id
LEFT JOIN customer AS c
ON c.id = o.cust_id
WHERE c.name = 'Samsonic';

-- shorter solution from the site:
select Salesperson.Name from Salesperson, Orders where
Salesperson.ID = Orders.salesperson_id and cust_id = '4';

-- using subqueries, also from the site:
select Salesperson.Name from Salesperson where
Salesperson.ID = '{select Orders.salesperson_id from Orders,
                   Customer where Orders.cust_id = Customer.id
                   and Customer.name = 'Samsonic'}';


--b. The names of all salespeople that do not have any order with Samsonic.
SELECT DISTINCT(s.name)
FROM orders AS o
LEFT JOIN salesperson AS s
ON o.salesperson_id = s.id
LEFT JOIN customer AS c
ON c.id = o.cust_id
WHERE s.name NOT IN (
    SELECT DISTINCT(s.name)
    FROM orders AS o
    LEFT JOIN salesperson AS s
    ON o.salesperson_id = s.id
    LEFT JOIN customer AS c
    ON c.id = o.cust_id
    WHERE c.name = 'Samsonic'
  );

-- site solution:
select Salesperson.Name from Salesperson
where Salesperson.ID NOT IN(
select Orders.salesperson_id from Orders, Customer
where Orders.cust_id = Customer.ID
and Customer.Name = 'Samsonic');

-- c. The names of salespeople that have 2 or more orders.
SELECT DISTINCT(s.name),
       COUNT(o.num) as cnt
FROM orders AS o
LEFT JOIN salesperson AS s
ON o.salesperson_id = s.id
GROUP BY s.name
HAVING cnt >= 2;

/*d. Write a SQL statement to insert rows into a table called
highAchiever(Name, Age), where a salesperson must have a salary of
100,000 or greater to be included in the table.*/
CREATE TABLE highAchiever (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  age INT NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO highAchiever(name, age)
  (SELECT name,
         age
  FROM salesperson
  WHERE salary >= 100000);


  /*User
user_id
name
phone_num

UserHistory
user_id
date
action
*/

CREATE TABLE user (
  user_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  phone_num VARCHAR(11),
  PRIMARY KEY(user_id)
);

INSERT INTO user (name, phone_num) VALUES ('Abe', '1234567890');
INSERT INTO user (name, phone_num) VALUES ('Bob', '9876543210');
INSERT INTO user (name, phone_num) VALUES ('Chris', '6789012345');
INSERT INTO user (name, phone_num) VALUES ('Danny', '5678901234');
INSERT INTO user (name, phone_num) VALUES ('Emily', '6543298710');
INSERT INTO user (name, phone_num) VALUES ('Fran', '6789012345');
INSERT INTO user (name, phone_num) VALUES ('George', '9012567834');
INSERT INTO user (name, phone_num) VALUES ('Harry', '5432698710');
INSERT INTO user (name, phone_num) VALUES ('Ian', '7890162345');
INSERT INTO user (name, phone_num) VALUES ('Jane', '8901672345');
INSERT INTO user (name, phone_num) VALUES ('Kevin', '2348901675');
INSERT INTO user (name, phone_num) VALUES ('Lilly', '3489021675');
INSERT INTO user (name, phone_num) VALUES ('Mary', '4890216375');
INSERT INTO user (name, phone_num) VALUES ('Nick', '1637489025');
INSERT INTO user (name, phone_num) VALUES ('Oliver', '3748916025');

CREATE TABLE userHistory (
  rec_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  rec_date DATE,
  action VARCHAR(100),
  PRIMARY KEY(rec_id)
);

INSERT INTO userHistory (user_id, rec_date, action) VALUES (3, '2017-01-01', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (5, '2017-01-01', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-01-10', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (7, '2017-01-10', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (6, '2017-01-15', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-01-15', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (4, '2017-01-17', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (5, '2017-01-17', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (10, '2017-01-17', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-17', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-19', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-01-19', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (10, '2017-01-20', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-20', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (3, '2017-01-20', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (7, '2017-01-20', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-01-22', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (3, '2017-01-22', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (13, '2017-01-22', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-24', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (7, '2017-01-24', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (5, '2017-01-25', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (10, '2017-01-25', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-28', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-01-29', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (8, '2017-02-01', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (3, '2017-02-01', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (6, '2017-02-01', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-02-02', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-02-02', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (10, '2017-02-02', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (7, '2017-02-02', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (10, '2017-02-05', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (2, '2017-02-05', 'off');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (8, '2017-02-05', 'logged_on');
INSERT INTO userHistory (user_id, rec_date, action) VALUES (1, '2017-02-05', 'logged_on');


/*1. Write a SQL query that returns the name, phone number and most recent date for any user that has logged in over the last 30 days
(you can tell a user has logged in if the action field in UserHistory is set to "logged_on").

Every time a user logs in a new row is inserted into the UserHistory table with user_id, current date and action (where action = "logged_on").*/


SELECT name,
       MAX(rec_date) AS most_recent_date,
       phone_num
FROM user, userHistory
WHERE user.user_id = userHistory.user_id
AND action = 'logged_on'
AND rec_date >= DATE_ADD(CURRENT_DATE(), INTERVAL -30 DAY)
GROUP BY user.user_id;


-- also correct:
SELECT user.name,
       user.phone_num,
       MAX(userHistory.rec_date)
FROM userHistory
LEFT JOIN user
ON userHistory.user_id = user.user_id
WHERE userHistory.action = 'logged_on'
AND userHistory.rec_date >= (DATE_ADD(CURRENT_DATE(), INTERVAL -30 DAY))
GROUP BY user.user_id;

-- WHERE userHistory.rec_date BETWEEN (DATE_ADD(CURRENT_DATE(), INTERVAL -30 DAY))
--                            AND CURRENT_DATE
-- AND userHistory.action = 'logged_on';


/*2. Write a SQL query to determine which user_ids in the User table are not contained in the UserHistory table
(assume the UserHistory table has a subset of the user_ids in User table). Do not use the SQL MINUS statement.
Note: the UserHistory table can have multiple entries for each user_id.*/

SELECT user_id
FROM user
WHERE user_id NOT IN (
  SELECT DISTINCT user_id
  FROM userHistory
);

-- same result
SELECT DISTINCT u.user_id
FROM user AS u
LEFT JOIN userHistory AS uh
ON u.user_id = uh.user_id
WHERE uh.user_id IS NULL;
