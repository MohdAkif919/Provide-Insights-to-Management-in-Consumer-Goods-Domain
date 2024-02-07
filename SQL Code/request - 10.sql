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