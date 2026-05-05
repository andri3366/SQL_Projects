-- Joins
use lab9;

--Task 1: Basic Inner Join
--Write a query to list all enrollments showing student full name, section ID, and grade.
--Expected columns: StudentID, StudentName, SectionID, Grade.
select 
	sn.StudentID,
	sn.StudentName,
	e.SectionID,
	e.Grade
from dbo.Enrollments e
inner join student_name sn on e.StudentID = sn.StudentID;

--Task 2: Join Across Multiple Tables
--Write a query to show which students are enrolled in which course titles. Join Students,
--Enrollments, Sections, and Courses. Expected columns: StudentName, CourseCode,
--CourseTitle, Semester, YearOffered.

select 
	sn.StudentName,
	c.CourseCode,
	c.CourseTitle,
	s.Semester,
	s.YearOffered
from dbo.Courses c
join dbo.Sections s on c.CourseID = s.CourseID
join dbo.Enrollments e on s.SectionID = e.SectionID
join student_name sn on e.StudentID = sn.StudentID
order by sn.StudentID;

--Task 3: Join with Department Lookup
--List all students and their major department name. Include students even if they do not yet
--have a major. Expected columns: StudentID, StudentName, DepartmentName.
select 
	sn.StudentID,
	sn.StudentName,
	d.DepartmentName
from dbo.Departments d
full outer join student_name sn on d.DepartmentID = sn.MajorDepartmentID

--Task 4: Left Join to Find Missing Relationships
--Find all course sections that do not yet have an instructor assigned. Expected columns:
--SectionID, CourseTitle, Semester, YearOffered.
select 
	s.SectionID,
	-- i.InstructorID,
	c.CourseTitle,
	s.Semester,
	s.YearOffered
from 
	dbo.Sections s
left join dbo.Instructors i on s.InstructorID = i.InstructorID
join dbo.Courses c on s.CourseID = c.CourseID 
where 
	i.InstructorID is Null;

--Task 5: Multi-Join Reporting Query
--Create a report showing course title, section ID, instructor name, and number of enrolled
--students. Include sections with zero students. Expected columns: CourseTitle, SectionID,
--InstructorName, StudentCount.

select
	c.CourseTitle,
	s.SectionID,
	i.InstructorName,
	count(e.StudentID) as StudentCount
from dbo.Enrollments e
-- Get all sections even if a student is not assigned
full outer join dbo.Sections s on e.SectionID = s.SectionID
-- Get the student count even if the instructor is not assigned
full outer join instructor_name i on s.InstructorID = i.InstructorID
join dbo.Courses c on s.CourseID = c.CourseID
group by s.SectionID, c.CourseTitle, i.InstructorName;

--Task 6: Self-Join
--Using a self-join on Students, find pairs of students in the same major department. Do not
--pair a student with themselves and do not show duplicate reversed pairs. Expected columns:
--Student1, Student2, MajorDepartmentID.

select
	s1.StudentName as Student1,
	s2.StudentName as Student2,
	s1.MajorDepartmentID
from student_name s1
join student_name s2
	on s1.MajorDepartmentID <> s2.MajorDepartmentID
	and s1.MajorDepartmentID < s2.MajorDepartmentID
order by s1.MajorDepartmentID, s1.StudentName, s2.StudentName

--Task 7: Many-to-Many Join Analysis
--Find all instructors and the courses they teach using Instructors, Sections, and Courses.
--Expected columns: InstructorName, CourseCode, CourseTitle, Semester, YearOffered.

select
	i.InstructorName,
	c.CourseCode,
	c.CourseTitle,
	s.Semester,
	s.YearOffered
from instructor_name i
join dbo.Sections s on i.InstructorID = s.InstructorID
join dbo.Courses c on s.CourseID = c.CourseID
order by c.CourseID;

--Task 8: Advanced Join with Aggregation
--Find the number of students enrolled in each department’s courses. This is based on the
--department that owns the course, not the student major. Expected columns:
--DepartmentName, TotalEnrollments.
select 
	d.DepartmentName,
	count(e.StudentID) as TotalEnrollments
