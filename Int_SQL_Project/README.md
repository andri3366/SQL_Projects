# SQL Sales Analysis Project
## Overview
This project explores and analyzes sales data using SQL to answer key business questions based on customer segmentation, cohort analysis, and retention.

This projects analysis was inspired by Luke Barousse's SQL course on YouTube [YouTube](https://www.youtube.com/watch?v=QKIGsShyEsQ), with an additional self-designed question that combines multiple customer metrics.

## The Dataset
The dataset, called [contoso_100k](https://github.com/lukebarousse/Int_SQL_Data_Analytics_Course/releases/tag/v.0.0.0), was used to simulate real-world sales transactions using the following tables:
- currencyyearexchange
- customer
- date
- product
- sales
- store

## Tools Used
- **PostgreSQL** - SQL queries and analysis
- **DBeaver** - query execution and visualization
- **GitHub** - project documentation and version control
- **VS Code** - visualization

## Data Cleaning

## Analysis
1. Who are the most valuable customers?
- **Purpose:** Determine which customers generate the most revenue based on their lifetime value (ltv) to allow for targeted marketing and resource prioritization.
- **Techniques:**
    - CTE to calculate each customer's total lifetime value (quantity * netprice * exchangerate)
    ```
    SUM(total_net_revenue) AS total_ltv
    ```
    - Use percentiles to classify customers into low, mid, and high-value segments
    ```
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS perc_25,
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS perc_75
    ```
    ```
    CASE
        WHEN c.total_ltv < perc_25 THEN '1 - Low-Value'
        WHEN c.total_ltv BETWEEN perc_25 AND perc_75 THEN '2 - Mid-Value'
        ELSE '3 - High-Value'
    END AS customer_segment
    ```
    - Compare revenue contribution across each segment
    - **photo**
- **Interpretation:** A small group of high-value customers from 25% of customers generates the majority of total sales ($135.4M), this roughly conforms with the Pareto principle. These High-Value customers provide a significant impact on the companies revenue, thereby, it is important appease to the 12,372 High-Value customers. 
-**Business Potential:**
    - Protect the high-value customers by offering loyalty programs, perks, or priority support to keep them engaged
    - Grow mid-value customers by personalized promotions and targeted up-selling to help some customers move into the high-value tier
    - Re-engage the low-value customers through lightweight campaigns to increase order frequency

2. How do different customer groups generate revenue?
- **Purpose:** Provide a cohort analysis to evaluate how customer acquisition varies over time. The company can use this to measure how many new customers were gained each year and how much revenue they contribute. 
- **Techniques:**
    - Assign each customer to a cohort based on their first purchase date
    - Aggregate total customers, revenue, and customer revenue for each cohort year
    - **photo**
- **Interpretation:** Reveals the company grew has grown its customer base from 2015 to 2022 before declining in 2023 and 2024. While the customer count rose in 2018 to 2022, the average revenue per customer declined over time. This reveals the business is bringing in more customers gradually since 2022, but each customer is spending less on average. 
-**Business Potential:**
    - Investigate the peak years, 2018 to 2019, to understand what conditions led to strong growth and how to re-implicate those strategies for the upcoming years
    - Address the recent decline in 2023 to 2024 by refining market channels with personalized re-engagement offers to reduce churn

3. Which customers haven't purchased recently?
- **Purpose:** Identify customers who are at risk of churning so the business can focus on re-engagement strategies, as retaining customers is often more cost-effective than acquiring new ones.
- **Techniques:**
    - Used a CTE to order each customer based on their most recent purchase, with ROW_NUMBER() to flag the most recent purchase as 1
    ```
    ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS rn
    ```
    - Assign a churn rule (6 months from the current date)
    - Classify each customer as Active or Churned
        - **Note:** MAX(orderdate) is used as the most recent purchase date, as the dataset is static and not a live database
    ```
    CASE
		WHEN
			orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
		ELSE
			'Active'
	END AS customer_status
    ```
    - Use a window function to calculate the total per cohort and determine what percentage of each cohort is Active Vs. Churned
    ```
    COUNT(customerkey) AS num_customers,
	SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year ) AS total_customers,
	ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER (PARTITION BY cohort_year), 2) AS total_percentage
    ```
    - **photo**
- **Interpretation:** This allows businesses to quantify how much revenue is at rick from churned customers and whether retention strategies are needed. Based on the data ~90% of customers have churned, with only 8-10% remaining active across all cohorts. Even though the absolute number of active customers has increased in the newer cohorts, the pattern remains the same, meaning the company struggles with long-term retention.
- **Business Potential:**
    - Apply retention programs to keep the 8-10% active customers engaged
    - Improve newer customer experience so they stay longer and prevent potential churn 

4. Which regions not only spend the most per order but also have the highest repeat purchase rates?
- **Purpose:** Combine average order value (AOV) with repeat purchase rate (RPR) to identify which regions have the most high-value customers. 
- **Techniques:** 
    - Create a per-customer summary using a CTE to group customers by region and determine how many orders a customer has made and the total amount spent per customer
    - Calculate the average spending per customer in each region, average value per order, number of customers who have order more than once, and total customers in the region
        - **Note:** SUM(total_revenue) was returning a double precision and thereby causing issues when using the ROUND() function, to work around the issue the total_revenue was cast to a numeric
    ```
    region_rates AS (
	SELECT 
		countryfull,
		SUM(total_revenue)::numeric / COUNT(customerkey) AS avg_value_per_cust,
		SUM(total_revenue)::numeric / SUM(num_orders) AS avg_order_value,
		SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) AS repeat_cust,
		COUNT(customerkey) AS total_cust
	FROM order_region
	GROUP BY countryfull
    )
    
    ```
    - Use ROUND() to calculate the repeat purchase rate for each customer
    ```
    ROUND(100 * repeat_cust / total_cust, 2) AS repeat_purchase_rate,
    ```
- **Interpretation:** 
    - Canada and Australia have a high-value market as their customers are spending more per order and per customer
    - United States is reliable with the strongest repeat rate
    - Germany and Netherlands are solid middle ground with reasonable repeat purchase ratees but lower spending levels
    - France, Italy, and UK are underperforming with low spending per order and per customer
- **Business Potential:** 
    - Double down on high-value regions (Canada, Austalia) to maximize the return on investment (ROI)
    - The United States has the highest repeat purchase rate, making them ideal for up-selling higher margin products
    - Encourage volume discounts or bundles for the mid tier regions (Germany, Netherlands)
    - Target the underperforming regions (France, Italy, and UK) with localized marketing campaigns
