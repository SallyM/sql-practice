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
  (4, 4, '2012-04-07', 5),
  (5, 1, '2012-04-08', 2),
  (6, 5, '2012-04-09', 3),
  (7, 1, '2012-04-10', 1),
  (8, 3, '2012-05-02', 4),
  (9, 1, '2012-05-02', 3),
  (10, 3, '2012-05-02', 5),
  (11, 4, '2012-05-02', 1),
  (12, 1, '2012-05-05', 3),
  (13, 1, '2012-05-05', 2),
  (14, 4, '2012-05-06', 1),
  (15, 1, '2012-05-08', 2),
  (16, 1, '2012-05-02', 4),
  (17, 3, '2013-01-02', 2),
  (18, 3, '2013-01-02', 3),
  (19, 1, '2013-01-03', 2),
  (20, 1, '2013-01-03', 2),
  (21, 2, '2013-01-05', 1),
  (22, 2, '2013-01-05', 2),
  (23, 1, '2013-10-02', 3),
  (24, 4, '2013-10-02', 2),
  (25, 1, '2013-10-02', 5),
  (26, 5, '2013-12-02', 3),
  (27, 1, '2014-04-02', 2),
  (28, 3, '2014-08-02', 4),
  (29, 1, '2014-09-02', 3),
  (30, 3, '2015-01-02', 5),
  (31, 4, '2015-02-02', 2),
  (32, 1, '2015-04-02', 2),
  (33, 1, '2015-04-05', 2),
  (34, 4, '2016-04-02', 1),
  (35, 1, '2016-05-02', 5),
  (36, 1, '2016-05-10', 4),
  (37, 3, '2016-08-02', 2),
  (38, 3, '2016-10-02', 3),
  (39, 1, '2017-02-02', 2),
  (40, 1, '2017-02-20', 2),
  (41, 2, '2011-04-02', 1),
  (42, 2, '2012-04-02', 2),
  (43, 1, '2012-04-05', 3),
  (44, 4, '2012-04-07', 5),
  (45, 1, '2012-04-08', 2),
  (46, 5, '2012-04-09', 3),
  (47, 1, '2012-04-10', 1),
  (48, 3, '2012-05-02', 4),
  (49, 1, '2012-05-02', 3),
  (50, 3, '2012-05-02', 5),
  (51, 4, '2012-05-02', 1),
  (52, 1, '2012-05-05', 3),
  (53, 1, '2012-05-05', 2),
  (54, 4, '2012-05-06', 1),
  (55, 1, '2012-05-08', 2),
  (56, 1, '2012-05-02', 4),
  (57, 3, '2013-01-02', 2),
  (58, 3, '2013-01-02', 3),
  (59, 1, '2013-01-03', 2),
  (60, 1, '2013-01-03', 2),
  (61, 2, '2013-01-05', 1),
  (62, 2, '2013-01-05', 2),
  (63, 1, '2013-10-02', 3),
  (64, 4, '2013-10-02', 2),
  (65, 1, '2013-10-02', 5),
  (66, 5, '2013-12-02', 3),
  (67, 1, '2014-04-02', 2),
  (68, 3, '2014-08-02', 4),
  (69, 1, '2014-09-02', 3),
  (70, 3, '2015-01-02', 5),
  (71, 4, '2015-02-02', 2),
  (72, 1, '2015-04-02', 2),
  (73, 1, '2015-04-05', 2),
  (74, 4, '2016-04-02', 1),
  (75, 1, '2016-05-02', 5),
  (76, 1, '2016-05-10', 4),
  (77, 3, '2016-08-02', 2),
  (78, 3, '2016-10-02', 3),
  (79, 1, '2017-02-02', 2),
  (80, 1, '2017-02-20', 2),
  (81, 4, '2015-02-02', 2),
  (82, 1, '2015-04-02', 2),
  (83, 1, '2015-04-05', 2),
  (84, 4, '2016-04-02', 1),
  (85, 1, '2016-05-02', 5),
  (86, 1, '2016-05-10', 4),
  (87, 3, '2016-08-02', 2),
  (88, 3, '2016-10-02', 3),
  (89, 1, '2017-02-02', 2),
  (90, 1, '2017-02-20', 2),
  (91, 4, '2012-05-02', 1),
  (92, 1, '2012-05-05', 3),
  (93, 1, '2012-05-05', 2),
  (94, 4, '2012-05-06', 1),
  (95, 1, '2012-05-08', 2),
  (96, 1, '2012-05-02', 4),
  (97, 3, '2013-01-02', 2),
  (98, 3, '2013-01-02', 3),
  (99, 1, '2013-01-03', 2),
  (100, 1, '2013-01-03', 2);

insert into bones (id, name) VALUES
  (1, 'T-Rex'),
  (2, 'Veloceraptor'),
  (3, 'Triceraptor'),
  (4, 'Veloceraptor'),
  (5, 'T-Rex');

/*
Get names of top 3 sites each year for Veloceraptor bones
*/
/*
(SELECT s.Name as site_name,
        YEAR(f.find_date) as yr,
        COUNT(f.id) as cnt
FROM finds f
JOIN bones b
ON f.Bone_id = b.id
JOIN sites s
ON f.site_id = s.id
WHERE b.name = 'Veloceraptor'
GROUP BY yr, site_name
ORDER BY yr ASC, cnt DESC
LIMIT 3)
*/
/*SET @site_rank = NULL, @curr_rank = NULL;

SELECT ranked.yr as yr
     , COUNT(ranked.site_id) as cnt
     , sites.Name as site_name
FROM
    (SELECT year(find_date) AS yr
           , site_id
           , count(site_id) as cnt
           , @site_rank := IF (@curr_rank = site_id, @site_rank + 1, 1) AS rank
           , @curr_rank := site_id AS whatever
    FROM finds
    WHERE Bone_id = 2
    GROUP BY yr, site_id, whatever
    ORDER BY yr ) ranked
JOIN sites
ON sites.id = ranked.site_id
GROUP BY yr, site_name
ORDER BY yr ASC, cnt DESC;
*/
SELECT ranked.yr as yr
      , s.Name as site_name
FROM
    (SELECT counted.yr as yr
          , counted.site as site
          , counted.cnt as cnt
          , @site_rank := IF (@curr_rank = counted.cnt, 1, @site_rank + 1) AS rank
          , @curr_rank := counted.cnt AS whatever
    FROM
      (SELECT YEAR(find_date) AS yr
           , site_id AS site
           , COUNT(id) AS cnt
      FROM finds
      WHERE Bone_id = 2
      GROUP BY yr, site
      ORDER BY yr ASC, cnt DESC) counted) ranked
JOIN sites s
ON s.id = ranked.site
WHERE ranked.rank <= 3
ORDER BY yr;
