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