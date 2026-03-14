/* STEP 2: YEAR-OVER-YEAR PERFORMANCE SHIFTS
-------------------------------------------
BUSINESS CONTEXT: 
Following the Cumulative analysis, this script breaks down revenue by specific 
calendar years. This is critical for identifying 'Rising Stars' (new reps 
climbing the ranks) and 'Fading Veterans' who may have high cumulative stats 
but declining recent performance.

TECHNICAL LOGIC:
- Groups revenue by "Sale Year" and "Salesperson".
- Allows the business to see which years (e.g., 2020 or 2024) had the most 
  competitive sales environment.
- Used to inform annual performance reviews and quota setting.
*/


CREATE VIEW top_10_salespeople_per_year AS
WITH RankedSales AS(
    SELECT
        sale_Year,
        Salesperson,
        SUM(sales_price) AS Yearly_revenue,
        COUNT(*) AS total_cars_sold,
        RANK() OVER(PARTITION BY sale_year ORDER BY SUM(sales_price) DESC) as sales_rank
    FROM newcar_sales
    GROUP BY sale_Year, Salesperson)

SELECT
    sale_Year, 
    sales_rank, 
    Salesperson, 
    Yearly_revenue, 
    total_cars_sold
FROM RankedSales
WHERE sales_rank <=10
ORDER BY sale_year DESC, sales_rank ASC;


SELECT *
FROM top_10_salespeople_per_year;