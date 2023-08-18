create database data_minig;


--   Define meta data in mysql workbench or any other SQL tool
-- What is the distribution of order values across all customers in the dataset?

show databases;
use data_minig;
show tables;
select count(*) from  online_retail;
select * from online_retail;

--     How many unique products has each customer purchased?

SELECT CustomerID, COUNT(DISTINCT StockCode) AS unique_product_count
FROM online_retail
GROUP BY CustomerID;

-- Which customers have only made a single purchase from the company?
SELECT CustomerID, count(StockCode) as single_parchases
FROM online_retail
group by CustomerID 
having single_parchases=1;

-- Which products are most commonly purchased together by customers in the dataset?

SELECT o1.StockCode AS product1, o2.StockCode AS product2, COUNT(*) AS purchase_count
FROM online_retail o1
JOIN orders o2 ON o1.StockCode = o2.order_id AND o1.product_id < o2.product_id
GROUP BY product1, product2
ORDER BY purchase_count DESC;

# ADVANCE QUERIES

-- 1.      Customer Segmentation by Purchase Frequency

SELECT 
    CustomerID,
    CASE
        WHEN COUNT(*) >= 20 THEN 'High Frequency'
        WHEN COUNT(*) >= 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS purchase_frequency
FROM online_retail
GROUP BY CustomerID;


-- 2. Average Order Value by Country

select * From online_retail;

SELECT
    Country,
    AVG(UnitPrice) AS average_order_value
FROM online_retail
GROUP BY country;

-- 3. Customer Churn Analysis

SELECT DISTINCT CustomerID
FROM online_retail
WHERE InvoiceDate < DATE_SUB(NOW(), INTERVAL 6 MONTH);


-- 4. Product Affinity Analysis

SELECT
    p1.StockCode AS product_1,
    p2.StockCode AS product_2,
    COUNT(*) AS purchase_count
FROM online_retail p1
JOIN online_retail p2 ON p1.CustomerID = p2.CustomerID AND p1.InvoiceDate = p2.InvoiceDate AND p1.StockCode < p2.StockCode
GROUP BY p1.StockCode, p2.StockCode
HAVING purchase_count > 5
ORDER BY purchase_count DESC;

-- 5. Time-based Analysis
SELECT * From online_retail;

SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS time_interval,
    SUM(UnitPrice) AS total_sales
FROM online_retail
GROUP BY time_interval
ORDER BY time_interval;
