# Project Overview
Atliq Hardware, an innovative leader in computer hardware and peripherals, recognized the critical need for data-driven decisions. Initiating 𝟭𝟬 𝗮𝗱-𝗵𝗼𝗰 𝗿𝗲𝗾𝘂𝗲𝘀𝘁𝘀, they tasked the data analytics team. Leveraging 𝗦𝗤𝗟 𝗾𝘂𝗲𝗿𝗶𝗲𝘀, I meticulously tackled each request, unraveling invaluable insights for 𝗺𝗮𝗻𝗮𝗴𝗲𝗺𝗲𝗻𝘁.

* Video Presentation: [Click Here](https://youtu.be/Uf3cyl1ggTo?si=QozlI5oeoz6nlZnJ)
* LinkedIn Post: [Click Here](https://www.linkedin.com/posts/mohdakif919_codebasics-sql-mysql-activity-7161241946034757632-dKJG?utm_source=share&utm_medium=member_desktop)
* Challenge Link: [Click Here](https://codebasics.io/challenge/codebasics-resume-project-challenge)

# Key Takeaways
1. Gross Sales Performance:
   * India led in Asia Pacific, with notable contributions from South Korea, Indonesia, and Australia.
   * Retailer channel accounted for 73.22% of sales in 2021. Monthly trends at Atliq Exclusive revealed November as peak.

2. Segments Performance:
    * Atliq Hardware saw a surge in new products in 2021, especially in Accessories, indicating positive market response.

3. Quantity Sold:
    * Quarter 1 dominated sales, suggesting focus areas for marketing strategies.
    
4. Customer Dynamics:
    * Top customers received around 30% average discounts, maintaining competitive pricing and satisfaction.

# Ad-Hoc Requests
1. Provide the list of markets in which customer "Atliq Exclusive" operates its
business in the APAC region.
```sql
SELECT
	distinct(market)
FROM dim_customer
WHERE customer = "Atliq Exclusive" AND region = "APAC";
```
2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020,
unique_products_2021,
percentage_chg.
```sql
WITH unique_product_2020 AS (
	SELECT
		count(distinct(product_code)) as unique_products_2020
	FROM fact_sales_monthly s
    WHERE s.fiscal_year = 2020
),
unique_product_2021 AS (
	SELECT
		count(distinct(product_code)) as unique_products_2021
	FROM fact_sales_monthly s
    WHERE s.fiscal_year = 2021;
)

SELECT
	*,
    CONCAT(ROUND(((unique_products_2021-unique_products_2020)/unique_products_2020)*100,2),"%") as percentage_chg
FROM unique_product_2020
JOIN unique_product_2021
```
3. Provide a report with all the unique product counts for each segment and
sort them in descending order of product counts. The final output contains
2 fields,
segment,
product_count.
```sql
SELECT
	segment,
    COUNT(DISTINCT(product_code)) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;
```
4. Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment,
product_count_2020,
product_count_2021,
difference.
```sql
WITH pc_2020 AS (
	SELECT
		p.segment,
		COUNT(DISTINCT(s.product_code)) AS product_count_2020
	FROM fact_sales_monthly s
	JOIN dim_product p
	ON p.product_code = s.product_code
	WHERE s.fiscal_year = 2020
	GROUP BY p.segment
	ORDER BY product_count_2020 DESC
),
pc_2021 AS (
	SELECT
		p.segment,
		COUNT(DISTINCT(s.product_code)) AS product_count_2021
	FROM fact_sales_monthly s
	JOIN dim_product p
	ON p.product_code = s.product_code
	WHERE s.fiscal_year = 2021
	GROUP BY p.segment
	ORDER BY product_count_2021 DESC
)
SELECT
	pc_2020.*,
    product_count_2021,
    (product_count_2021-product_count_2020) AS difference
FROM pc_2020
JOIN pc_2021
ON pc_2020.segment = pc_2021.segment
ORDER BY difference DESC;
```
5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code,
product,
manufacturing_cost.
```sql
SELECT
	mc.product_code,
    p.product,
    mc.manufacturing_cost
FROM fact_manufacturing_cost mc
JOIN dim_product p
ON p.product_code = mc.product_code
WHERE mc.manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost) OR mc.manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)
ORDER BY mc.manufacturing_cost DESC;
```
6. Generate a report which contains the top 5 customers who received an
average high pre_invoice_discount_pct for the fiscal year 2021 and in the
Indian market. The final output contains these fields,
customer_code,
customer,
average_discount_percentage.
```sql
WITH avg_discount_pct AS (
	SELECT
		customer_code,
	AVG(pre_invoice_discount_pct) AS average_discount_percentage
	FROM fact_pre_invoice_deductions
    WHERE fiscal_year = 2021
    GROUP BY customer_code
),
indian_customer AS (
	SELECT
		customer_code,
        customer
	FROM dim_customer
	WHERE market = "India"
)

SELECT 
	indian_customer.customer_code,
    indian_customer.customer,
    ROUND(avg_discount_pct.average_discount_percentage*100,2) AS average_discount_percentage
FROM avg_discount_pct
JOIN indian_customer
ON avg_discount_pct.customer_code = indian_customer.customer_code
ORDER BY average_discount_percentage DESC
LIMIT 5;
```
7. Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month,
Year,
Gross sales Amount.
```sql
SELECT
	MONTHNAME(s.date) AS Month,
    s.fiscal_year AS Year,
    CONCAT(ROUND(SUM(s.sold_quantity * gp.gross_price)/1000000,2),"M") as Gross_sales_amount
FROM fact_sales_monthly s
JOIN fact_gross_price as gp
ON gp.product_code = s.product_code
JOIN dim_customer c
ON c.customer_code = s.customer_code 
WHERE customer = "Atliq Exclusive"
GROUP BY Year, Month
ORDER BY Year, str_to_date(MONTH,'%M');
```
8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter,
total_sold_quantity.
```sql
WITH quarterly_sales_monthly AS (
	SELECT
		*,
		CONCAT("Q", QUARTER(date + INTERVAL 4 MONTH)) AS Quarter
	FROM fact_sales_monthly
)

SELECT
	Quarter,
    SUM(sold_quantity) as total_sold_quantity
FROM quarterly_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarter
ORDER BY total_sold_quantity DESC
LIMIT 1;
```
9. Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel,
gross_sales_mln,
percentage.
```sql
WITH channel_gross_sales AS (
	SELECT
		c.channel,
		CONCAT(ROUND(SUM(s.sold_quantity * gp.gross_price)/1000000,2),"M") as gross_sales_mln
	FROM fact_sales_monthly s
	JOIN fact_gross_price gp
	ON s.product_code = gp.product_code
	JOIN dim_customer c
	ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
	GROUP BY c.channel
)
SELECT
	*,
    CONCAT(ROUND(100*gross_sales_mln/SUM(gross_sales_mln) OVER(),2),"%") AS percentage
FROM channel_gross_sales
GROUP BY channel
ORDER BY percentage DESC;
```
10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division,
product_code,
product,
total_sold_quantity,
rank_order.
```sql
WITH products_2021 AS (
	SELECT
		p.division,
		s.product_code,
		CONCAT(p.product, " (",p.variant,")") as product,
		SUM(s.sold_quantity) as total_sold_quantity
	FROM fact_sales_monthly s
	JOIN dim_product p
    ON p.product_code = s.product_code
	WHERE s.fiscal_year = 2021
	GROUP BY p.division, s.product_code, p.product, p.variant
),
top_3_products AS (
	SELECT
		*,
		DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) as rank_order
	FROM products_2021
)

SELECT
	*
FROM top_3_products
WHERE rank_order <= 3;
```
