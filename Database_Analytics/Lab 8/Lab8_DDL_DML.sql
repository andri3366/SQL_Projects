create database CST2102_UserAccessControl;

use CST2102_UserAccessControl;

create table Students(
	student_id int primary key,
	name varchar(15),
	major varchar(30),
	enrollment_year int 
);
-- Insert sample data into Students table
INSERT INTO Students (student_id, name, major, enrollment_year) VALUES
(1, 'Alice Johnson', 'Computer Science', 2020),
(2, 'Bob Smith', 'Electrical Engineering', 2019),
(3, 'Carol White', 'Mechanical Engineering', 2021);

create table Courses(
	course_id int primary key,
	course_name varchar(50),
	credits int
);
-- Insert sample data into Courses table
INSERT INTO Courses (course_id, course_name, credits) VALUES
(101, 'Calculus', 4),
(102, 'Introduction to Programming', 3),
(103, 'Physics', 4);

create table Enrollments(
	enrollment_id int primary key,
	student_id int not null,
	course_id int not null,
	grade varchar(2),
	foreign key (student_id) references Students(student_id),
	foreign key (course_id) references Courses(course_id)
);
-- Insert sample data into Enrollments table
INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 101, 'A'),
(2, 1, 102, 'B'),
(3, 2, 103, 'A');
