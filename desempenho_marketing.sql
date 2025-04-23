
SELECT 
  campaign_id, 
  COUNT(*) AS total_sales, 
  SUM(total_amount) AS total_revenue, 
  AVG(total_amount) AS avg_revenue_per_sale
FROM sales
WHERE 
  campaign_id IS NOT NULL
GROUP BY campaign_id
ORDER BY total_revenue DESC
