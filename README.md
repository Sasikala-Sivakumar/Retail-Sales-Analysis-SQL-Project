# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Retail_Sales_Analysis_SQL_P1`

This project showcases essential SQL skills and techniques commonly employed by data analysts to explore, clean, and analyze retail sales data. It includes creating a retail sales database, conducting exploratory data analysis (EDA), and using SQL queries to answer targeted business questions. It's a great starting point for beginners in data analysis who want to develop a strong foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Sales_Analysis_SQL_P1`.
- **Table Creation**: A table named `retail_sales_analysis` is created to store the sales data. The table structure includes columns for TransactionID,Sale_Date,Sale_Time,CustomerID,Gender,Customer_Age,Product_Category,Quantity_Sold,Unit_Price,Cost_Of_Goods_Sold,Total_Revenue.

```sql
CREATE DATABASE Retail_Sales_Analysis_SQL_P1;

CREATE TABLE retail_sales_analysis
            (
                TransactionID    INT PRIMARY KEY,	
                Sale_Date      	 DATE,	 
                Sale_Time      	 TIME,	
                CustomerID	INT,
                Gender	 VARCHAR(10),
                Customer_Age	 INT,
                Product_Category VARCHAR(75),	
                Quantity_Sold	 INT,
                Unit_Price    FLOAT,	
                Cost_Of_Goods_Sold  FLOAT,
                Total_Revenue FLOAT
            );
```

### 2. Data Examination & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT  COUNT(*) FROM retail_sales_analysis;
SELECT COUNT(DISTINCT CustomerID) FROM retail_sales_analysis;
SELECT DISTINCT Product_Category FROM retail_sales_analysis;

SELECT * FROM retail_sales_analysis
WHERE  TransactionID IS NULL OR Sale_Date IS NULL OR Sale_Time IS NULL 
	OR CustomerID IS NULL OR Gender IS NULL OR Customer_Age IS NULL 
	OR Product_Category IS NULL OR Quantity_Sold IS NULL OR Unit_Price IS NULL 
	OR Cost_Of_Goods_Sold IS NULL OR Total_Revenue IS NULL;
	
UPDATE retail_sales_analysis SET Customer_Age=23
WHERE Customer_Age IS NULL;
		   
DELETE FROM retail_sales_analysis 
WHERE Quantity_Sold IS NULL OR Unit_Price IS NULL 
	OR Cost_Of_Goods_Sold IS NULL OR Total_Revenue IS NULL;

```

### 3. Business Issues & Insights

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to select all data from the sales that occurred on November 5, 2020**:
```sql
SELECT *
FROM retail_sales_analysis
WHERE Sale_Date = '2020-11-05';
```

2. **Write a SQL query to select all transactions from November 2020 where the category is 'Pharmaceuticals' and more than 4 units were sold.**:
```sql
SELECT * FROM retail_sales_analysis
WHERE Product_Category = 'Pharmaceuticals'
AND TO_CHAR(Sale_Date, 'YYYY-MM') = '2020-11'
AND Quantity_Sold >= 4;
```

3. **Write a SQL query to compute the total revenue generated for each category.**:
```sql
SELECT Product_Category, SUM(Total_Revenue) as Net_Revenue,COUNT(*) as Total_Orders
FROM retail_sales_analysis
GROUP BY Product_Category;
```

4. **Write an SQL query to calculate the average age of customers who have made purchases in the 'Personal care' category.**:
```sql
SELECT ROUND(AVG(Customer_Age)) as avg_age
FROM retail_sales_analysis
WHERE Product_Category = 'Personal care'; 
```

5. **Write a SQL query to find all transactions where the total revenue is greater than 2000.**:
```sql
SELECT * FROM retail_sales_analysis
WHERE total_revenue> 2000;
```

6. **Write an SQL query to calculate the total number of transactions (transaction_id) for each gender within every category.**:
```sql
SELECT Product_Category, Gender, COUNT(*) as total_trans_id
FROM retail_sales_analysis
GROUP BY Product_Category, Gender
ORDER BY Product_Category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
SELECT Year,Month,avg_revenue
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM Sale_Date) as Year,
    EXTRACT(MONTH FROM Sale_Date) as Month,
    ROUND(AVG(Total_Revenue)) as avg_revenue,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM Sale_Date) ORDER BY AVG(Total_Revenue) DESC) as rank
FROM retail_sales_analysis
GROUP BY 1, 2
) as t1
WHERE rank = 1;
```

8. **Write an SQL query to retrieve the top 5 customers with the highest total revenue.**:
```sql
SELECT CustomerID,SUM(Total_Revenue) as Total_Revenue
FROM retail_sales_analysis
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT Product_Category,COUNT(DISTINCT CustomerID) as cnt_unique_cs
FROM retail_sales_analysis 
GROUP BY Product_Category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_analysis
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Furniture,Personal care, Pharmaceuticals.
- **High-Value Transactions**: Several transactions had a Total Revenue greater than 2000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `Data_Cleaning&Examination.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `Business_Issues&Insights.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author   
**Name**: [Sasikala Sivakumar]  
**Email**: [sasikala26032001@gmail.com]

---

⭐ **If you found this project useful, don't forget to give it a star!** ⭐
