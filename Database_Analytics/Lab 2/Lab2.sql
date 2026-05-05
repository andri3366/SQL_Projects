CREATE DATABASE Lab2;
USE Lab2;

CREATE TABLE Students (
	StudentID INT(10) PRIMARY KEY NOT NULL,
    FullName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(50) NOT NULL
);

CREATE TABLE Instructors (
	InstructorID INT(10) PRIMARY KEY NOT NULL,
    FullName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NUll
);

CREATE TABLE Courses (
	CourseID INT(10) PRIMARY KEY NOT NULL,
    CourseName VARCHAR(100) NOT NULL,
    CreditHours INT(3) NOT NULL,
    InstructorID INT(10) NOT NULL, 
    FOREIGN KEY (InstructorID) REFERENCES Instructors (InstructorID)
);
    
CREATE TABLE Enrollments (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT(10) NOT NULL,
    CourseID INT(10) NOT NULL,
	Grade DECIMAL (5,2) NOT NULL CHECK (Grade <= 100.00),
    FOREIGN KEY (StudentID) REFERENCES Students (StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses (CourseID)
);

INSERT INTO Students (StudentID, FullName, DateOfBirth, Email) VALUES
	(100, 'John Smith', '2002-12-12', 'johnsmith@email.com'),
    (200, 'Jane Doe', '1998-05-16', 'janedoe@gmail.com'),
    (300, 'Andrianna Wardill', '2004-08-22', 'ward0366@algonquinlive.com');
    
INSERT INTO Instructors (InstructorID, FullName, Department) VALUES
	(45, 'Xin Zhao', 'Supplementary'),
    (834, 'Greg Thompson', 'Sicence'),
    (60, 'Yasser Jafer', 'Analytics');

INSERT INTO Courses (CourseID, CourseName, CreditHours, InstructorID) VALUES
	(1001, 'Intro to Statistics', 50, 45),
    (2000, 'Intro to Computer Science', 72, 60),
    (1302, 'Molecular Biology', 68, 834),
    (1480, 'Organic Chemistry', 70, 834),
    (970, 'History of Oil', 34, 45),
    (2102, 'Database Analytics', 72, 60);
    
INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES 
	(100, 1001, 56.08),
    (100, 2000, 72.57),
    (100, 1302, 88.34),
    (200, 1302, 92.46),
    (200, 1480, 91.35),
    (200, 970, 89.12),
    (300, 2000, 85.82),
    (300, 1302, 81.43),
    (300, 2102, 100.00);

SELECT * FROM Students;
SELECT * FROM Enrollments;
SELECT * FROM Courses;
SELECT * FROM Instructors;

