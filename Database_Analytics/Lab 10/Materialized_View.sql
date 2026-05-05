-- Andrianna Wardill (041067235)
-- Materialized View
use CollegeDB;

-- Create the view
create view mv_StudentCourseDetails
with SCHEMABINDING
as
select 
	s.StudentID,
	s.FirstName + ' ' + s.LastName as student_full_name,
	s.EnrollmentYear
from dbo.Students s
where s.EnrollmentYear > 2021;

-- Materialize the view
create unique clustered index idex_StudentCourseDetails
on mv_StudentCourseDetails(StudentID);

select *
from mv_StudentCourseDetails;

-- insert a new record
INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES (5, 'Andrianna', 'Wardill', 'Data Science', 2026);

-- check the materialized view
select *
from mv_StudentCourseDetails;