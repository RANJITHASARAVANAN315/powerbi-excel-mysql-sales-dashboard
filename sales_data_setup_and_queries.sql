-- Create database and use it
CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

-- Create the sales_data table
CREATE TABLE IF NOT EXISTS sales_data (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2),
    Profit_Percentage DECIMAL(5,2)
);

-- Allow data import from local files
SET GLOBAL local_infile = 1;

-- Load data (adjust the path to your local CSV file)
-- LOAD DATA LOCAL INFILE 'path_to_your_csv/superstore_data_project1.csv'
-- INTO TABLE sales_data
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Sample Preview
SELECT * FROM sales_data LIMIT 5;

-- Total Sales
SELECT SUM(Sales) AS Total_Sales FROM sales_data;

-- Year-wise Sales
SELECT YEAR(Order_Date) AS Year, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- Year-wise Profit Percentage
SELECT YEAR(Order_Date) AS Year, SUM(Profit_Percentage) AS Total_Profit_Percentage
FROM sales_data
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- Region-wise Sales
SELECT Region, SUM(Sales) AS Regional_Sales
FROM sales_data
GROUP BY Region;

-- Top 10 Profitable Customers (Donut Chart)
SELECT Customer_Name, SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- Profit by Category (Pie Chart)
SELECT Category, SUM(Profit_Percentage) AS Total_Profit_Percentage
FROM sales_data
GROUP BY Category;

-- City-wise Sales (Bar Chart)
SELECT City, SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY City
ORDER BY Total_Sales DESC;

-- Customer Profit Table
SELECT Customer_Name, SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;
