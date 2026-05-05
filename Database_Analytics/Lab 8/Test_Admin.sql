select SUSER_NAME()

use CST2102_UserAccessControl;

INSERT INTO Students (student_id, name, major, enrollment_year) VALUES
(5, 'John Doe', 'Computer Science', 2017);

select *
from Students;