USE UniversityCourseManagement;

-- Insert sample students
INSERT INTO Student (Student_ID, Name, Date_of_Birth, Email) VALUES
(1, 'Alice Johnson', '2000-01-15', 'alice.johnson@example.com'),
(2, 'Bob Smith', '1999-05-21', 'bob.smith@example.com'),
(3, 'Charlie Brown', '2001-09-08', 'charlie.brown@example.com'),
(4, 'Diana Prince', '2000-03-30', 'diana.prince@example.com'),
(5, 'Eve Adams', '2000-11-12', 'eve.adams@example.com'),
-- Add student Frank Miller
(6, 'Frank Miller', '2001-12-22', 'frank.miller@example.com');

-- Insert sample instructors
INSERT INTO Instructor (Instructor_ID, Name, Office_Location, Department) VALUES
(1, 'Dr. Alan Turing', 'Room 101', 'Computer Science'),
(2, 'Dr. Ada Lovelace', 'Room 102', 'Computer Science'),
(3, 'Dr. John von Neumann', 'Room 103', 'Engineering'),
(4, 'Dr. Grace Hopper', 'Room 104', 'Mathematics'),
(5, 'Dr. Donald Knuth', 'Room 105', 'Computer Science');

-- Insert sample courses with associated Instructor_ID values
INSERT INTO Course (Course_ID, Course_Name, Credit_Hours, Instructor_ID) VALUES
(101, 'Database Design', 3, 1),
(102, 'Introduction to Programming', 4, 2),
(103, 'Data Structures', 3, 2),
(104, 'Operating Systems', 3, 3),
(105, 'Artificial Intelligence', 4, 4),
-- Add Computer Networks course
(106, 'Computer Networks', 3, 5);

-- Insert sample enrollments (relationships between students and courses)
INSERT INTO Enrollment (Student_ID, Course_ID, Grade) VALUES
(1, 101, 'A'),
(1, 102, 'B'),
(2, 103, 'A'),
(2, 104, 'C'),
(3, 101, 'B'),
(3, 105, 'A'),
(4, 102, 'A'),
-- Add Diana Prince grade
(4, 101, 'A'),
(4, 103, 'B'),
(5, 104, 'A'),
(5, 105, 'B');

SELECT * FROM Student;
SELECT * FROM Enrollment;
SELECT * FROM Course;
SELECT * FROM Instructor;