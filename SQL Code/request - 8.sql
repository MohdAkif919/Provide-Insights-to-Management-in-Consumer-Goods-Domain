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