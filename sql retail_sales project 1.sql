-- sql retail sales analysis - p1

CREATE TABLE Retail_Sales
(
		transactions_id	Int PRIMARY KEY,
		sale_date Date,
		sale_time Time,
		customer_id	Int,
		gender Varchar(10),
		age Int,
		category Varchar(35),
		quantiy Int,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
);

SELECT * FROM Retail_Sales;


SELECT COUNT (*)
FROM Retail_Sales

-- Data Checking

SELECT * FROM Retail_Sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR
	customer_iD IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy	 IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

	-- Data Cleaning
	
	DELETE FROM Retail_Sales
	WHERE 
		transactions_id IS NULL
	OR
	sale_date IS NULL
	OR 
	sale_time IS NULL
	OR
	customer_iD IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy	 IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

	-- Data Exploration
	-- How many sales we have

SELECT COUNT(*) AS total_sale FROM retail_sales

	-- How many unique customers we have

	SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales

-- Data Analysis

--Q.1 Write a sql Query to retrieve all columns for sales made on 2022-11-05

SELECT * 
	FROM retail_sales
	WHERE sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM retail_sales
	WHERE
	category = 'Clothing'
	AND 
	quantity >= 4
	AND
	Sale_date >= '2022-11-01'
    AND 
    Sale_date < '2022-12-01';

--Q.3 Write a SQL query to calculate the total sales (total sale) for each category.

	SELECT category, 
	SUM (Quantity * Price_per_unit) AS Total_sales
	FROM retail_sales
	group by category

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

	SELECT
		ROUND(AVG (age),2) as avg_age
	FROM retail_sales
	WHERE Category = 'Beauty'


--Write a SQL query to find all transactions where the total_sale is greater than 1800.

SELECT * FROM retail_sales
WHERE total_sale >1800

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,gender,
	COUNT (transactions_id) as Total_transaction
	FROM retail_sales
	GROUP BY Gender, Category


--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT * FROM 
(
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) AS avg_sale,
	RANK() OVER (
	PARTITION BY EXTRACT(YEAR FROM sale_date) 
        ORDER BY AVG(Total_sale) DESC
    ) AS Rank_in_year
 FROM retail_sales
GROUP BY 1,2
) AS T1
WHERE Rank_in_year = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
	customer_id,
	SUM(total_sale) AS Total_Sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	category,
	COUNT(DISTINCT customer_id) AS unique_cust
	FROM retail_sales
	GROUP BY category
	
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
	CASE
		WHEN EXTRACT (HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE
		'Evening'
		END AS Shift,
		COUNT (*) as Number_of_orders
	FROM retail_sales
	GROUP BY Shift
	ORDER BY Number_of_orders







	