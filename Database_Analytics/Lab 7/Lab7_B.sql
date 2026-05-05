Use Lab7_B;

-- Question 1 (B): List all employees along with their respective departments
Select *
From employees;

Select * 
From departments;

Select
	e.first_name,
	e.last_name,
	d.department_name
From employees e
Join departments d on e.department_id = d.department_id;

-- Question 2 (B): 
/*
Retrieve a list of all department managers along with the names of 
the departments they manage
*/

Select *
From employees;

Select * 
From departments;

Select 
    d.department_name,
    e.first_name,
    e.last_name
From departments d
Join employees e on d.manager_id = e.employee_id;

Select 
	e.first_name,
	e.last_name,
	d.department_name,
	e.position
From employees e
Join departments d on e.department_id = d.department_id
Where e.position like '%Manager%';

-- Question 3 (B): Identify employees who hold the same position in different departments
Select *
From employees;

Select * 
From departments;

Select 
	e1.first_name + ' ' + e1.last_name as emp1,
	e1.position,
    d1.department_name,
	e2.first_name + ' ' + e2.last_name as emp2,
	e2.position,
    d2.department_name
From employees e1
JOIN employees e2 
    on 
    case 
        when CHARINDEX(' ', REVERSE(e1.position)) = 0 
            then e1.position
        else RIGHT(e1.position, CHARINDEX(' ', REVERSE(e1.position)) - 1)
    end
    =
    case 
        when CHARINDEX(' ', REVERSE(e2.position)) = 0 
            then e2.position
        else RIGHT(e2.position, CHARINDEX(' ', REVERSE(e2.position)) - 1)
    end
    and e1.department_id <> e2.department_id
    and e1.employee_id < e2.employee_id
Join departments d1 on e1.department_id = d1.department_id
Join departments d2 on e2.department_id = d2.department_id

-- Question 4 (B):
/*
Find a list of employees and their respective departments.
This information can help managers view which employees are associated with each department.
*/
Select
    e.first_name,
    e.last_name,
    d.department_name
From employees e
Join departments d on e.department_id = d.department_id;
