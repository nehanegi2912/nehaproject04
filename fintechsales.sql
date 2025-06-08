SELECT * FROM finance.sales;-- ========================================
-- Task 3: SQL for Data Analysis (Single Table: sales)
-- ========================================

-- 1. Total Gross Sales by Segment
SELECT Segment,
       ROUND(SUM(Sales), 2) AS TotalSales
FROM sales
GROUP BY Segment
ORDER BY TotalSales DESC;

-- 2. Total Profit by Country
SELECT Country,
       ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY Country
ORDER BY TotalProfit DESC;

-- 3. Top 10 Transactions with High Discounts (above average)
SELECT Segment, Country, Discounts
FROM sales
WHERE Discounts > (SELECT AVG(Discounts) FROM sales)
ORDER BY Discounts DESC
LIMIT 10;

-- 4. Simulated JOIN: Self-Join to Compare Segment Sales in Same Country
SELECT a.Country,
       a.Segment AS Segment_A,
       b.Segment AS Segment_B,
       ROUND(a.Sales, 2) AS Sales_A,
       ROUND(b.Sales, 2) AS Sales_B
FROM sales a
JOIN sales b
  ON a.Country = b.Country AND a.Segment <> b.Segment
LIMIT 10;

-- 5. Segment with Above-Average Profit (using HAVING)
SELECT Segment,
       ROUND(AVG(Profit), 2) AS AvgProfit
FROM sales
GROUP BY Segment
HAVING AvgProfit > (SELECT count(Profit) FROM sales)
ORDER BY AvgProfit DESC ;

-- ========================================
-- VIEWS
-- ========================================

-- View 1: Total Profit by Segment
CREATE VIEW view_total_Profit_by_Region AS
SELECT Region,
       ROUND(SUM(Profit), 2) AS TotalSales
FROM sales
GROUP BY Region;

-- View 2: Average Discounts by Country
CREATE VIEW view_total_discount_by_country AS
SELECT Country,
       ROUND(SUM(Discount), 2) AS TotalDiscount
FROM sales
GROUP BY Country;

-- View 3: Sales Performance Summary (Country + Segment)
CREATE VIEW view_sales_performance_summary AS
SELECT Country,
       Segment,
       ROUND(SUM(Sales), 2) AS TotalSales,
       ROUND(SUM(Profit), 2) AS TotalProfit
FROM sales
GROUP BY Country, Segment;

-- View 4: High Discount Transactions
CREATE VIEW view_high_discount_transactions AS
SELECT *
FROM sales
WHERE Discounts > (SELECT AVG(Discounts) FROM sales);

-- ========================================
-- INDEXES
-- ========================================

-- Index 1: Segment
CREATE INDEX idx_segment ON sales(Segment);

-- Index 2: Country
CREATE INDEX idx_country ON sales(Country);

-- Index 3: Composite Index on Segment + Country
CREATE INDEX idx_segment_country ON sales(Segment, Country);

-- Index 4: Order Date (if available)
 CREATE INDEX idx_order_date ON sales(Date);
