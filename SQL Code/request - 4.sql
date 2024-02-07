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