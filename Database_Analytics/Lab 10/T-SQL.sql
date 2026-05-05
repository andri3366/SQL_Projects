-- Andrianna Wardill (041067235)
-- T-SQL example query
-- My T-SQL query is below
use CollegeDB;

CREATE TABLE GradeChangeLog (
	LogID INT IDENTITY PRIMARY KEY, -- Auto-incrementing primary key
	StudentID INT NOT NULL, -- Foreign key to Students (optional constraint can be added)
	CourseID INT NOT NULL, -- Foreign key to Courses (optional constraint can be added)
	OldGrade CHAR(1), -- The old grade value
	NewGrade CHAR(1), -- The new grade value
	ChangedOn DATETIME DEFAULT GETDATE() -- Timestamp of the change
);

-- Run provided t-sql
--- Transaction
BEGIN TRANSACTION;
BEGIN TRY
-- Declare variables for the old grade
DECLARE @OldGrade CHAR(1);
-- Fetch the current grade
SELECT @OldGrade = Grade
FROM Enrollments
WHERE StudentID = 1 AND CourseID = 101;
-- If no record is found, throw an error
IF @OldGrade IS NULL
THROW 50001, 'No matching record found for StudentID and CourseID.', 1;
-- Update the grade
UPDATE Enrollments
SET Grade = 'B'
WHERE StudentID = 1 AND CourseID = 101;
-- Log the grade change
INSERT INTO GradeChangeLog (StudentID, CourseID, OldGrade, NewGrade,
ChangedOn)
VALUES (1, 101, @OldGrade, 'B', GETDATE());
-- Commit the transaction
COMMIT TRANSACTION;
PRINT 'Grade updated successfully.';
END TRY
BEGIN CATCH
-- Rollback the transaction in case of an error
ROLLBACK TRANSACTION;
PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;

select *
from dbo.GradeChangeLog;

-------------------------
-- My t-sql transaction
begin transaction;
begin try

-- insert a new record
INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES (6, 'Anna', 'Smith', 'Business', 2026);

INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES (7, 'Lola', 'Verd', 'Arts', 2025);

INSERT INTO Students (StudentID, FirstName, LastName, Major, EnrollmentYear)
VALUES (8, 'Melissa', 'King', 'Bio Chemistry', 2022);

commit transaction;
print 'Students inserted';
end try

begin catch
rollback transaction;
print 'Error occured: ' + ERROR_MESSAGE();
end catch;

select *
from dbo.Students;