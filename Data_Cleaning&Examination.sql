-- Database: Retail_Sales_Analysis_SQL_P1
-- DROP DATABASE IF EXISTS "Retail_Sales_Analysis_SQL_P1";
CREATE DATABASE "Retail_Sales_Analysis_SQL_P1";


-- Create TABLE
DROP TABLE IF EXISTS retail_sales_analysis;
CREATE TABLE retail_sales_analysis
            (
                TransactionID  			   	   INT PRIMARY KEY,	
                Sale_Date      			   	       DATE,	 
                Sale_Time      			   	       TIME,	
                CustomerID				   	       INT,
                Gender	 				   	       VARCHAR(10),
                Customer_Age		   	       INT,
                Product_Category  	   	       VARCHAR(75),	
                Quantity_Sold	       	   	       INT,
                Unit_Price              	   	       FLOAT,	
                Cost_Of_Goods_Sold	       FLOAT,
                Total_Revenue                   FLOAT
            );

SELECT * FROM public.retail_sales_analysis
ORDER BY transactionid ASC
LIMIT 10;

SELECT  
    COUNT(*) 
FROM retail_sales_analysis;


-- Cleaning Raw Data
SELECT * FROM retail_sales_analysis
WHERE 
    TransactionID	IS NULL 
    OR
    Sale_Date	IS NULL
    OR
    Sale_Time	IS NULL
    OR
    CustomerID	IS NULL
    OR
    Gender IS NULL
    OR
    Customer_Age	IS NULL
    OR
    Product_Category IS NULL
    OR	
    Quantity_Sold	IS NULL
    OR
    Unit_Price	IS NULL
    OR
    Cost_Of_Goods_Sold	 IS NULL
    OR
    Total_Revenue  IS NULL;
	
UPDATE retail_sales_analysis SET Customer_Age=23
WHERE 
           Customer_Age	IS NULL;
		   
DELETE FROM retail_sales_analysis 
WHERE
    Quantity_Sold	IS NULL
    OR
    Unit_Price	IS NULL
    OR
    Cost_Of_Goods_Sold	 IS NULL
    OR
    Total_Revenue  IS NULL;
	
	
-- Data Examination
How many units have we sold?	
SELECT COUNT(*) as total_units_sold FROM retail_sales_analysis;      --1997 units sold

How many distinct customers do we have? 
SELECT COUNT(DISTINCT CustomerID) as unique_customer FROM retail_sales_analysis;   --155 unique customer

How many distinct category do we have?
SELECT COUNT(DISTINCT Product_Category) as unique_category FROM retail_sales_analysis;  --3  unique category