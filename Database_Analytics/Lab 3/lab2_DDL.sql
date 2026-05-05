/*
Lab2-CST2102
This university course management database is designed to track and manage student enrollments, courses, instructors, and academic performance. It contains four key entities: Students, Courses, Instructors, and Enrollments. The Student table stores basic student details like ID, name, date of birth, and email, while the Instructor table keeps track of instructors and their department affiliations. The Course table records information about each course, including its name, credit hours, and assigned instructor. The Enrollment table serves as an associative entity, capturing the many-to-many relationship between students and courses by logging which students are enrolled in which courses, along with the grades they have received. This structure allows for efficient querying of data, such as determining course enrollments, instructor assignments, and student performance.

*/


-- Create the database
CREATE DATABASE UniversityCourseManagement;

-- Use the database
USE UniversityCourseManagement;

-- Create the Student table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Date_of_Birth DATE,
    Email VARCHAR(100)
);

-- Create the Course table
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Credit_Hours INT
);

-- Create the Instructor table
CREATE TABLE Instructor (
    Instructor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Office_Location VARCHAR(100),
    Department VARCHAR(100)
);

-- Create the Enrollment table (Associative Entity)
CREATE TABLE Enrollment (
    Student_ID INT,
    Course_ID INT,
    Grade VARCHAR(2),
    PRIMARY KEY (Student_ID, Course_ID),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- Add a relationship between Instructor and Course
ALTER TABLE Course
ADD Instructor_ID INT,
ADD FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID);
