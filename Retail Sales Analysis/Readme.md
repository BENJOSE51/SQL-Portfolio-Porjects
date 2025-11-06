# 🛒 Retail Sales Analysis — SQL Project  

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue?logo=postgresql&logoColor=white)  
![SQL](https://img.shields.io/badge/Language-SQL-lightgrey?logo=sqlite&logoColor=white)  
![Status](https://img.shields.io/badge/Project_Status-Completed-brightgreen)  
![Author](https://img.shields.io/badge/Author-Ben%20Jose-orange)  

---

### 📘 **Overview**  
This project explores and analyzes retail sales data using **SQL** to uncover actionable business insights.  
It demonstrates practical SQL skills in **data cleaning, aggregation, filtering, joins, and window functions**, performed on a **PostgreSQL** database.  

---

### 🗂️ **Project File**
📄 `Retail Sales Analysis.sql`  

Includes:  
- Database & table creation  
- Data cleaning & null handling  
- Exploratory queries  
- KPI & category-based analysis  
- Time and customer segmentation  

---

### 🧱 **Database Schema**
**Table:** `retail_sales`  

| Column | Type | Description |
|:--|:--|:--|
| transactions_id | INT (PK) | Unique transaction ID |
| sale_date | DATE | Date of sale |
| sale_time | TIME | Time of sale |
| customer_id | INT | Customer identifier |
| gender | VARCHAR(10) | Gender of customer |
| age | INT | Customer’s age |
| category | VARCHAR(35) | Product category |
| quantity | INT | Quantity purchased |
| price_per_unit | FLOAT | Price per unit |
| cogs | FLOAT | Cost of goods sold |
| total_sale | FLOAT | Total sale value |

---

### 🧹 **Data Exploration & Cleaning**
- Counted total records and unique customers  
- Retrieved all unique product categories  
- Checked and deleted null records to ensure data consistency  

---

### 📊 **Data Analysis & Insights**

#### 🧾 1. Sales Overview  
- Retrieve all transactions for a specific date (`2022-11-05`)  
- Identify top-selling product categories and total orders  

#### 👕 2. Category Analysis  
- Total sales and orders by category  
- Transactions where category = *Clothing* and quantity ≥ 4  

#### 🧍 3. Customer Insights  
- Average age of customers in the *Beauty* category  
- Top 5 customers based on total purchase value  
- Unique customer count per category  

#### ⏰ 4. Time-Based Insights  
- Determined best-selling month per year using **window functions**  
- Segmented orders by **shift** — Morning, Afternoon, and Evening  

#### 🚻 5. Gender-Based Patterns  
- Count of transactions by gender within each product category  

---

### 💡 **Key Learnings**
- SQL data cleaning and integrity checks  
- Aggregations using **SUM, AVG, COUNT**  
- Use of **CASE**, **RANK()**, and **window functions**  
- Grouping data for category and time-based insights  
- Building modular, readable SQL queries  

---

### 🛠️ **Tech Stack**
| Tool | Purpose |
|------|----------|
| **PostgreSQL** | Database engine |
| **SQL** | Query language |
| **pgAdmin / VS Code** | Query execution and testing |

---

### 🧩 **Example Query Snippets**

```sql
-- Total sales by category
SELECT 
    category,
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY net_sale DESC;
