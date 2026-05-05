create view instructor_name as
select 
	i.InstructorID,
	i.FirstName + ' ' + i.LastName as InstructorName,
	i.DepartmentID,
	i.HireDate
from dbo.Instructors i;