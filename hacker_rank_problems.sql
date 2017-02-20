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
