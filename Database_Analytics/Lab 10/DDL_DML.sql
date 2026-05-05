-- Andrianna Wardill (041067235)
create database CollegeDB
use CollegeDB;

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Major VARCHAR(50),
EnrollmentYear INT
);
CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseName VARCHAR(100) NOT NULL,
Credits INT CHECK (Credits > 0)
);
CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
CONSTRAINT stid FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
CONSTRAINT crsid FOREIGN KEY(CourseID) REFERENCES Courses(CourseID),
Grade CHAR(1) CHECK (Grade IN ('A', 'B', 'C', 'D', 'F', NULL))
);
INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES
(1, 'John', 'Doe', 'Computer Science', 2022),
(2, 'Jane', 'Smith', 'Mathematics', 2021),
(3, 'Alice', 'Johnson', 'Physics', 2023);
INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES
(101, 'Data Structures', 3),
(102, 'Calculus I', 4),
(103, 'Physics I', 4);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade)
VALUES
(1, 1, 101, 'A'),
(2, 2, 102, 'B'),
(3, 3, 103, NULL);