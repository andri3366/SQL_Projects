use Lab7_B;

create table employees (
	employee_id int primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null, 
	department_id int not null,
	position varchar(50) not null,
	email varchar(50) not null
);
-- Insert sample data into Employees table
INSERT INTO employees (employee_id, first_name, last_name, department_id, position, email) VALUES
(1, 'John', 'Doe', 1, 'Sales Manager', 'johndoe@example.com'),
(2, 'Jane', 'Smith', 2, 'Marketing Specialist', 'janesmith@example.com'),
(3, 'Robert', 'Brown', 3, 'HR Coordinator', 'robertbrown@example.com'),
(4, 'Emily', 'Davis', 4, 'IT Support', 'emilydavis@example.com'),
(5, 'Michael', 'Wilson', 5, 'Accountant', 'michaelwilson@example.com'),
(6, 'Sarah', 'Miller', 6, 'Operations Lead', 'sarahmiller@example.com'),
(7, 'David', 'Clark', 7, 'Logistics Coordinator', 'davidclark@example.com'),
(8, 'Jessica', 'Taylor', 8, 'Product Manager', 'jessicataylor@example.com'),
(9, 'Daniel', 'Martinez', 9, 'Support Specialist', 'danielmartinez@example.com'),
(10, 'Laura', 'White', 10, 'Legal Advisor', 'laurawhite@example.com');

use Lab7_B;

create table departments (
	department_id int primary key,
	department_name varchar(50) not null,
	manager_id int null
);

-- Insert sample data into Departments table
INSERT INTO departments (department_id, department_name, manager_id) VALUES
(1, 'Sales', NULL),
(2, 'Marketing', NULL),
(3, 'HR', NULL),
(4, 'IT', NULL),
(5, 'Finance', NULL),
(6, 'Operations', NULL),
(7, 'Logistics', NULL),
(8, 'Product Development', NULL),
(9, 'Support', NULL),
(10, 'Legal', NULL);

-- Update departments table to set manager_id after employees are inserted
UPDATE departments SET manager_id = 1 WHERE department_id = 1;
UPDATE departments SET manager_id = 2 WHERE department_id = 2;
UPDATE departments SET manager_id = 3 WHERE department_id = 3;
UPDATE departments SET manager_id = 4 WHERE department_id = 4;
UPDATE departments SET manager_id = 5 WHERE department_id = 5;
UPDATE departments SET manager_id = 6 WHERE department_id = 6;
UPDATE departments SET manager_id = 7 WHERE department_id = 7;
UPDATE departments SET manager_id = 8 WHERE department_id = 8;
UPDATE departments SET manager_id = 9 WHERE department_id = 9;
UPDATE departments SET manager_id = 10 WHERE department_id = 10;

alter table employees
add constraint fk_department
foreign key (department_id) references departments(department_id);

use Lab7_B;

create table customers (
	customer_id int primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(50) not null,
	phone varchar(20)
);

-- Insert sample data into Customers table
INSERT INTO customers (customer_id, first_name, last_name, email, phone) VALUES
(1, 'Alice', 'Johnson', 'alicejohnson@example.com', '555-0101'),
(2, 'Tom', 'Wright', 'tomwright@example.com', '555-0102'),
(3, 'Emma', 'King', 'emmaking@example.com', '555-0103'),
(4, 'Oliver', 'Lee', 'oliverlee@example.com', '555-0104'),
(5, 'Sophia', 'Baker', 'sophiabaker@example.com', '555-0105'),
(6, 'Liam', 'Adams', 'liamadams@example.com', '555-0106'),
(7, 'Mia', 'Carter', 'miacarter@example.com', '555-0107'),
(8, 'Noah', 'Evans', 'noahevans@example.com', '555-0108'),
(9, 'Ava', 'Hill', 'avahill@example.com', '555-0109'),
(10, 'Lucas', 'Scott', 'lucasscott@example.com', '555-0110');

use Lab7_B;

create table products (
	product_id int primary key,
	product_name varchar(50) not null,
	description varchar(100) not null,
	price decimal(10,2) not null,
	stock_qty int not null
);

-- Insert sample data into Products table
INSERT INTO products (product_id, product_name, description, price, stock_qty) VALUES
(1, 'Laptop', 'High-performance laptop', 1200.00, 50),
(2, 'Smartphone', 'Latest model smartphone', 800.00, 150),
(3, 'Tablet', 'Portable tablet', 400.00, 100),
(4, 'Monitor', '27-inch HD monitor', 300.00, 75),
(5, 'Keyboard', 'Mechanical keyboard', 100.00, 200),
(6, 'Mouse', 'Wireless mouse', 50.00, 250),
(7, 'Printer', 'All-in-one printer', 250.00, 40),
(8, 'Headphones', 'Noise-canceling headphones', 150.00, 120),
(9, 'Webcam', 'HD webcam', 80.00, 90),
(10, 'External Hard Drive', '1TB external hard drive', 150.00, 60);

use Lab7_B;

create table orders(
	order_id int primary key,
	customer_id int not null,
	order_date date not null,
	total_amount decimal(10,2) not null,
	foreign key (customer_id) references customers(customer_id)
);

-- Insert sample data into Orders table
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-01-15', 1250.00),
(2, 2, '2024-01-16', 950.00),
(3, 3, '2024-01-17', 450.00),
(4, 4, '2024-01-18', 300.00),
(5, 5, '2024-01-19', 1300.00),
(6, 6, '2024-01-20', 750.00),
(7, 7, '2024-01-21', 400.00),
(8, 8, '2024-01-22', 200.00),
(9, 9, '2024-01-23', 1150.00),
(10, 10, '2024-01-24', 850.00);

use Lab7_B;

create table order_details(
	primary key (order_id, product_id),
	order_id int not null,
	product_id int not null,
	quantity int not null,
	price decimal(10,2) not null,
	foreign key (order_id) references orders(order_id),
	foreign key (product_id) references products(product_id)
);

-- Insert sample data into Order Details table
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(1, 5, 1, 50.00),
(2, 2, 1, 800.00),
(2, 6, 3, 150.00),
(3, 3, 1, 400.00),
(3, 8, 1, 50.00),
(4, 4, 1, 300.00),
(5, 1, 1, 1200.00),
(5, 7, 2, 100.00),
(6, 9, 5, 250.00),
(7, 3, 1, 400.00),
(8, 10, 2, 300.00),
(9, 2, 1, 800.00),
(9, 6, 2, 100.00),
(10, 4, 1, 300.00);