Use Lab7_B;

Select *
From customers;

Select *
From orders;

-- Question 1 (A)
/* 
Who are the customers whose order total is 
above the average order total of all orders?
*/
Select 
	c.customer_id,
	c.first_name,
	c.last_name,
	Count(o.customer_id) as order_total
From customers c
Join orders o on c.customer_id = o.customer_id
Group By c.customer_id, c.first_name, c.last_name
Having Count(o.order_id) > (
	Select AVG(order_count)
	From (
		Select Count(order_id) as order_count
		From orders
		Group By customer_id
	) as t
)
Order By order_total desc;

-- Question 2 (A)
/* 
Which products have been ordered by more than 
1 distinct customers?
*/

Select *
From products;

Select * 
From orders;

Select *
From order_details;

Select 
	p.product_name,
	Count(Distinct o.customer_id) as customer_count
From products p
join order_details od on p.product_id = od.product_id
join orders o on od.product_id = o.order_id
Group by p.product_name
Having COUNT( Distinct o.customer_id) > 1
Order by customer_count desc;

-- Question 3 (A)
/*
Who are the customers who have never placed an order
*/
select *
From customers;

Select 
    c.customer_id,
    c.first_name,
    c.last_name
From customers c
Where c.customer_id NOT IN (
    Select distinct customer_id
    From orders
);

-- Question 4 (A)
/*
Which customers have placed orders for a specific product
*/
Select 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(*) as order_total
From customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
Where od.product_id = 1 
group by c.customer_id, c.first_name, c.last_name;

-- Question 5 (A)
/*
Which products have never been ordered?
*/
Select 
    p.product_id,
    p.product_name
From products p
Where p.product_id not in (
    Select distinct product_id
    From order_details
);