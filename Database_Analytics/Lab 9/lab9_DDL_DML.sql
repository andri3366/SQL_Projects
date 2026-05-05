create database lab9;
use lab9;

-- DDL
CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL,
OfficeLocation VARCHAR(100)
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
MajorDepartmentID INT,
EnrollmentYear INT,
Email VARCHAR(100),
FOREIGN KEY (MajorDepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
DepartmentID INT,
HireDate DATE,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
CourseCode VARCHAR(20) NOT NULL,
CourseTitle VARCHAR(100) NOT NULL,
DepartmentID INT NOT NULL,
Credits INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Sections (
SectionID INT PRIMARY KEY,
CourseID INT NOT NULL,
InstructorID INT,
Semester VARCHAR(20) NOT NULL,
YearOffered INT NOT NULL,
Room VARCHAR(20),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT NOT NULL,
SectionID INT NOT NULL,
EnrollmentDate DATE,
Grade VARCHAR(2),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (SectionID) REFERENCES Sections(SectionID)
);

-- DML
INSERT INTO Departments VALUES
(1, 'Computer Science', 'B201'),
(2, 'Business', 'C110'),
(3, 'Mathematics', 'A315'),
(4, 'English', 'D220');

INSERT INTO Students VALUES
(101, 'Ali', 'Hassan', 1, 2023, 'ali.hassan@college.edu'),
(102, 'Sara', 'Khan', 2, 2022, 'sara.khan@college.edu'),
(103, 'Michael', 'Smith', 1, 2021, 'michael.smith@college.edu'),
(104, 'Lina', 'Chen', 3, 2023, 'lina.chen@college.edu'),
(105, 'Omar', 'Farah', 4, 2024, 'omar.farah@college.edu'),
(106, 'Nora', 'Ahmed', NULL, 2024, 'nora.ahmed@college.edu');

INSERT INTO Instructors VALUES
(201, 'John', 'Miller', 1, '2018-08-15'),
(202, 'Emily', 'Clark', 2, '2019-01-10'),
(203, 'David', 'Lee', 3, '2016-09-01'),
(204, 'Sophia', 'Brown', 4, '2020-02-20'),
(205, 'James', 'Wilson', 1, '2021-06-01');

INSERT INTO Courses VALUES
(301, 'CST101', 'Introduction to Databases', 1, 3),
(302, 'CST220', 'Advanced SQL', 1, 4),
(303, 'BUS150', 'Principles of Management', 2, 3),
(304, 'MAT200', 'Statistics I', 3, 3),
(305, 'ENG110', 'Academic Writing', 4, 3),
(306, 'CST330', 'Data Warehousing', 1, 4);

INSERT INTO Sections VALUES
(401, 301, 201, 'Fall', 2025, 'R101'),
(402, 302, 205, 'Fall', 2025, 'R102'),
(403, 303, 202, 'Fall', 2025, 'B210'),
(404, 304, 203, 'Fall', 2025, 'M120'),
(405, 305, 204, 'Fall', 2025, 'E115'),
(406, 306, NULL, 'Fall', 2025, 'R103'),
(407, 301, 201, 'Winter', 2026, 'R101');

INSERT INTO Enrollments VALUES
(501, 101, 401, '2025-08-20', 'A'),
(502, 101, 402, '2025-08-20', 'B+'),
(503, 102, 403, '2025-08-21', 'A-'),
(504, 103, 401, '2025-08-22', 'B'),
(505, 103, 404, '2025-08-22', 'A'),
(506, 104, 404, '2025-08-23', 'A-'),
(507, 105, 405, '2025-08-24', 'B+'),
(508, 102, 401, '2025-08-25', 'B'),
(509, 106, 406, '2025-08-26', NULL);
