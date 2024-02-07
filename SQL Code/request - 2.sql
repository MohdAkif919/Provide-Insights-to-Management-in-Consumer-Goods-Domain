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
