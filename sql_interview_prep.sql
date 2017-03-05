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

/*
Given timestamps of logins, figure out how many people were active all seven days of a week on a mobile phone.
*/
-- not very clear if asking
-- a) how many users (groupped by day) were active on mobile in general each day of week (e.g. 5 users were active on Monday, 10 on Tuesday, etc.) or
-- b) how many users (groupped by user) separately were active every day (e.g. user 1 was on all 7 days on mobile and user 3 also, so total number users who were active all 7 days = 2)
-- also unclear if asking for consecutive days or just all weekdays in general
-- solving with the assumption of b and not caring about consecutive days
CREATE TABLE logins (
  user_id INT NOT NULL
, login_time TIMESTAMP
, platform VARCHAR(20)
);

INSERT INTO logins (user_id, login_time, platform) VALUES
  (1, TIMESTAMP('2016-12-28'), 'mobile')
, (2, TIMESTAMP('2016-12-28'), 'mobile')
, (3, TIMESTAMP('2016-12-28'), 'browser')
, (4, TIMESTAMP('2016-12-28'), 'browser')
, (1, TIMESTAMP('2016-12-28'), 'browser')
, (6, TIMESTAMP('2016-12-28'), 'mobile')
, (1, TIMESTAMP('2016-12-29'), 'mobile')
, (1, TIMESTAMP('2016-12-29'), 'browser')
, (2, TIMESTAMP('2016-12-29'), 'browser')
, (2, TIMESTAMP('2016-12-29'), 'mobile')
, (4, TIMESTAMP('2016-12-29'), 'browser')
, (3, TIMESTAMP('2016-12-29'), 'browser')
, (5, TIMESTAMP('2016-12-29'), 'browser')
, (2, TIMESTAMP('2016-12-30'), 'browser')
, (3, TIMESTAMP('2016-12-30'), 'mobile')
, (5, TIMESTAMP('2016-12-30'), 'mobile')
, (2, TIMESTAMP('2016-12-30'), 'mobile')
, (1, TIMESTAMP('2016-12-30'), 'mobile')
, (2, TIMESTAMP('2016-12-30'), 'browser')
, (2, TIMESTAMP('2016-12-31'), 'mobile')
, (4, TIMESTAMP('2016-12-30'), 'mobile')
, (3, TIMESTAMP('2016-12-30'), 'mobile')
, (5, TIMESTAMP('2016-12-31'), 'browser')
, (1, TIMESTAMP('2016-12-31'), 'mobile')
, (6, TIMESTAMP('2016-12-31'), 'mobile')
, (7, TIMESTAMP('2017-01-01'), 'browser')
, (1, TIMESTAMP('2017-01-01'), 'mobile')
, (2, TIMESTAMP('2017-01-01'), 'mobile')
, (5, TIMESTAMP('2017-01-01'), 'browser')
, (3, TIMESTAMP('2017-01-01'), 'browser')
, (4, TIMESTAMP('2017-01-01'), 'mobile')
, (1, TIMESTAMP('2017-01-02'), 'browser')
, (6, TIMESTAMP('2017-01-02'), 'mobile')
, (2, TIMESTAMP('2017-01-02'), 'mobile')
, (4, TIMESTAMP('2017-01-02'), 'mobile')
, (3, TIMESTAMP('2017-01-02'), 'mobile')
, (1, TIMESTAMP('2017-01-02'), 'mobile')
, (2, TIMESTAMP('2017-01-03'), 'mobile')
, (1, TIMESTAMP('2017-01-03'), 'mobile')
, (4, TIMESTAMP('2017-01-03'), 'browser')
, (2, TIMESTAMP('2017-01-03'), 'mobile')
, (5, TIMESTAMP('2017-01-03'), 'mobile')
, (6, TIMESTAMP('2017-01-03'), 'mobile')
, (1, TIMESTAMP('2017-01-04'), 'mobile')
, (1, TIMESTAMP('2017-01-04'), 'browser')
, (5, TIMESTAMP('2017-01-04'), 'browser')
, (2, TIMESTAMP('2017-01-04'), 'browser')
, (3, TIMESTAMP('2017-01-04'), 'mobile')
, (4, TIMESTAMP('2017-01-05'), 'mobile')
, (5, TIMESTAMP('2017-01-05'), 'browser')
, (6, TIMESTAMP('2017-01-05'), 'browser')
, (1, TIMESTAMP('2017-01-05'), 'browser')
, (2, TIMESTAMP('2017-01-05'), 'mobile')
, (3, TIMESTAMP('2017-01-05'), 'browser')
, (1, TIMESTAMP('2017-01-05'), 'mobile')
, (2, TIMESTAMP('2017-01-05'), 'mobile')
, (5, TIMESTAMP('2017-01-05'), 'mobile')
, (4, TIMESTAMP('2017-01-05'), 'mobile')
, (1, TIMESTAMP('2017-01-06'), 'mobile')
, (2, TIMESTAMP('2017-01-06'), 'mobile')
, (3, TIMESTAMP('2017-01-06'), 'mobile')
, (4, TIMESTAMP('2017-01-06'), 'mobile')
, (5, TIMESTAMP('2017-01-06'), 'mobile')
, (6, TIMESTAMP('2017-01-06'), 'mobile')
;

