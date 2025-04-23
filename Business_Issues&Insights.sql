--Business Issues & Insights

--Q.1 Write a SQL query to select all data from the sales that occurred on November 5, 2020.
--Q.2 Write a SQL query to select all transactions from November 2020 where the category is 'Pharmaceuticals' and more than 4 units were sold.
--Q.3 Write a SQL query to compute the total revenue generated for each category.
--Q.4 Write an SQL query to calculate the average age of customers who have made purchases in the 'Personal care' category.
--Q.5 Write a SQL query to find all transactions where the total revenue is greater than 2000.
--Q.6 Write an SQL query to calculate the total number of transactions (transaction_id) for each gender within every category.
--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
--Q.8 Write a SQL query to find the top 5 customers based on the highest total revenue 
--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to select all data from the sales that occurred on November 5, 2020.
SELECT *
FROM retail_sales_analysis
WHERE Sale_Date = '2020-11-05';    --11 Rows Fetched

--Q.2 Write a SQL query to select all transactions from November 2020 where the category is 'Pharmaceuticals' and more than 4 units were sold.
SELECT 
  *
FROM retail_sales_analysis
WHERE Product_Category = 'Pharmaceuticals'
    AND
	TO_CHAR(Sale_Date, 'YYYY-MM') = '2020-11'
    AND
    Quantity_Sold >= 4;     --17 Rows Fetched
	
--Q.3 Write a SQL query to compute the total revenue generated for each category.
SELECT 
    Product_Category,
    SUM(Total_Revenue) as Net_Revenue,
    COUNT(*) as Total_Orders
FROM retail_sales_analysis
GROUP BY Product_Category;	  --3 Rows Fetched

--Q.4 Write an SQL query to calculate the average age of customers who have made purchases in the 'Personal care' category.
SELECT
    ROUND(AVG(Customer_Age)) as avg_age
FROM retail_sales_analysis
WHERE Product_Category = 'Personal care';  --40

--Q.5 Write a SQL query to find all transactions where the total revenue is greater than 2000.
SELECT * FROM retail_sales_analysis
WHERE total_revenue> 2000		--598 Rows Fetched

--Q.6 Write an SQL query to calculate the total number of transactions (transaction_id) for each gender within every category.
SELECT 
    Product_Category,
    Gender,
    COUNT(*) as total_trans_id
FROM retail_sales_analysis
GROUP 
    BY 
    Product_Category,
    Gender
ORDER BY Product_Category;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
       Year,
       Month,
    avg_revenue
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
WHERE rank = 1   --Month 3,2020 and 2,2021

--Q.8 Write an SQL query to retrieve the top 5 customers with the highest total revenue.
SELECT 
    CustomerID,
    SUM(Total_Revenue) as Total_Revenue
FROM retail_sales_analysis
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 5;   --5 Rows Fetched 

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    Product_Category,    
    COUNT(DISTINCT CustomerID) as cnt_unique_cs
FROM retail_sales_analysis 
GROUP BY Product_Category;  --3 Rows Fetched

--Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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
GROUP BY shift;  --3 Rows Fetched