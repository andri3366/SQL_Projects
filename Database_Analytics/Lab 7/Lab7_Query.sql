Use SampleDB;

Select *
From dbo.Orders$;

Select *
From dbo.People$;

Select * 
From dbo.Returns$;

-- Question 1 (A)
/* 
Who are the customers whose order total is 
above the average order total of all orders?
*/
Select 
	"Customer ID",
	"Customer Name",
	Count("Customer ID") as order_total
From dbo.Orders$
Group By "Customer ID", "Customer Name"
Having Count("Customer ID") > (
	Select AVG(order_count)
	From (
		Select Count("Customer ID") as order_count
		From dbo.Orders$
		Group By "Customer ID"
	) as t
)
Order By order_total desc;

-- Question 2 (A)
/* 
Which products have been ordered by more than 
1 distinct customers?
*/
Select 
	"Product Name",
	Count(Distinct "Customer ID") as customer_count
From dbo.Orders$
Group by "Product Name"
Having COUNT( Distinct "Customer ID") > 1
Order by customer_count desc;

-- Question 3 (A)
/*
Who are the customers who have never placed an order
*/
Select 
	"Customer ID",
	"Customer Name"
From dbo.Orders$
Where "Customer ID" Not In (
	Select distinct "Customer ID"
	From dbo.Orders$
);

-- Question 4 (A)
/*
Which customers have placed orders for a specific product
*/
Select 
	"Customer ID",
	"Customer Name",
	Count("Customer ID") as order_total
From dbo.Orders$
Where "Product ID" = 'OFF-AP-10000696'
Group by "Customer ID", "Customer Name";

-- Question 5 (A)
/*
Which products have never been ordered?
*/
Select 
	"Product ID",
	"Product Name"
From dbo.Orders$
Where "Product ID" Not In (
	Select distinct "Product ID"
	From dbo.Orders$
);