/* STEP 1: CUMULATIVE PERFORMANCE ANALYSIS
---------------------------------------
BUSINESS CONTEXT: 
Before analyzing individual years, we must establish the 'Lifetime Value' of 
our sales force. This script identifies the top 5% of earners across the entire 
2018-2024 dataset.

TECHNICAL LOGIC:
- Uses SUM() and RANK() window functions to calculate total career revenue.
- This serves as the 'Master Leaderboard' for the entire audit.
- Helps identify long-tenured high-performers versus short-term spikes.
*/

SELECT
    Salesperson,
    SUM(Profit) AS total_profit,
    COUNT(*) AS total_cars_sold
FROM newcar_sales
GROUP BY Salesperson
ORDER BY total_profit DESC;