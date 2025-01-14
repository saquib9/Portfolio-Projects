# Walmart Sales Data Analysis
## About
This project aims to explore Walmart Sales data to understand top-performing branches and products, sales trends of of different products, and customer behavior. This project aims to gain insight into Walmart's sales data to understand the factors affecting sales in different branches.

## Analysis List
#### 1. Product Analysis
Analyze the data to understand the different product lines, the ones performing best, and the ones that need improvement.

#### 2. Customer Analysis
This analysis aims to uncover the different customer segments, purchase trends, and the profitability of each customer segment.

#### 3. Sales Analysis
This analysis aims to answer the question of sales trends. The result can help us measure the effectiveness of each sales strategy the business applies and the modifications needed to increase sales.

## Approach Followed
### 1. Data Wrangling: 
This is the first step where data inspection is done to confirm that NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
1. Build a database
2. Create the table and insert the data.
3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.
### 2. Feature Engineering: 
This will help us generate some new columns from existing ones.
1. Add a new column named time_of_day to give an insight into sales in the Morning, Afternoon, and Evening. This will help answer the question of which part of the day most sales are made.
2. Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question of which week of the day each branch is busiest.
3. Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Determine which month of the year has the most sales and profit.
### 3. Exploratory Data Analysis (EDA): 
Exploratory data analysis is done to answer the questions listed below.

#### A. Generic Questions
1. How many unique cities does the data have?
2. In which city is each branch?
#### B. Product-Related Questions
3. How many unique product lines does the data have?
4. What is the most common payment method?
5. What is the most selling product line?
6. What is the total revenue by month?
7. What month had the largest COGS?
8. What product line had the largest revenue?
9. Fetch each product line and add a column to those product lines showing "Good", and "Bad". Good if it is greater than average sales
10. Which branch sold more products than the average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?
#### C. Sales-Related Questions
13. Number of sales made at each time of the day per weekday
14. Which of the customer types brings the most revenue?
15. Which city has the largest tax percentage/ VAT (Value Added Tax)?
#### D. Customer-Related Questions
16. What is the most common customer type?
17. What is the gender of most of the customers?
18. What is the gender distribution per branch?
19. Which time of the day do customers give the most ratings?
20. Which time of the day do customers give the most ratings per branch?
21. Which day of the week has the best average ratings?
22. Which day of the week has the best average ratings per branch? 




