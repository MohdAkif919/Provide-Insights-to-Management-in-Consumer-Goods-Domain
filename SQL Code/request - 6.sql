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