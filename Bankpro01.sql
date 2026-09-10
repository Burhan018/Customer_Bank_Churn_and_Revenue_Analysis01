CREATE DATABASE bank_analytics;
USE bank_analytics;

CREATE TABLE bank_customers (
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(15),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15, 2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary DECIMAL(15, 2),
    Churn INT
);

SELECT COUNT(*) FROM bank_customers;

 --# Executive Summary & Core Financials
 
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(Churn) AS Total_Churned,
    ROUND((SUM(Churn) / COUNT(*)) * 100, 2) AS Churn_Rate_Pct,
    ROUND(SUM(Balance), 2) AS Total_Deposits,
    ROUND(AVG(Balance), 2) AS Avg_Balance,
    ROUND(AVG(EstimatedSalary), 2) AS Avg_Salary
FROM bank_customers;


--# Country-Wise Financial & Churn Breakdown

SELECT 
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    ROUND((SUM(Churn) / COUNT(*)) * 100, 2) AS Regional_Churn_Rate,
    ROUND(SUM(Balance), 2) AS Total_Regional_Deposits,
    ROUND(AVG(Balance), 2) AS Avg_Customer_Balance
FROM bank_customers
GROUP BY Geography
ORDER BY Regional_Churn_Rate DESC;

  --# product holding
  SELECT 
    NumOfProducts,
    COUNT(*) AS Customer_Count,
    SUM(Churn) AS Churned_Count,
    ROUND((SUM(Churn) / COUNT(*)) * 100, 2) AS Churn_Rate_Pct,
    ROUND(AVG(Balance), 2) AS Avg_Balance
FROM bank_customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

 --# High-Balance Churn Risk (Accounts > $100k)
 
 SELECT 
    Churn,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(CreditScore), 0) AS Avg_Credit_Score,
    ROUND(AVG(Age), 1) AS Avg_Age,
    ROUND(AVG(Balance), 2) AS Avg_Balance
FROM bank_customers
WHERE Balance > 100000
GROUP BY Churn;

