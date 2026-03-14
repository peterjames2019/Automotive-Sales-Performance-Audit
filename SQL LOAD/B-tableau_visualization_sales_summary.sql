-- Creating a summary view to optimize Tableau performance.
-- Logic: Grouping by date and region upfront to reduce the load on the BI tool.
-- Net Profit Calculation: Includes discounts to show real-world margin leakage.

CREATE VIEW tableau_sales_summary AS
SELECT 
    salesperson,
    car_model,
    car_make,
    SUM(sales_price) AS gross_revenue,
    SUM(discount) AS total_discounts_given,
    payment_method,
    Sale_Year, 
    Sale_Month,
    Sale_Quarter,
    season,
    sales_Region,
    SUM(quantity) As total_units_sold,
    SUM(cost) AS total_cost,
    SUM(profit) AS net_profit,
    customer_age,
    customer_gender
FROM newcar_sales
GROUP BY
sale_Year,
Sale_Month,
sale_quarter,
season,
payment_method,
sales_Region,
salesperson,
customer_age,
customer_gender,
car_make,
car_model;


SELECT * FROM tableau_sales_summary;
