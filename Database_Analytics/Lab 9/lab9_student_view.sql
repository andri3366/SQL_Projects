create view student_name as
select 
	s.StudentID,
	s.FirstName + ' ' + s.LastName as StudentName,
	s.MajorDepartmentID,
	s.EnrollmentYear,
	s.Email
from dbo.Students s