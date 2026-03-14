CREATE TABLE newcar_sales (
    Sales_Date DATE,
    Salesperson TEXT,
    Customer_Name TEXT,
    Customer_Age INT,
    Customer_Gender TEXT,
    Car_Make TEXT,
    Car_Model VARCHAR, 
    Car_Year INT, 
    Quantity INT, 
    Sales_Price NUMERIC,
    Cost NUMERIC,
    Profit NUMERIC, 
    Discount NUMERIC, 
    Payment_Method TEXT, 
    Commission_Rate NUMERIC, 
    Commission_Earned NUMERIC, 
    Sales_Region TEXT,
    Sale_Year INT, 
    Sale_Month TEXT,
    Sale_Quarter TEXT,
    Day_of_week TEXT, 
    Season TEXT 
);

SELECT COUNT(*)
FROM newcar_sales;

SELECT COUNT(*)
FROM newcar_sales
WHERE sales_price is NULL;

