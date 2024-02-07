SELECT
	mc.product_code,
    p.product,
    mc.manufacturing_cost
FROM fact_manufacturing_cost mc
JOIN dim_product p
ON p.product_code = mc.product_code
WHERE mc.manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost) OR mc.manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)
ORDER BY mc.manufacturing_cost DESC;