-- Which customers haven't purchased recently?
WITH last_purchase AS (
	SELECT 
		customerkey,
		cleaned_name, 
		orderdate,
		ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
		first_purchase,
		cohort_year 
	FROM cohort_analysis 
),
churn AS (
	SELECT 
		customerkey,
		cleaned_name,
		first_purchase,
		orderdate AS last_purcahse_date,
		CASE
			WHEN
				orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
			ELSE
				'Active'
		END AS customer_status,
		cohort_year
		
	FROM last_purchase 
	WHERE
		rn = 1 AND
		first_purchase < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)

SELECT 
	cohort_year,
	customer_status,
	COUNT(customerkey) AS num_customers,
	SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year ) AS total_customers,
	ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year), 2) AS total_percentage
FROM 
	churn 
GROUP BY 
	cohort_year,
	customer_status
ORDER BY
	cohort_year,
	customer_status 