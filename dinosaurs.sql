create table sites (
  id int not null primary key,
  Name varchar(50),
  location varchar(50)
);

create table finds (
  id int not null primary key,
  site_id int,
  find_date date,
  Bone_id int
);

create table bones (
  id int not null primary key,
  name varchar(50)
);

insert into sites (id, Name, location) VALUES
  (1, 'Seattle', 'USA'),
  (2, 'Moscow', 'RU'),
  (3, 'Tashkent', 'UZB'),
  (4, 'Rome', 'ITA'),
  (5, 'Sydney', 'AUS');

insert into finds (id, site_id, find_date, Bone_id) VALUES
  (1, 2, '2011-04-02', 1),
  (2, 2, '2012-04-02', 2),
  (3, 1, '2012-04-05', 3),
  (4, 4, '2012-04-02', 5),
  (5, 1, '2013-10-02', 5),
  (6, 5, '2013-12-02', 3),
  (7, 1, '2014-04-02', 1),
  (8, 3, '2014-08-02', 4),
  (9, 1, '2014-09-02', 3),
  (10, 3, '2015-01-02', 5),
  (11, 4, '2015-02-02', 1),
  (12, 1, '2015-04-02', 3),
  (13, 1, '2015-04-05', 2),
  (14, 4, '2016-04-02', 1),
  (15, 1, '2016-05-02', 5),
  (16, 1, '2016-05-10', 4),
  (17, 3, '2016-08-02', 2),
  (18, 3, '2016-10-02', 3),
  (19, 1, '2017-02-02', 2),
  (20, 1, '2017-02-20', 2);

insert into bones (id, name) VALUES
  (1, 'T-Rex'),
  (2, 'Veloceraptor'),
  (3, 'Triceraptor'),
  (4, 'Veloceraptor'),
  (5, 'T-Rex');

/*
Get names of top 3 sites each year for Veloceraptor bones
*/
