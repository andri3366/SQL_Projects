if not exists(
	select *
	from sys.server_principals
	where name = 'AdminUser'
)
create login AdminUser with password = 'Admin1!';

if not exists(
	select *
	from sys.server_principals
	where name = 'ViewerUser'
)
create login ViewerUser with password = 'Viewer1!';

use CST2102_UserAccessControl;

-- Check for admin and viewer user

if not exists (
	select * 
	from sys.database_principals 
	where name = 'AdminUser'
	)
create user AdminUser for login AdminUser;

if not exists (
	select * 
	from sys.database_principals 
	where name = 'ViewerUser'
	)
create user ViewerUser for login ViewerUser;

-- Check for admin or viewer role
if not exists(
	Select *
	From sys.database_principals
	Where name = 'admin_role' and type = 'R'
	)
create role admin_role;

if not exists(
	Select *
	From sys.database_principals
	Where name = 'viewer_role' and type = 'R'
	)
create role viewer_role;

-- grant privileges to admin_role
grant select, insert, update, delete on Students to admin_role;
grant select, insert, delete on Enrollments to admin_role;
grant select on Courses to admin_role;

-- grant privileges to viewer_role
grant select on Students to viewer_role;
grant select on Courses to viewer_role;

-- add users to roles
alter role admin_role add member AdminUser;
alter role viewer_role add member ViewerUser;

-- verify creation
select name, type_desc
from sys.database_principals
where name in ('AdminUser', 'ViewerUser');

select name, type_desc, is_disabled
from sys.server_principals
where name in ('AdminUser', 'ViewerUser');

SELECT sp.name AS LoginName, dp.name AS DatabaseUser
FROM sys.server_principals sp
LEFT JOIN sys.database_principals dp
ON sp.sid = dp.sid
WHERE sp.name IN ('ViewerUser','AdminUser');