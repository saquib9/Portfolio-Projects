/*
Project: Walmart Sales Analysis
Query Language: MySQL
Dataset: https://github.com/saquib9/Portfolio-Projects/blob/main/Portfolio-Projects/Walmart-Sales-Analysis/WalmartSalesData.csv
*/  

CREATE DATABASE IF NOT EXISTS walmart_sales_data;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_5_percent FLOAT NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL, -- COGS = Cost of Goods Sold 
    gross_margin_percentage FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
);

-- -------------------------------------------------------------------
-- ------------------------Feature Engineering------------------------
-- -------------------------------------------------------------------

-- Added column 'time_of_day' 
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(9);

UPDATE sales SET time_of_day = (
	CASE 
		WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN time BETWEEN '16:00:00' AND '18:59:59' THEN 'Evening'
        ELSE 'Night'
	END
);

-- Added column 'day_name' 
ALTER TABLE sales ADD COLUMN day_name VARCHAR(9);

UPDATE sales SET day_name = DAYNAME(date);

-- Added column 'month_name' 
ALTER TABLE sales ADD COLUMN month_name VARCHAR(8);

UPDATE sales SET month_name = MONTHNAME(date);

-- -----------------------------------------------------------------
-- ---------------- Solution to Business Questions -----------------
-- -----------------------------------------------------------------

-- ------------------------- 1. General ----------------------------

-- How many unique cities does the data have?
SELECT COUNT(DISTINCT city) AS TOTAL_CITIES from sales;

-- Location (City) of each branch
SELECT DISTINCT branch, city FROM sales;

-- ------------------------- 2. Product ----------------------------

-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT product_line) FROM sales;

-- What is the most common payment method?
SELECT payment, COUNT(payment) AS pay_method_count from sales 
GROUP BY payment ORDER BY pay_method_count DESC;

-- What is the most selling product line?
SELECT product_line, COUNT(product_line) AS prd_line_count from sales 
GROUP BY product_line ORDER BY prd_line_count DESC;

-- What is the total revenue by month?
SELECT month_name, SUM(total) AS revenue from sales 
GROUP BY month_name ORDER BY revenue DESC;

-- What month had the largest COGS?
SELECT month_name, SUM(cogs) AS monthly_cogs from sales 
GROUP BY month_name ORDER BY monthly_cogs DESC;

-- What product line had the largest revenue?
SELECT product_line, SUM(total) AS revenue from sales 
GROUP BY product_line ORDER BY revenue DESC;

<<<<<<< HEAD
-- Fetch each product line and add a column to those product lines 
-- showing "Good", and "Bad". Good if it is greater than average sales
=======
-- Fetch each product line and add a column showing "Good", and "Bad". Good if it is greater than average sales.
>>>>>>> 0d610820ba1776d6e22e92adb1c10eee8427e9e3

WITH total_sales AS (
	SELECT product_line, SUM(total) AS total
	FROM sales GROUP BY product_line),
avg_sales AS (
    SELECT AVG(total) AS avg_sales
    FROM total_sales
)
SELECT
    product_line,
    CASE
        WHEN total > (SELECT avg_sales FROM avg_sales) THEN 'Good'
        ELSE 'Bad'
    END AS remark
FROM total_sales
GROUP BY product_line;

-- Which branch sold more products than the average product sold?

WITH branch_totals AS (
	SELECT branch, SUM(quantity) AS total_quantity
	FROM sales GROUP BY branch),
average_branch_sales AS (
	SELECT AVG(total_quantity) as avg_quantity
    FROM branch_totals)
SELECT branch, total_quantity FROM branch_totals
WHERE total_quantity > (SELECT avg_quantity FROM average_branch_sales);

-- What is the most common product line by gender?
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT product_line,
	ROUND(AVG(rating), 2) as avg_rating
FROM sales GROUP BY product_line ORDER BY avg_rating DESC;

SELECT
    day_name,
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY day_name, total_sales DESC;

-- --------------------------- 3. Sales --------------------------------

-- Number of sales made at each time of the day per weekday
SELECT
    day_name,
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE day_name NOT IN ('Saturday', 'Sunday')
GROUP BY day_name, time_of_day
ORDER BY day_name, total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax percentage/ VAT (Value Added Tax)?
SELECT city,
    ROUND(AVG(tax_5_percent*100/total), 2) AS avg_tax_percent
FROM sales
GROUP BY city ORDER BY avg_tax_percent DESC;

-- ------------------------ 4. Customers -----------------------------

-- What is the most common customer type?
SELECT customer_type, COUNT(*) AS count
FROM sales 
GROUP BY customer_type ORDER BY count DESC;

-- What is the gender of most of the customers?
SELECT	gender, COUNT(*) AS gender_count
FROM sales
GROUP BY gender ORDER BY gender_count DESC;

-- What is the gender distribution per branch?
SELECT branch, gender, COUNT(*) as gender_count
FROM sales
GROUP BY branch, gender ORDER BY branch, gender DESC;

-- Which time of the day do customers give the most ratings?
SELECT time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day ORDER BY avg_rating DESC;

-- Which time of the day do customers give the most ratings per branch?
SELECT	branch, time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, time_of_day ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings?
SELECT day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT branch, day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, day_name ORDER BY avg_rating DESC;







