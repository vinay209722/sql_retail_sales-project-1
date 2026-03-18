# sql_retail_sales-project-1

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_database`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_database`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_database;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Retrieve sales made on a specific date**:
   ```sql
   SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
   ```

2. **Filter transactions based on category and quantity sold**:
   ```sql
   SELECT * FROM retail_sales 
   WHERE category = 'Clothing' AND quantity > 10 AND 
         EXTRACT(MONTH FROM sale_date) = 11 AND 
         EXTRACT(YEAR FROM sale_date) = 2022;
   ```

3. **Calculate total sales per category**:
   ```sql
   SELECT category, SUM(total_sale) AS total_sales 
   FROM retail_sales 
   GROUP BY category;
   ```

4. **Find the average age of customers by category**:
   ```sql
   SELECT AVG(age) AS average_age 
   FROM retail_sales 
   WHERE category = 'Beauty';
   ```

5. **Identify high-value transactions**:
   ```sql
   SELECT * FROM retail_sales 
   WHERE total_sale > 1000;
   ```

6. **Transactions by gender and category**:
   ```sql
   SELECT category, gender, COUNT(transactions_id) AS total_transactions 
   FROM retail_sales 
   GROUP BY category, gender;
   ```

7. **Average sales per month and identify the best-selling month**:
   ```sql
   SELECT EXTRACT(MONTH FROM sale_date) AS month, 
          EXTRACT(YEAR FROM sale_date) AS year, 
          AVG(total_sale) AS average_sales
   FROM retail_sales 
   GROUP BY year, month;
   ```

8. **Top 5 customers by total sales**:
   ```sql
   SELECT customer_id, SUM(total_sale) AS total_spent 
   FROM retail_sales 
   GROUP BY customer_id 
   ORDER BY total_spent DESC 
   LIMIT 5;
   ```

9. **Unique customers per category**:
   ```sql
   SELECT category, COUNT(DISTINCT customer_id) AS unique_customers 
   FROM retail_sales 
   GROUP BY category;
   ```

10. **Order analysis by shift (Morning, Afternoon, Evening)**:
    ```sql
    SELECT 
        CASE 
            WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening' 
        END AS shift,
        COUNT(transactions_id) AS total_orders
    FROM retail_sales 
    GROUP BY shift;
    ```
