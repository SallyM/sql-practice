/*
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name).
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
*/

SELECT city,
       len
FROM (
      SELECT CITY as city,
             CHAR_LENGTH(CITY) as len
      FROM STATION
      ORDER BY len, city
      LIMIT 1
     ) as shortest
UNION ALL
SELECT city,
       len
FROM (
      SELECT CITY as city,
      CHAR_LENGTH(CITY) as len
      FROM STATION
      ORDER BY len DESC, city ASC
      LIMIT 1
     ) as longest
;

/*
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
Your result cannot contain duplicates.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY RLIKE '^[^aeiouAEIOU]'
OR CITY RLIKE '[^aeiouAEIOU]$'
;


/*
Query the Name of any student in STUDENTS who scored higher than 75 Marks.
Order your output by the last three characters of each name.
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
*/
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name, 3) ASC, ID;


/*
A median is defined as a number separating the higher half of a data set from the lower half.
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.

-- to get index of the middle number:
select count(*)/2
from station;

*/

SELECT ROUND(LAT_N, 4) as median
FROM STATION
ORDER BY LAT_N
LIMIT 249, 1
;

/*
*/
-- code by timcottenio, taken from discussion section
SELECT Start_Date, End_Date
FROM
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date
