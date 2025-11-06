# 💳 Bank Customer Churn Analysis — SQL Project  

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue?logo=postgresql&logoColor=white)  
![SQL](https://img.shields.io/badge/Language-SQL-lightgrey?logo=sqlite&logoColor=white)  
![Status](https://img.shields.io/badge/Project_Status-Completed-brightgreen)  
![Author](https://img.shields.io/badge/Author-Ben%20Jose-orange)  

---

### 📘 **Overview**  
This project analyzes customer churn patterns using the **Bank Customer Churn Prediction.csv** dataset.  
It explores how customer demographics, credit behavior, and engagement levels influence the likelihood of churn in a banking context.  

The goal is to help the bank identify **key churn drivers**, segment customers, and design **retention strategies** using SQL-based analysis.  

---

### 🗂️ **Project File**
📄 `Customer Churn Analysis.sql`  

Includes:  
- Table creation and data loading  
- Feature engineering (`credit_score_category`, `age_category`)  
- Exploratory Data Analysis (EDA)  
- Churn distribution and segmentation  
- Business insights and interpretation  

---

### 🧱 **Database Schema**
**Table:** `bank_customer_churn`  

| Column | Type | Description |
|:--|:--|:--|
| customer_id | INT | Unique customer identifier |
| credit_score | INT | Customer credit score |
| country | VARCHAR(15) | Country of residence |
| gender | VARCHAR(8) | Customer gender |
| age | INT | Customer’s age |
| tenure | INT | Years with the bank |
| balance | FLOAT | Account balance |
| products_number | INT | Number of products owned |
| credit_card | INT | Has a credit card (1 = Yes, 0 = No) |
| active_member | INT | Active membership (1 = Active, 0 = Inactive) |
| estimated_salary | FLOAT | Annual estimated salary |
| churn | INT | Customer churn indicator (1 = Yes, 0 = No) |

---

### 🔍 **Business Context & Value**

The **Bank Customer Churn Prediction dataset** represents real-world banking customer records.  
Analyzing churn helps the bank:
- Identify **high-risk segments** likely to leave.  
- Develop **targeted retention offers** for valuable customers.  
- Improve **customer engagement strategies** for inactive members.  
- Optimize **cross-selling** by linking product ownership with churn risk.  

---

### 🧩 **Feature Engineering**

#### 🧠 Credit Score Category  
Added a new column `credit_score_category` to group customers by credit health:  
- Excellent (≥800)  
- Very Good (740–799)  
- Good (670–739)  
- Fair (580–669)  
- Poor (<580)  

#### 👥 Age Category  
Created an `age_category` column to segment customers demographically:  
- Minor (<18)  
- Young Adult (18–29)  
- Middle-aged Adult (30–49)  
- Mature Adult (50–64)  
- Senior (≥65)  

These derived features make it easier to analyze churn patterns by demographic and financial behavior.

---

### 📊 **Exploratory Data Analysis (EDA)**

#### 1️⃣ **Target Variable Distribution**
```sql
SELECT
  churn,
  COUNT(*) AS total,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) || '%' AS churn_percentage
FROM bank_customer_churn
WHERE churn IS NOT NULL
GROUP BY churn
ORDER BY total DESC;
