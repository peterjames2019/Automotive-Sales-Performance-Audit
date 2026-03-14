/* STEP 3: SALESPERSON DOMINANCE & CONSISTENCY ANALYSIS
------------------------------------------------------
BUSINESS CONTEXT: 
This is the "Top Performer" audit. Instead of just looking at total revenue, 
this script identifies which sales personnel have successfully ranked in the 
Top 10 across multiple fiscal years(2018-2024). 

WHY THIS MATTERS:
A salesperson might have one lucky year due to a single large contract. By 
filtering for those who hit the Top 10 year-after-year, we identify our 
"High-Consistency Assets"—the reps who have mastered the market regardless 
of economic shifts (2020 vs 2024).

TECHNICAL LOGIC:
- Identifies Top 10 earners per year.
- Aggregates the frequency of "Top 10" appearances for each salesperson.
- Separates "One-Hit Wonders" from "Consistent Leaders."
*/

SELECT 
    salesperson,
    sale_year,
    sales_rank,
    yearly_revenue,
  
    COUNT(*) OVER(PARTITION BY salesperson) AS years_in_top_10
FROM top_10_salespeople_per_year
WHERE salesperson IN (
    SELECT salesperson
    FROM top_10_salespeople_per_year
    GROUP BY salesperson
    HAVING COUNT(*) > 1
)
ORDER BY years_in_top_10 DESC, salesperson ASC, sale_year DESC;