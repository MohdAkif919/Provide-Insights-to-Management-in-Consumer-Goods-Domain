# Project Overview
Atliq Hardware, an innovative leader in computer hardware and peripherals, recognized the critical need for data-driven decisions. Initiating 𝟭𝟬 𝗮𝗱-𝗵𝗼𝗰 𝗿𝗲𝗾𝘂𝗲𝘀𝘁𝘀, they tasked the data analytics team. Leveraging 𝗦𝗤𝗟 𝗾𝘂𝗲𝗿𝗶𝗲𝘀, I meticulously tackled each request, unraveling invaluable insights for 𝗺𝗮𝗻𝗮𝗴𝗲𝗺𝗲𝗻𝘁.

* Video Presentation: [Click Here](https://youtu.be/Uf3cyl1ggTo?si=QozlI5oeoz6nlZnJ)
* LinkedIn Post:
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
unique_products_2020
unique_products_2021
percentage_chg
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
