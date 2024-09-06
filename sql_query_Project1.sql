--Sql Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

-- Create Table
CREATE TABLE retail_sales
    (
        transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id	INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
	);

 SELECT * FROM retail_sales
 LIMIT 10

 SELECT 
    COUNT(*) 
 FROM retail_sales
 
--Data cleaning

SELECT * FROM retail_sales
WHERE transactions_id is NULL


SELECT * FROM retail_sales
WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR 
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR
	 total_sale is NULL;

DELETE FROM retail_sales
WHERE
     transactions_id is NULL
	 OR
	 sale_date is NULL
	 OR
	 sale_time is NULL
	 OR 
	 customer_id is NULL
	 OR
	 gender is NULL
	 OR
	 category is NULL
	 OR
	 quantiy is NULL
	 OR
	 price_per_unit is NULL
	 OR
	 cogs is NULL
	 OR
	 total_sale is NULL;

SELECT 
    COUNT(*) 
 FROM retail_sales

-- Dta exploration 

--How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

--How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales

SELECT DISTINCT category FROM retail_sales

SELECT * FROM retail_sales;

--Data Analysis & Business key problems and answers

--My Analysis & Findings
--Q.1 Write a sql query to retrieve all columns for sales made on '2022-11-05'
--Q.2 Write a sql query to retrieve all transactions where the category is 'clothing'and the quantity sold is morethan 4 inthe month of Nov-2022
--Q.3 Write a sql query to calculate the total sales (total_sale)for each category
--Q.4 Write a sql query to find the average age of customers who purchased items from the 'Beauty'category
--Q.5 Write a sql query to find all the transactions where the tota_sale is greater than 1000
--Q.6 Write a sql query to find the total number of transactions(transactions_id) made by each gender in each category
--Q.7 Write a sql query to calculate  the average sale for each month. find out best selling month in the each year
--Q.8 Write a sql query to find out the top 5 customers based on the highest total sales
--Q.9 Write a sql query to find the number of unique customers who purchased items fromeach category
--Q.10 Write a sql query to create each shift and numberof orders(Example Morning<=12, Afternoon between 12&17, evenng >17)


--Q.1 Write a sql query to retrieve all columns for sales made on '2022-11-05'

SELECT*
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q.2 Write a sql query to retrieve all transactions where the category is 'clothing'and the quantity sold is morethan 4 in the month of Nov-2022

SELECT
   *
FROM retail_sales
WHERE 
     category ='Clothing'
     AND
	 TO_CHAR(sale_date, 'YYYY-MM')= '2022-11'
	 AND
	 quantiy >=4

--Q.3 Write a sql query to calculate the total sales (total_sale)for each category

SELECT 
   category,
   SUM(total_sale)as net_sale,
   COUNT(*)as total_orders
FROM retail_sales
GROUP BY 1

--Q.4 Write a sql query to find the average age of customers who purchased items from the 'Beauty'category

SELECT 
    ROUND(AVG(age),2)as avg_age
FROM retail_sales
WHERE category = 'Beauty'

--Q.5 Write a sql query to find all the transactions where the tota_sale is greater than 1000

SELECT * FROM retail_sales
WHERE total_sale > 1000

--Q.6 Write a sql query to find the total number of transactions(transactions_id) made by each gender in each category

SELECT
   category,
   gender,
   COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY
	category,
	gender
ORDER BY 1

--Q.7 Write a sql query to calculate  the average sale for each month. find out best selling month in the each year

SELECT 
    year,
	month,
	avg_sale
FROM
(
    SELECT 
       EXTRACT(YEAR FROM sale_date) as year,
	   EXTRACT(MONTH FROM sale_date) as month,
	   AVG(total_sale)as avg_sale,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC)as rank
    FROM retail_sales
    GROUP BY 1,2
) as t1
WHERE rank = 1
--ORDER BY 1,3 DESC

--Q.8 Write a sql query to find out the top 5 customers based on the highest total sales

SELECT 
   customer_id,
   SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q.9 Write a sql query to find the number of unique customers who purchased items fromeach category

SELECT
   category,
   COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

--Q.10 Write a sql query to create each shift and numberof orders(Example Morning<=12, Afternoon between 12&17, evenng >17)
WITH hourly_sale
AS
(
SELECT *,
   CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	  ELSE 'Evening'
   END as shift
FROM retail_sales
)
SELECT 
     shift,
	 COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

--End of project





        
       






