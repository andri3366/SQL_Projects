-- Who are the most valuable customers?
WITH customer_ltv AS (
SELECT
	customerkey,
	cleaned_name,
	SUM(total_net_revenue) AS total_ltv

FROM cohort_analysis
GROUP BY customerkey,
	cleaned_name
ORDER BY 
	customerkey 
), customer_segments AS (
	SELECT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS perc_25,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS perc_75
	FROM customer_ltv
),
segement_values AS (
    SELECT
        c.customerkey,
        c.total_ltv,
        CASE
            WHEN c.total_ltv < perc_25 THEN '1 - Low-Value'
            WHEN c.total_ltv BETWEEN perc_25 AND perc_75 THEN '2 - Mid-Value'
            ELSE '3 - High-Value'
        END AS customer_segment
    FROM customer_ltv c,
    customer_segments cs
)

SELECT
    customer_segment,
    SUM(total_ltv) AS total_ltv,
    SUM(total_ltv) / (SELECT SUM(total_ltv) FROM segement_values) AS ltv_percentage,
    COUNT(customerkey) AS customer_count,
    SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM segement_values
GROUP BY customer_segment
ORDER BY total_ltv DESC