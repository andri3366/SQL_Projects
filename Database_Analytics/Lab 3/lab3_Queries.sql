-- Student Name: Andrianna Wardill
-- Student Number: 041067235
USE UniversityCourseManagement;

-- Select Queries
-- List the names of all student
SELECT Name 
FROM Student;

-- Course name and credit hours from all courses
SELECT Course_Name, Credit_Hours
FROM Course;

-- Department and office location of Alan Turing
SELECT Department, Office_Location
FROM Instructor
WHERE Name = "Dr. Alan Turing";

-- Filtering Results
-- Name and email addresses of student born after "2000-01-01"
SELECT Name, Email, Date_Of_Birth
FROM Student
WHERE Date_Of_Birth > "2000-01-01";

-- Course name and credit hours of courses worth 4 credit hours
SELECT Course_Name, Credit_Hours
FROM Course
WHERE Credit_Hours = 4;

-- Names of instructors in the Computer Science department
SELECT Name
FROM Instructor
WHERE Department = "Computer Science";
