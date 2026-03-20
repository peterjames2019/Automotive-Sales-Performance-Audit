# Automotive Sales Performance Audit (2018-2024)

## 📌 Project Overview
This project is a comprehensive end-to-end audit of over **1 million automotive sales records**. The goal was to identify lifetime value, salesperson consistency, and regional revenue trends using a robust data pipeline.

## 🛠️ The Tech Stack
* **SQL (PostgreSQL):** Used for data cleaning, transformation, and complex analytical window functions.
* **Excel:** Initial data validation and pivot table cross-checking.
* **Tableau:** Final executive dashboard for visual storytelling.

## 📂 Project Structure
1.  [**SQL LOAD:**](./SQL%20LOAD) Scripts for schema creation and importing the raw 1M+ row dataset.
2.  [**Project SQL:**](./Project%20SQL)
    * `Cumulative_sales_ranking`: Career-long leaderboard by revenue.
    * `Yearly_sales_ranking`: Year-over-year performance shifts.
    * `rpt_salesperson_consistency`: Identifying "Elite" reps who hit the Top 10 multiple times across different years.

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
```
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


 ### 2. Yearly Sales Performance Shifts
* **The Query:** Filters data by year and ranks salespeople within each specific calendar year.
* **The Insight:** This allows us to see "Rising Stars" (new hires who peaked early) versus "Declining Veterans."

```

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
FROM top_10_salespeople_per_year
LIMIT 50;
```
| sale_year | sales_rank | salesperson       | yearly_revenue   | total_cars_sold |
|-----------|------------|-------------------|------------------|-----------------|
| 2024      | 1          | Victor Flores     | $ 528,032,106    | 5321            |
| 2024      | 2          | Thomas Morrow     | $ 526,227,297    | 5351            |
| 2024      | 3          | Eileen Callahan   | $ 526,203,317    | 5375            |
| 2024      | 4          | Sharon Smith      | $ 526,072,179    | 5335            |
| 2024      | 5          | Lori Jacobs       | $ 523,748,211    | 5342            |
| 2024      | 6          | Rebekah Turner    | $ 523,319,336    | 5297            |
| 2024      | 7          | Nancy Mercado     | $ 522,574,794    | 5333            |
| 2024      | 8          | Dr. Diane Mccoy   | $ 521,605,177    | 5270            |
| 2024      | 9          | Brian Cline       | $ 521,133,545    | 5306            |
| 2024      | 10         | Jill Jones        | $ 519,509,368    | 5317            |
| 2023      | 1          | Jessica Schaefer  | $ 403,311,139    | 4290            |
| 2023      | 2          | Henry Brown       | $ 400,717,085    | 4245            |
| 2023      | 3          | Richard Rogers    | $ 399,635,328    | 4261            |
| 2023      | 4          | Erin Gomez        | $ 399,544,327    | 4241            |
| 2023      | 5          | Kevin Chavez      | $ 399,248,753    | 4262            |

### 3. Salesperson Consistency Report
* **The Query:** A complex filter that identifies salespeople who appeared in the "Top 10" in more than multiple years
* **The Insight:** This is the most valuable metric for HR and Management. It separates "lucky" high-performers from "consistently elite" performers.

```
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
ORDER BY years_in_top_10 DESC, salesperson ASC, sale_year DESC
LIMIT 100;
```

| salesperson       | sale_year | rank | yearly_revenue | top_10_count |
|-------------------|-----------|------|----------------|--------------|
| Dr. Diane Mccoy   | 2024      | 8    | $ 521,605,177  | 5            |
| Dr. Diane Mccoy   | 2022      | 4    | $ 344,053,683  | 5            |
| Dr. Diane Mccoy   | 2021      | 9    | $ 268,393,065  | 5            |
| Dr. Diane Mccoy   | 2019      | 1    | $ 72,958,275   | 5            |
| Dr. Diane Mccoy   | 2018      | 5    | $ 49,261,317   | 5            |
| Chris Johnson     | 2021      | 8    | $ 268,637,986  | 3            |
| Chris Johnson     | 2020      | 2    | $ 64,676,168   | 3            |
| Chris Johnson     | 2018      | 10   | $ 48,720,039   | 3            |
| David Hernandez   | 2022      | 8    | $ 339,251,201  | 3            |
| David Hernandez   | 2021      | 1    | $ 274,409,990  | 3            |
| David Hernandez   | 2018      | 4    | $ 49,297,455   | 3            |
| Jill Jones        | 2024      | 10   | $ 519,509,368  | 3            |
| Jill Jones        | 2021      | 7    | $ 268,777,994  | 3            |
| Jill Jones        | 2018      | 2    | $ 49,729,926   | 3            |
| Lori Jacobs       | 2024      | 5    | $ 523,748,211  | 3            |
| Lori Jacobs       | 2021      | 2    | $ 272,813,602  | 3            |
| Lori Jacobs       | 2018      | 6    | $ 49,164,074   | 3            |
| Raymond Macias    | 2023      | 6    | $ 398,973,931  | 3            |
| Raymond Macias    | 2021      | 10   | $ 268,057,902  | 3            |
| Raymond Macias    | 2019      | 8    | $ 70,980,322   | 3            |
| Sharon Smith      | 2024      | 4    | $ 526,072,179  | 3            |
| Sharon Smith      | 2019      | 6    | $ 71,232,244   | 3            |
| Sharon Smith      | 2018      | 1    | $ 50,778,745   | 3            |
| Angela Brown      | 2023      | 7    | $ 398,774,967  | 2            |
| Angela Brown      | 2020      | 9    | $ 62,963,054   | 2            |
| Chad Turner       | 2022      | 9    | $ 338,735,922  | 2            |
| Chad Turner       | 2019      | 10   | $ 70,325,131   | 2            |
| David Mullen      | 2022      | 5    | $ 343,125,871  | 2            |
| David Mullen      | 2018      | 7    | $ 49,103,144   | 2            |
| Elizabeth Ashley  | 2022      | 10   | $ 338,447,540  | 2            |
| Elizabeth Ashley  | 2020      | 4    | $ 63,984,478   | 2            |
| Henry Brown       | 2023      | 2    | $ 400,717,085  | 2            |
| Henry Brown       | 2018      | 9    | $ 48,885,706   | 2            |
| Jennifer Miller   | 2023      | 10   | $ 396,653,121  | 2            |
| Jennifer Miller   | 2018      | 8    | $ 49,084,535   | 2            |
| Kevin Chavez      | 2023      | 5    | $ 399,248,753  | 2            |
| Kevin Chavez      | 2020      | 5    | $ 63,659,734   | 2            |
| Meagan Taylor     | 2020      | 8    | $ 62,994,806   | 2            |
| Meagan Taylor     | 2019      | 7    | $ 70,983,668   | 2            |
| Nancy Mercado     | 2024      | 7    | $ 522,574,794  | 2            |
| Nancy Mercado     | 2022      | 7    | $ 339,290,099  | 2            |
| Rebekah Turner    | 2024      | 6    | $ 523,319,336  | 2            |
| Rebekah Turner    | 2022      | 2    | $ 347,497,990  | 2            |
| Robin Cantrell    | 2021      | 5    | $ 269,951,991  | 2            |
| Robin Cantrell    | 2020      | 1    | $ 65,988,356   | 2            |
| Thomas Morrow     | 2024      | 2    | $ 526,227,297  | 2            |
| Thomas Morrow     | 2
## 📊 Interactive Dashboard
You can view the final interactive visualization which **contained MORE INSIGHTS** here:  
👉 **[https://public.tableau.com/views/GlobalAutomotiveSalesPerformanceAudit/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]**

## 💡 Key Insights
* **Consistency over Spikes:** Identified top-performing agents who maintained Top 10 status across economic shifts.
* **Data Scale:** Successfully managed and queried a dataset exceeding GitHub's file size limits (137MB+).

## Contact
* **Portfolio** [https://peterjames2019.github.io/]