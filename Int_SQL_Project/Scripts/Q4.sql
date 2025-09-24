-- Which regions not only spend the most per order but also have the highest repeat purchase rates?
WITH order_region AS (
SELECT 
	customerkey,
	countryfull,
	count(DISTINCT orderkey) AS num_orders,
	SUM(total_net_revenue) AS total_net_revenue
FROM cohort_analysis
GROUP BY countryfull, customerkey
),

region_rates AS (
	SELECT 
		countryfull,
		SUM(total_net_revenue)::numeric / COUNT(customerkey) AS avg_value_per_cust,
		SUM(total_net_revenue)::numeric / SUM(num_orders) AS avg_order_value,
		SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) AS repeat_cust,
		COUNT(customerkey) AS total_cust
	FROM order_region
	GROUP BY countryfull
)

SELECT 
	countryfull,
	ROUND(avg_order_value, 2) AS avg_order_value,
	ROUND(100 * repeat_cust / total_cust, 2) AS repeat_purchase_rate,
	ROUND(avg_value_per_cust, 2) AS avg_value_per_cust 
FROM region_rates
ORDER BY repeat_purchase_rate DESC, avg_order_value DESC