SELECT COUNT(user_id) AS num_active_users
FROM
  -- table of all days of week each mobile user was active
  (SELECT COUNT(DISTINCT DAYOFWEEK(login_time)) as active_days
        , user_id
  FROM logins
  WHERE platform = 'mobile'
  GROUP BY user_id
  ORDER BY user_id, active_days) weekdays
GROUP BY active_days
HAVING active_days =7
;

/*
How do you determine what product was used most by the non-employee users for the last quarter?
*/

-- all info in one table
CREATE TABLE products_used (
  user_id INT NOT NULL
, date_of_use DATE
, employee_status VARCHAR(20)
, product VARCHAR(20)
, num_times_used INT
);

INSERT INTO products_used (user_id, date_of_use, employee_status, product, num_times_used) VALUES
  (100, '2016-09-15', 'employee', 'profile', 5)
, (200, '2016-09-15', 'non-employee', 'profile', 10)
, (300, '2016-09-15', 'employee', 'profile', 10)
, (300, '2016-09-15', 'employee', 'groups', 20)
, (400, '2016-09-15', 'employee', 'groups', 20)
, (100, '2016-09-20', 'employee', 'profile', 2)
, (200, '2016-09-20', 'non-employee', 'groups', 2)
, (500, '2016-09-21', 'non-employee', 'photos', 15)
, (200, '2016-09-21', 'non-employee', 'groups', 2)
, (500, '2016-09-22', 'non-employee', 'groups', 5)
, (200, '2016-09-22', 'non-employee', 'events', 5)
, (500, '2016-09-24', 'non-employee', 'search', 10)
, (300, '2016-09-25', 'employee', 'events', 20)
, (400, '2016-09-25', 'employee', 'photos', 23)
, (400, '2016-09-25', 'employee', 'profile', 12)
, (400, '2016-09-25', 'employee', 'groups', 5)
, (400, '2016-09-25', 'employee', 'search', 10)
, (100, '2016-10-05', 'employee', 'profile', 5)
, (200, '2016-10-05', 'non-employee', 'profile', 10)
, (300, '2016-10-05', 'employee', 'profile', 10)
, (300, '2016-10-15', 'employee', 'groups', 10)
, (400, '2016-10-15', 'employee', 'groups', 20)
, (100, '2016-10-20', 'employee', 'profile', 29)
, (200, '2016-10-20', 'non-employee', 'groups', 2)
, (500, '2016-10-22', 'non-employee', 'photos', 15)
, (200, '2016-10-23', 'non-employee', 'groups', 5)
, (500, '2016-10-24', 'non-employee', 'groups', 8)
, (200, '2016-10-24', 'non-employee', 'events', 5)
, (500, '2016-10-24', 'non-employee', 'search', 10)
, (300, '2016-10-25', 'employee', 'events', 20)
, (400, '2016-10-25', 'employee', 'photos', 23)
, (400, '2016-10-25', 'employee', 'profile', 12)
, (400, '2016-10-25', 'employee', 'groups', 5)
, (400, '2016-10-25', 'employee', 'search', 10)
, (100, '2016-11-05', 'employee', 'profile', 5)
, (200, '2016-11-05', 'non-employee', 'profile', 10)
, (300, '2016-11-05', 'employee', 'profile', 10)
, (300, '2016-11-15', 'employee', 'groups', 20)
, (400, '2016-11-15', 'employee', 'groups', 20)
, (100, '2016-11-20', 'employee', 'profile', 2)
, (200, '2016-11-20', 'non-employee', 'groups', 2)
, (500, '2016-11-22', 'non-employee', 'profile', 25)
, (200, '2016-11-23', 'non-employee', 'groups', 2)
, (500, '2016-11-24', 'non-employee', 'groups', 5)
, (200, '2016-11-24', 'non-employee', 'events', 5)
, (500, '2016-11-24', 'non-employee', 'search', 10)
, (500, '2016-11-24', 'non-employee', 'photos', 25)
, (200, '2016-11-24', 'non-employee', 'profile', 15)
, (500, '2016-11-24', 'non-employee', 'search', 9)
, (300, '2016-11-25', 'employee', 'events', 20)
, (400, '2016-11-25', 'employee', 'photos', 23)
, (400, '2016-11-25', 'employee', 'profile', 12)
, (400, '2016-11-27', 'employee', 'groups', 5)
, (200, '2016-11-27', 'non-employee', 'search', 10)
, (100, '2016-12-05', 'employee', 'profile', 5)
, (200, '2016-12-05', 'non-employee', 'profile', 10)
, (300, '2016-12-05', 'employee', 'profile', 10)
, (300, '2016-12-15', 'employee', 'groups', 20)
, (400, '2016-12-15', 'employee', 'groups', 20)
, (100, '2016-12-20', 'employee', 'profile', 2)
, (200, '2016-12-20', 'non-employee', 'groups', 2)
, (500, '2016-12-22', 'non-employee', 'profile', 25)
, (200, '2016-12-23', 'non-employee', 'groups', 2)
, (500, '2016-12-24', 'non-employee', 'profile', 5)
, (200, '2016-12-24', 'non-employee', 'photos', 5)
, (500, '2016-12-24', 'non-employee', 'search', 10)
, (300, '2016-12-25', 'employee', 'events', 20)
, (400, '2016-12-25', 'employee', 'photos', 23)
, (400, '2016-12-25', 'employee', 'profile', 12)
, (400, '2016-12-27', 'employee', 'groups', 5)
, (400, '2016-12-27', 'employee', 'search', 10)
, (200, '2017-01-01', 'non-employee', 'profile', 15)
, (200, '2017-01-01', 'non-employee', 'photos', 155)
, (500, '2017-01-01', 'non-employee', 'profile', 15)
, (500, '2017-01-01', 'non-employee', 'photos', 105)
, (200, '2017-01-02', 'non-employee', 'profile', 5)
;

