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
  SELECT name,
         age
  FROM salesperson
  WHERE salary >= 100000;
