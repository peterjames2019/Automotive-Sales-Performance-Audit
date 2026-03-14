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

## 📊 Interactive Dashboard
You can view the final interactive visualization here:  
👉 **[https://public.tableau.com/views/GlobalAutomotiveSalesPerformanceAudit/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]**

## 💡 Key Insights
* **Consistency over Spikes:** Identified top-performing agents who maintained Top 10 status across economic shifts.
* **Data Scale:** Successfully managed and queried a dataset exceeding GitHub's file size limits (137MB+).