SELECT product
     , SUM(num_times_used) as total_usage
FROM products_used
WHERE employee_status = 'non-employee'
AND date_of_use BETWEEN '2016-10-01' AND '2016-12-31'
GROUP BY product
ORDER BY total_usage DESC
LIMIT 1;


-- same question as above, but using separate tables
CREATE TABLE products (
  product_id INT NOT NULL PRIMARY KEY
, product_name VARCHAR(20)
);

INSERT INTO products (product_id, product_name) VALUES
  (1, 'profile')
, (2, 'photos')
, (3, 'groups')
, (4, 'events')
, (5, 'search')
;

CREATE TABLE user_table (
  user_id INT NOT NULL PRIMARY KEY
, user_name VARCHAR(30)
, employee_status VARCHAR(30)
);

INSERT INTO user_table (user_id, user_name, employee_status) VALUES
  (100, 'Jane Doe', 'employee')
, (200, 'John Smith', 'non-employee')
, (300, 'Victoria Brown', 'employee')
, (400, 'William White', 'employee')
, (500, 'Sally Sun', 'non-employee')
;

CREATE TABLE usage_stats (
  user_id INT NOT NULL
, date_of_use DATE
, product INT NOT NULL
, num_times_used INT
);

INSERT INTO usage_stats (user_id, date_of_use, product, num_times_used) VALUES
  (100, '2016-09-15', 1, 5)
