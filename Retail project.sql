--SQL Retail Sales Analysis-P1
CREATE DATABASE SQL_PROJECT_PQ;

--Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
		transaction_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		category VARCHAR(15),
		quantity INT,
		price_per_unit FLOAT,
		total_sale FLOAT
);
SELECT * FROM retail_sales
LIMIT 10

SELECT COUNT(*) FROM retail_sales


--Dealing With Null Values.
SELECT  * FROM retail_sales WHERE transaction_id IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR total_sale IS NULL;

--Deleting Null Values.
DELETE FROM retail_sales WHERE transaction_id IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR total_sale IS NULL;

--Data Exploration.


--How many sales we have?
SELECT COUNT(*) as total_sales FROM retail_sales

--How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales

SELECT DISTINCT category FROM retail_sales

--Data Analysis & Business Key Problems

--Q1. Write a SQL query to retrive all columns for sales made in '2022-11-05'?
SELECT * FROM retail_sales WHERE sale_date='2022-11-05';

--Q2.Write a SQL query to retrive all transaction where the category is 'Clothing' and the quantity sold is more than 4 in the month of the Nov-22
SELECT * FROM retail_sales WHERE category ='Clothing' AND TO_CHAR(sale_date,'YYYY-MM')='2021-11' AND quantity >=4

--Q3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale), COUNT(*) as total_orders FROM retail_sales GROUP BY 1 


--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) as avg_age FROM retail_sales WHERE category='Beauty'

--Q5. Write a SQL query to find all transactions where the total_sales is greate them 1000.
SELECT * FROM retail_sales WHERE total_sale >1000

--Q6.Write a SQL query to find the total number of (transaction_id) made by each gender in each category.
SELECT category,gender, COUNT(*) as total_trans FROM retail_sales GROUP BY category, gender

--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling mmonth in each year.
SELECT EXTRACT(YEAR FROM sale_date) as year,EXTRACT(YEAR FROM sale_date) as month, AVG(total_sale) as avg_sale FROM retail_sales GROUP BY 1,2 ORDER BY 1,2 DESC

--Q8. Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT customer_id,SUM(total_sale) as toal_sales FROM retail_sales GROUP BY 1 ORDER BY 2 DESC LIMIT 5

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,COUNT(DISTINCT customer_id) as cnt_unique_cs FROM retail_sales GROUP BY category 

--Q10. Write a SQL query to create each shift and number of order (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale as (SELECT *, CASE WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'MORNING' WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON' ELSE 'EVENING' END as shift FROM retail_sales) SELECT shift, COUNT(*) as total_orders FROM hourly_sale GROUP BY shift --SELECT EXTRACT(HOUR FROM CURRENT_TIME)