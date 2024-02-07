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