, (200, '2016-09-15', 1, 10)
, (300, '2016-09-15', 1, 10)
, (300, '2016-09-15', 3, 20)
, (400, '2016-09-15', 3, 20)
, (100, '2016-09-20', 1, 2)
, (200, '2016-09-20', 3, 2)
, (500, '2016-09-21', 2, 15)
, (200, '2016-09-21', 3, 2)
, (500, '2016-09-22', 3, 5)
, (200, '2016-09-22', 4, 5)
, (500, '2016-09-24', 5, 10)
, (300, '2016-09-25', 4, 20)
, (400, '2016-09-25', 2, 23)
, (400, '2016-09-25', 1, 12)
, (400, '2016-09-25', 3, 5)
, (400, '2016-09-25', 5, 10)
, (100, '2016-10-05', 1, 5)
, (200, '2016-10-05', 1, 10)
, (300, '2016-10-05', 1, 10)
, (300, '2016-10-15', 3, 10)
, (400, '2016-10-15', 3, 20)
, (100, '2016-10-20', 1, 29)
, (200, '2016-10-20', 3, 2)
, (500, '2016-10-22', 2, 15)
, (200, '2016-10-23', 3, 5)
, (500, '2016-10-24', 3, 8)
, (200, '2016-10-24', 4, 5)
, (500, '2016-10-24', 5, 10)
, (300, '2016-10-25', 4, 20)
, (400, '2016-10-25', 2, 23)
, (400, '2016-10-25', 1, 12)
, (400, '2016-10-25', 3, 5)
, (400, '2016-10-25', 5, 10)
, (100, '2016-11-05', 1, 5)
, (200, '2016-11-05', 1, 10)
, (300, '2016-11-05', 1, 10)
, (300, '2016-11-15', 3, 20)
, (400, '2016-11-15', 3, 20)
, (100, '2016-11-20', 1, 2)
, (200, '2016-11-20', 3, 2)
, (500, '2016-11-22', 1, 25)
, (200, '2016-11-23', 3, 2)
, (500, '2016-11-24', 3, 5)
, (200, '2016-11-24', 4, 5)
, (500, '2016-11-24', 5, 10)
, (500, '2016-11-24', 2, 25)
, (200, '2016-11-24', 1, 15)
, (500, '2016-11-24', 5, 9)
, (300, '2016-11-25', 4, 20)
, (400, '2016-11-25', 2, 23)
, (400, '2016-11-25', 1, 12)
, (400, '2016-11-27', 3, 5)
, (200, '2016-11-27', 5, 10)
, (100, '2016-12-05', 1, 5)
, (200, '2016-12-05', 1, 10)
, (300, '2016-12-05', 1, 10)
, (300, '2016-12-15', 3, 20)
, (400, '2016-12-15', 3, 20)
, (100, '2016-12-20', 1, 2)
, (200, '2016-12-20', 3, 2)
, (500, '2016-12-22', 1, 25)
, (200, '2016-12-23', 3, 2)
, (500, '2016-12-24', 1, 5)
, (200, '2016-12-24', 2, 5)
, (500, '2016-12-24', 5, 10)
, (300, '2016-12-25', 4, 20)
, (400, '2016-12-25', 2, 23)
, (400, '2016-12-25', 1, 12)
, (400, '2016-12-27', 3, 5)
, (400, '2016-12-27', 5, 10)
, (200, '2017-01-01', 1, 15)
, (200, '2017-01-01', 2, 155)
, (500, '2017-01-01', 1, 15)
, (500, '2017-01-01', 2, 105)
, (200, '2017-01-02', 1, 5)
;

SELECT p.product_name name
     , SUM(stats.num_times_used) num_times_used
FROM products p
LEFT JOIN usage_stats stats
ON stats.product = p.product_id
LEFT JOIN user_table u
ON stats.user_id = u.user_id
WHERE u.employee_status = 'non-employee'
AND stats.date_of_use BETWEEN '2016-10-01' AND '2016-12-31'
GROUP BY stats.product, name
ORDER BY num_times_used DESC
LIMIT 1;