from dbo.Enrollments e
join dbo.Students s on e.StudentID = s.StudentID
join dbo.Departments d on s.MajorDepartmentID = d.DepartmentID
group by d.DepartmentName;
-- if you wanted to not include the multiple enrollments for students
select 
	d.DepartmentName,
	count(s.StudentID) as TotalEnrollments
from dbo.Students s
join dbo.Departments d on s.MajorDepartmentID = d.DepartmentID
group by d.DepartmentName;

--Task 9: Students Without Enrollments
--Write a query to find students who are not enrolled in any section. Expected columns:
--StudentID, StudentName.
select
	sn.StudentID,
	sn.StudentName
from student_name sn
join dbo.Enrollments e on sn.StudentID = e.StudentID
join dbo.Sections s on e.SectionID =  s.SectionID
where 
	sn.StudentID <> e.StudentID
	and e.SectionID <> s.SectionID;

--Task 10: Advanced Challenge
--Find students who are taking a course outside their major department. For each enrollment,
--compare the student’s major department and the course’s department. Ignore students with
--no declared major. Expected columns: StudentName, MajorDepartment, CourseCode,
--CourseTitle, CourseDepartment.
select
	sn.StudentName,
	ds.DepartmentName as MajorDepartment,
	c.CourseCode,
	c.CourseTitle,
	dc.DepartmentName as CourseDepartment
from dbo.Courses c
join dbo.Sections s on c.CourseID = s.CourseID
join dbo.Enrollments e on s.SectionID = e.SectionID
join student_name sn on e.StudentID = sn.StudentID
join dbo.Departments ds on sn.MajorDepartmentID = ds.DepartmentID
join dbo.Departments dc on c.DepartmentID = dc.DepartmentID
where
	sn.MajorDepartmentID is not null
	and sn.MajorDepartmentID <> c.DepartmentID
order by sn.StudentID;

--Extension Challenge A
--Show all pairs of instructors and students that belong to the same department. Expected
--columns: InstructorName, StudentName, DepartmentName.
select
	i.InstructorName,
	sn.StudentName,
	d.DepartmentName
from student_name sn
join dbo.Departments d on sn.MajorDepartmentID = d.DepartmentID
join instructor_name i on d.DepartmentID = i.DepartmentID
where
	sn.MajorDepartmentID = i.DepartmentID
order by d.DepartmentName, i.InstructorID, sn.StudentID;

--Extension Challenge B
--Find the course with the highest number of enrollments.
select
	c.CourseID,
	c.CourseTitle,
	count(s.SectionID) as NumOfEnrollments
from dbo.Courses c
join dbo.Sections s on c.CourseID = s.CourseID
join dbo.Enrollments e on s.SectionID = e.SectionID
group by c.CourseTitle, c.CourseID
order by NumOfEnrollments desc, c.CourseID;

--Extension Challenge C
--Show all students, and for each student display total courses taken and average numeric
--grade using this mapping: A = 4.0, A- = 3.7, B+ = 3.3, B = 3.0.
select
	sn.StudentID,
	sn.StudentName,
	count(s.CourseID) as TotalCourses,
	cast(
		AVG(
			case
				when e.Grade = 'A' then 4.0
				when e.Grade = 'A-' then 3.7
				when e.Grade = 'B+' then 3.3
				when e.Grade = 'B' then 3.0
				else NULL
			end 
		) as decimal(4,2)
	) as AverageGrade
from student_name sn
join dbo.Enrollments e on sn.StudentID = e.StudentID
join dbo.Sections s on e.SectionID = s.SectionID
group by sn.StudentID, sn.StudentName
order by sn.StudentID;

--Extension Challenge D
--Find departments that currently have courses offered but no students majoring in them.

select
	sn.StudentName,
	c.CourseCode,
	c.CourseTitle,
	d.DepartmentName as CourseDepartment
-- to include null majors start from students table
from student_name sn
join dbo.Enrollments e on sn.StudentID = e.StudentID
join dbo.Sections s on e.SectionID = s.SectionID
join dbo.Courses c on s.CourseID = c.CourseID
join dbo.Departments d on c.DepartmentID = d.DepartmentID
where
	sn.MajorDepartmentID <> c.DepartmentID
	or sn.MajorDepartmentID is null
order by sn.StudentID;