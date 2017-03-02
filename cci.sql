-- Cracking the Coding Interview
CREATE TABLE Courses (
  CourseID INT NOT NULL PRIMARY KEY
, CourseName VARCHAR(20)
, TeacherID INT NOT NULL
);

INSERT INTO Courses (CourseID, CourseName, TeacherID) VALUES
  (1, 'Mathematics', 100)
, (2, 'Geometry', 100)
, (3, 'Geography', 300)
, (4, 'Physics', 400)
, (5, 'Chemistry', 500)
, (6, 'Political Science', 600)
, (7, 'Microeconomics', 700)
, (8, 'Macroeconomics', 700)
, (9, 'Accounting', 900)
, (10, 'Statistics', 1000)
;


CREATE TABLE Teachers (
  TeacherID INT NOT NULL PRIMARY KEY
, TeacherName VARCHAR(25)
);

INSERT INTO Teachers (TeacherID, TeacherName) VALUES
  (100, 'Amy Smith')
, (200, 'Barbara Jones')
, (300, 'Chris Wallace')
, (400, 'David Brown')
, (500, 'Emily White')
, (600, 'Francis Smith')
, (700, 'George Smith')
, (800, 'Henry Jones')
, (900, 'Irene Brown')
, (1000, 'Jerry Williams')
;


CREATE TABLE Students (
  StudentID INT NOT NULL PRIMARY KEY
, StudentName VARCHAR(25)
);

INSERT INTO Students (StudentID, StudentName) VALUES
  (101, 'Abby Brown')
, (102, 'Bobby Smith')
, (103, 'Christina Jones')
, (104, 'Dominic Williams')
, (105, 'Edward White')
, (106, 'Francis Jones')
, (107, 'Gerry Brown')
, (108, 'Harry Potter')
, (109, 'Ivan Terrible')
, (110, 'John Doe')
;

CREATE TABLE StudentCourses (
  CourseID INT NOT NULL
, StudentID INT NOT NULL
, PRIMARY KEY (CourseID, StudentID)
);

INSERT INTO StudentCourses (CourseID, StudentID) VALUES
  (1, 101)
, (1, 103)
, (1, 104)
, (1, 105)
, (1, 110)
, (2, 102)
, (2, 105)
, (2, 107)
, (2, 108)
, (2, 109)
, (2, 110)
, (3, 101)
, (3, 102)
, (3, 103)
, (3, 105)
, (3, 110)
, (4, 101)
, (4, 107)
, (4, 108)
, (4, 109)
, (5, 101)
, (5, 102)
, (5, 104)
, (5, 107)
, (5, 108)
, (5, 109)
, (5, 110)
, (6, 104)
, (6, 107)
, (7, 109)
, (9, 101)
, (9, 105)
, (9, 109)
;

/*
List all students and how many courses each is enrolled in
*/
SELECT s.StudentID s_id
     , s.StudentName s_name
     , COUNT(sc.CourseID) course_count
FROM Students s
LEFT JOIN StudentCourses sc
ON s.StudentID = sc.StudentID
GROUP BY s_id, s_name;


/*
List all teachers and how many students each has
*/
SELECT t.TeacherID
     , t.TeacherName
     , COUNT(sc.StudentID) num_students
FROM Teachers t
LEFT JOIN Courses c
ON t.TeacherID = c.TeacherID
LEFT JOIN StudentCourses sc
ON c.CourseID = sc.CourseID
GROUP BY t.TeacherID, t.TeacherName
ORDER BY num_students DESC;

/*
-- Book solution. Same result.
SELECT TeacherName
    , ifnull(StudentSize.num_students, 0) as num_students
FROM Teachers
LEFT JOIN (
   Select TeacherID, count(StudentCourses.CourseID) as num_students
   FROM Courses
   INNER JOIN StudentCourses
   ON Courses.CourseID = StudentCourses.CourseID
   GROUP BY Courses.TeacherID
 ) StudentSize
ON Teachers.TeacherID = StudentSize.TeacherID
ORDER BY StudentSize.num_students DESC;
*/
