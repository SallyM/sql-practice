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
VALUES (1, 'Abe', 61, 140000),
       (2, 'Bob', 34, 44000),
       (5, 'Chris', 34, 40000),
       (7, 'Dan', 41, 52000),
       (8, 'Ken', 57, 115000),
       (11, 'Joe', 38, 38000);


CREATE TABLE customer (
  id INT NOT NULL,
  name VARCHAR(50),
  city VARCHAR(50),
  industry_type VARCHAR(50),
  PRIMARY KEY (id)
);

INSERT INTO customer (id, name, city, industry_type)
VALUES (4, 'Samsonic', 'pleasant', 'J'),
       (6, 'Panasung', 'oaktown', 'J'),
       (7, 'Samony', 'jackson', 'B'),
       (9, 'Orange', 'jackson', 'B');


CREATE TABLE orders (
  num INT NOT NULL,
  order_date DATE,
  cust_id INT NOT NULL,
  salesperson_id INT NOT NULL,
  amount FLOAT(100, 4),
  PRIMARY KEY (num)
);

INSERT INTO orders (num, order_date, cust_id, salesperson_id, amount)
VALUES (10, '1998-08-02', 4, 2, 540),
       (20, '1999-01-30', 4, 8, 1800),
       (30, '1995-07-14', 9, 1, 460),
       (40, '1998-01-29', 7, 2, 2400),
       (50, '1998-02-03', 6, 7, 600),
       (60, '1998-03-02', 6, 7, 720),
       (70, '1998-05-06', 9, 7, 150);


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

INSERT INTO user (name, phone_num)
VALUES ('Abe', '1234567890'),
       ('Bob', '9876543210'),
       ('Chris', '6789012345'),
       ('Danny', '5678901234'),
       ('Emily', '6543298710'),
       ('Fran', '6789012345'),
       ('George', '9012567834'),
       ('Harry', '5432698710'),
       ('Ian', '7890162345'),
       ('Jane', '8901672345'),
       ('Kevin', '2348901675'),
       ('Lilly', '3489021675'),
       ('Mary', '4890216375'),
       ('Nick', '1637489025'),
       ('Oliver', '3748916025');

CREATE TABLE userHistory (
  rec_id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  rec_date DATE,
  action VARCHAR(100),
  PRIMARY KEY(rec_id)
);

INSERT INTO userHistory (user_id, rec_date, action)
VALUES (3, '2017-01-01', 'logged_on'),
        (5, '2017-01-01', 'logged_on'),
        (1, '2017-01-10', 'logged_on'),
        (7, '2017-01-10', 'off'),
        (6, '2017-01-15', 'logged_on'),
        (1, '2017-01-15', 'off'),
        (4, '2017-01-17', 'logged_on'),
        (5, '2017-01-17', 'logged_on'),
        (10, '2017-01-17', 'off'),
        (2, '2017-01-17', 'logged_on'),
        (2, '2017-01-19', 'off'),
        (1, '2017-01-19', 'logged_on'),
        (10, '2017-01-20', 'logged_on'),
        (2, '2017-01-20', 'logged_on'),
        (3, '2017-01-20', 'logged_on'),
        (7, '2017-01-20', 'off'),
        (1, '2017-01-22', 'logged_on'),
        (3, '2017-01-22', 'off'),
        (13, '2017-01-22', 'logged_on'),
        (2, '2017-01-24', 'off'),
        (7, '2017-01-24', 'logged_on'),
        (5, '2017-01-25', 'logged_on'),
        (10, '2017-01-25', 'logged_on'),
        (2, '2017-01-28', 'off'),
        (2, '2017-01-29', 'logged_on'),
        (8, '2017-02-01', 'logged_on'),
        (3, '2017-02-01', 'off'),
        (6, '2017-02-01', 'logged_on'),
        (2, '2017-02-02', 'off'),
        (1, '2017-02-02', 'logged_on'),
        (10, '2017-02-02', 'logged_on'),
        (7, '2017-02-02', 'logged_on'),
        (10, '2017-02-05', 'logged_on'),
        (2, '2017-02-05', 'off'),
        (8, '2017-02-05', 'logged_on'),
        (1, '2017-02-05', 'logged_on');


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

-- Advanced SQL questions:
/*Here is the problem: find the largest order amount for each salesperson
and the associated order number, along with the customer to whom that order belongs.
You can present your answer in any database’s SQL – MySQL, Microsoft SQL Server, Oracle, etc.*/

SELECT orders.salesperson_id,
       salesperson.name,
       orders.num as order_num,
       orders.amount,
       orders.cust_id,
       customer.name
FROM orders
JOIN salesperson
ON salesperson.id = orders.salesperson_id
JOIN customer
ON customer.id = orders.cust_id
JOIN (
      SELECT salesperson_id,
             MAX(amount) as max_order
      FROM orders
      GROUP BY salesperson_id
) AS MaxOrdersBySalesperson
USING (salesperson_id)
WHERE amount = max_order;

/*
SELECT orders.salesperson_id,
       salesperson.name,
       orders.num as order_num,
       orders.amount,
       orders.cust_id,
       customer.name
FROM orders
JOIN salesperson
ON salesperson.id = orders.salesperson_id
JOIN customer
ON customer.id = orders.cust_id
JOIN (
      SELECT salesperson_id,
             MAX(amount) as max_order
      FROM orders
      GROUP BY salesperson_id
) AS MaxOrdersBySalesperson
ON orders.salesperson_id = MaxOrdersBySalesperson.salesperson_id
WHERE amount = max_order;
*/
