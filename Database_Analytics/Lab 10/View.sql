-- Andrianna Wardill (041067235)
-- View
use CollegeDB;

create view v_StudentCourseDetails as
select
	s.StudentID,
	s.FirstName + ' ' + s.LastName as student_full_name,
	c.CourseName,
	e.Grade
from dbo.Students s
join dbo.Enrollments e on s.StudentID = e.StudentID
join dbo.Courses c on e.CourseID = c.CourseID;

-- Query the view
select 
	*
from dbo.v_StudentCourseDetails;

-- Insert new records
INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES (4, 'Bob', 'Williams', 'Chemistry', 2020);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade)
VALUES (4, 4, 103, 'D');

-- Query the view
-- Yes, you can see the new records
select 
	*
from dbo.v_StudentCourseDetails;