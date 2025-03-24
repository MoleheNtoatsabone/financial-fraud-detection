
-- Retrieve All Transactions
SELECT * FROM Advanced_Queries.financial_fraud_detection_excel_file;

-- Count of Fraudulent vs. Non-Fraudulent Transactions
SELECT Fraud_Flag, COUNT(*) AS Total_Transactions
From Advanced_Queries.financial_fraud_detection_excel_file
GROUP BY Fraud_Flag;

-- Top 5 Locations with Most Fraudulent Transactions
SELECT Location, COUNT(*) AS Fraud_Count
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Location
ORDER BY Fraud_Count DESC
LIMIT 5;

-- Average Transaction Amount by Transaction Type
SELECT Transaction_Type, AVG(Transaction_Amount) AS Avg_Amount
FROM Advanced_Queries.financial_fraud_detection_excel_file
GROUP BY Transaction_Type
ORDER BY Avg_Amount DESC;

-- Customers with the Highest Number of Fraudulent Transactions
SELECT Customer_ID, COUNT(*) AS Fraudulent_Transactions
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Customer_ID
ORDER BY Fraudulent_Transactions DESC
LIMIT 10;



-- Merchant Categories with Highest Fraudulent Transactions
SELECT Merchant_Category, COUNT(*) AS Fraud_Count
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Merchant_Category
ORDER BY Fraud_Count DESC;

-- Detect Unusually High Transactions (Potential Fraud)
SELECT * FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Transaction_Amount > (SELECT AVG(Transaction_Amount) + 3 * STDDEV(Transaction_Amount) FROM Advanced_Queries.financial_fraud_detection_excel_file);


-- Detecting High-Risk Customers

-- This query identifies customers who have made transactions that appear to be fraudulent multiple times, flagging them for investigation.

SELECT Customer_ID, 
       COUNT(*) AS Fraudulent_Transactions,
       SUM(Transaction_Amount) AS Total_Amount_Fraud
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Customer_ID
HAVING COUNT(*) > 5 -- More than 5 fraudulent transactions
ORDER BY Fraudulent_Transactions DESC;

--   Identifying Suspicious Locations
-- Identify locations where fraudulent transactions are most common. This could help flag high-risk branches or areas for further investigation.
 SELECT Location, 
       COUNT(*) AS Fraud_Count,
       AVG(Transaction_Amount) AS Avg_Transaction_Amount
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Location
ORDER BY Fraud_Count DESC;








--  Analyzing Fraudulent Transactions by Merchant Type

-- Understanding fraud across different merchant categories helps a bank or financial institution track risky areas.

SELECT Merchant_Category, 
       COUNT(*) AS Fraudulent_Transactions,
       AVG(Transaction_Amount) AS Avg_Amount_Fraud
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Merchant_Category
ORDER BY Fraudulent_Transactions DESC;

-- Correlation Between Transaction Type and Fraud
-- Identify which transaction types are most commonly associated with fraudulent activity.
SELECT Transaction_Type, 
       COUNT(*) AS Fraud_Count,
       AVG(Transaction_Amount) AS Avg_Amount
FROM Advanced_Queries.financial_fraud_detection_excel_file
WHERE Fraud_Flag = 1
GROUP BY Transaction_Type
ORDER BY Fraud_Count DESC;

