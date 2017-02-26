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

/*
You are given three tables: Students, Friends and Packages.
Students contains two columns: ID and Name.
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend).
Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them.
Names must be ordered by the salary amount offered to the best friends.
It is guaranteed that no two students got same salary offer.
*/
SELECT Students.Name
FROM Students
JOIN
    (SELECT f.ID as id,
           s.Salary as salary,
           f.Friend_id as f_id,
           fs.Salary as f_salary
    FROM Friends f
    JOIN Packages AS s
    ON f.ID = s.ID
    JOIN Packages AS fs
    ON f.Friend_ID = fs.ID) as comb
ON Students.ID = comb.id
WHERE comb.f_salary > comb.salary
ORDER BY comb.f_salary;

/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Not A Triangle: The given values of A, B, and C don't form a triangle.
Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
*/

SELECT (CASE
       WHEN A + B > C AND A + C > B AND B + C > A
        THEN (CASE
               WHEN A = B AND B = C AND A = C
                THEN 'Equilateral'
               WHEN A = B OR B = C OR A = C
                THEN 'Isosceles'
               ELSE 'Scalene'
              END)
        ELSE 'Not A Triangle'
       END) as figure_type
FROM TRIANGLES
;


/*
Generate the following two result sets:

1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
        There are total [occupation_count] [occupation]s.
   where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.
*/

SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') as Name_prof
FROM OCCUPATIONS
ORDER BY Name_prof
;

SELECT CONCAT('There are total ', cnt, " ", lower(Occupation), 's.') AS totals
FROM (SELECT COUNT(*) as cnt,
             Occupation
    FROM OCCUPATIONS
    GROUP BY Occupation
    ORDER BY Occupation) as groupped
ORDER BY totals
;

/*
Samantha interviews many candidates from different colleges using coding challenges and contests.
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id.
Exclude the contest from the result if all four sums are 0.

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds screening contest.
*/
SELECT Contests.contest_id as contest_id
     , Contests.hacker_id as hacker_id
     , Contests.name as name
     , IFNULL(by_cont.total_submissions, 0) as total_submissions
     , IFNULL(by_cont.total_accepted_submissions, 0) as total_accepted_submissions
     , IFNULL(by_cont.total_views, 0) as total_views
     , IFNULL(by_cont.total_unique_views, 0) as total_unique_views
FROM
    (SELECT Colleges.contest_id as contest_id
         , SUM(IFNULL(by_college.total_submissions, 0)) as total_submissions
         , SUM(IFNULL(by_college.total_accepted_submissions, 0)) as total_accepted_submissions
         , SUM(IFNULL(by_college.total_views, 0)) as total_views
         , SUM(IFNULL(by_college.total_unique_views, 0)) as total_unique_views
    FROM
       (SELECT c.college_id as college_id
             , SUM(IFNULL(stats.total_submissions, 0)) as total_submissions
             , SUM(IFNULL(stats.total_accepted_submissions, 0)) as total_accepted_submissions
             , SUM(IFNULL(stats.total_views, 0)) as total_views
             , SUM(IFNULL(stats.total_unique_views, 0)) as total_unique_views
        FROM
            (SELECT s.challenge_id as challenge_id
                  , s.total_submissions as total_submissions
                  , s.total_accepted_submissions as total_accepted_submissions
                  , v.total_views as total_views
                  , v.total_unique_views as total_unique_views
             FROM
                (SELECT challenge_id
                     , SUM(IFNULL(total_submissions, 0)) as total_submissions
                     , SUM(IFNULL(total_accepted_submissions, 0)) as total_accepted_submissions
                FROM Submission_Stats
                GROUP BY challenge_id) s
                RIGHT JOIN
                (SELECT challenge_id
                     , SUM(total_views) as total_views
                     , SUM(total_unique_views) as total_unique_views
                FROM View_Stats
                GROUP BY challenge_id) v
                USING (challenge_id)) stats
            RIGHT JOIN Challenges c
            USING (challenge_id)
        GROUP BY college_id) by_college
        RIGHT JOIN Colleges
        USING (college_id)
    GROUP BY contest_id) as by_cont
    RIGHT JOIN Contests
    USING (contest_id)
WHERE total_submissions > 0
    OR total_accepted_submissions > 0
    OR total_views > 0
    OR total_unique_views > 0
ORDER BY contest_id
;

SELECT conts.contest_id as contest_id
     , conts.hacker_id as hacker_id
     , conts.name as name
     , SUM(CASE WHEN by_cont.total_submissions is NULL THEN 0 ELSE by_cont.total_submissions END) as ts
     , SUM(CASE WHEN by_cont.total_accepted_submissions is NULL THEN 0 ELSE by_cont.total_accepted_submissions END) as tas
     , SUM(CASE WHEN by_cont.total_views is NULL THEN 0 ELSE by_cont.total_views END) as tv
     , SUM(CASE WHEN by_cont.total_unique_views is NULL THEN 0 ELSE by_cont.total_unique_views END) as tuv
FROM Contests conts
LEFT JOIN
    (SELECT col.contest_id as contest_id
         , (CASE WHEN by_college.total_submissions is NULL THEN 0 ELSE by_college.total_submissions END) as total_submissions
         , (CASE WHEN by_college.total_accepted_submissions is NULL THEN 0 ELSE by_college.total_accepted_submissions END) as total_accepted_submissions
         , (CASE WHEN by_college.total_views is NULL THEN 0 ELSE by_college.total_views END) as total_views
         , (CASE WHEN by_college.total_unique_views is NULL THEN 0 ELSE by_college.total_unique_views END) as total_unique_views
    FROM Colleges col
    LEFT JOIN
        (SELECT c.college_id as college_id
            , (CASE WHEN stats.total_submissions is NULL THEN 0 ELSE stats.total_submissions END) as total_submissions
            , (CASE WHEN stats.total_accepted_submissions is NULL THEN 0 ELSE stats.total_accepted_submissions END) as total_accepted_submissions
            , (CASE WHEN stats.total_views is NULL THEN 0 ELSE stats.total_views END) as total_views
            , (CASE WHEN stats.total_unique_views is NULL THEN 0 ELSE stats.total_unique_views END) as total_unique_views
            FROM Challenges c
            LEFT JOIN
                (SELECT v.challenge_id as challenge_id
                 , (CASE WHEN s.total_submissions is NULL THEN 0 ELSE s.total_submissions END) as total_submissions
                 , (CASE WHEN s.total_accepted_submissions is NULL THEN 0 ELSE s.total_accepted_submissions END) as total_accepted_submissions
                 , v.total_views as total_views
                 , v.total_unique_views as total_unique_views
                 FROM View_Stats v
                 LEFT JOIN Submission_Stats s
                 USING (challenge_id)
                    ) stats
            USING (challenge_id)
        ) by_college
    USING (college_id)
    ) by_cont
USING (contest_id)
GROUP BY contest_id, hacker_id, name
HAVING ts > 0 OR tas > 0 OR tv > 0 OR tuv > 0
ORDER BY contest_id
;
