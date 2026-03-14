# Automotive Sales Performance Audit (2018-2024)

## 📌 Project Overview
This project is a comprehensive end-to-end audit of over **1 million automotive sales records**. The goal was to identify lifetime value, salesperson consistency, and regional revenue trends using a robust data pipeline.

## 🛠️ The Tech Stack
* **SQL (PostgreSQL):** Used for data cleaning, transformation, and complex analytical window functions.
* **Excel:** Initial data validation and pivot table cross-checking.
* **Tableau:** Final executive dashboard for visual storytelling.

## 📂 Project Structure
1.  [**SQL LOAD:**](./SQL%20LOAD) Scripts for schema creation and importing the raw 1M+ row dataset.
2.  [**Project SQL:**](./Project%20SQL) * `1Cumulative_sales_ranking`: Career-long leaderboard by revenue.
    * `2Yearly_sales_ranking`: Year-over-year performance shifts.
    * `3rpt_salesperson_consistency`: Identifying "Elite" reps who hit the Top 10 multiple times across different years.

## 🔍 SQL Analysis Deep-Dive
### 1. Cumulative Sales Ranking
**The Logic:** This query identifies the "Master Leaderboard" by aggregating total profit across all years (2018-2024).

#### SQL Code:
```sql
SELECT 
    Salesperson, 
    SUM(Profit) AS total_profit, 
    COUNT(*) AS total_cars_sold
FROM newcar_sales
GROUP BY Salesperson
ORDER BY total_profit DESC
LIMIT 15;

| salesperson       | total_profit     | total_cars_sold |
|-------------------|------------------|-----------------|
| Victor Flores     | $ 368,250,793    | 20138           |
| Nancy Mercado     | $ 367,009,501    | 20198           |
| Sharon Smith      | $ 366,287,949    | 20252           |
| Rebekah Turner    | $ 366,026,058    | 20117           |
| Eileen Callahan   | $ 365,020,425    | 20159           |
| Alan Ramos        | $ 364,879,212    | 20044           |
| Jill Jones        | $ 364,591,923    | 20184           |
| Timothy Wheeler   | $ 364,470,743    | 20039           |
| Mary Simon        | $ 363,919,229    | 20089           |
| Dr. Diane Mccoy   | $ 363,907,401    | 20105           |
| Christopher Scott | $ 363,797,993    | 20060           |
| Thomas Morrow     | $ 363,618,352    | 20223           |
| Jessica Schaefer  | $ 363,364,687    | 20151           |
| Angela Brown      | $ 363,329,432    | 20112           |
| Raymond Macias    | $ 363,229,400    | 20063           |

## 📊 Interactive Dashboard
You can view the final interactive visualization here:  
👉 **[https://public.tableau.com/views/GlobalAutomotiveSalesPerformanceAudit/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]**

## 💡 Key Insights
* **Consistency over Spikes:** Identified top-performing agents who maintained Top 10 status across economic shifts.
* **Data Scale:** Successfully managed and queried a dataset exceeding GitHub's file size limits (137MB+).
