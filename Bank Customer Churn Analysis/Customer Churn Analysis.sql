
create table bank_customer_churn 
(customer_id int,
credit_score int,
country varchar(15),
gender varchar(8),
age int,
tenure int,
balance float,
products_number int,
credit_card int,
active_member int,
estimated_salary float,
churn int)

--Overview of the dataset
SELECT * 
FROM bank_customer_churn
LIMIT 5;

--Are there any missing values in the dataset?
SELECT COUNT(DISTINCT customer_id) AS TOTAL_UNIQUE_RECORDS
FROM bank_customer_churn;

--Incorporating a new column named credit_score_category

ALTER TABLE bank_customer_churn
ADD COLUMN credit_score_category varchar(10);

UPDATE bank_customer_churn
SET credit_score_category = CASE
    WHEN credit_score >= 800 THEN 'Excellent'
    WHEN credit_score >= 740 THEN 'Very Good'
    WHEN credit_score >= 670 THEN 'Good'
    WHEN credit_score >= 580 THEN 'Fair'
    ELSE 'Poor'
  END ;

SELECT credit_score, credit_score_category
FROM bank_customer_churn
LIMIT 10;

--Modify the data type of the age_category column in the bank_customer_churn table to varchar(20). This allows for
--storing more descriptive category labels.
--Update the age_category values by categorizing customers based on their age ranges using a CASE statement. This enhances
--data organization and facilitates further analysis.
ALTER TABLE bank_customer_churn
ADD COLUMN age_category VARCHAR(20);

ALTER TABLE bank_customer_churn
ALTER COLUMN age_category TYPE VARCHAR(20);

UPDATE bank_customer_churn
SET age_category = CASE
    WHEN age < 18 THEN 'Minor'
    WHEN age >= 18 AND age < 30 THEN 'Young Adult'
    WHEN age >= 30 AND age < 50 THEN 'Middle-aged Adult'
    WHEN age >= 50 AND age < 65 THEN 'Mature Adult'
    ELSE 'Senior'
END;

--Exploratory Data Analysis (EDA)
--What is the distribution of the target variable (churn)?
--If you want to exclude NULL churn values:
SELECT
  churn,
  COUNT(*) AS tot,
  ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) || '%' AS churn_percentage
FROM bank_customer_churn
WHERE churn IS NOT NULL
GROUP BY churn
ORDER BY tot DESC;

--How do the input variables (credit score, age, balance, etc.) vary with respect to churn?
SELECT credit_score_category,COUNT(CASE WHEN churn=1 THEN 1 END ) AS tot_churn_customer
FROM bank_customer_churn
GROUP BY credit_score_category
ORDER BY tot_churn_customer DESC;

--Customer demographics analysis
--What is the distribution of customers by country?
SELECT country,COUNT(*) AS TOT_CUSTOMER
FROM bank_customer_churn
GROUP BY country
ORDER BY TOT_CUSTOMER DESC;

--How does churn vary across different demographic groups?
SELECT country,COUNT(CASE WHEN churn=1 THEN 1 END ) AS tot_churn_customer
FROM bank_customer_churn
GROUP BY country
ORDER BY tot_churn_customer DESC;

--Product and service analysis:
--What is the distribution of customers by the number of products they have?
SELECT products_number,COUNT(*) AS tot_customer
FROM bank_customer_churn
GROUP BY products_number
ORDER BY tot_customer DESC;

--How does churn vary based on the number of products a customer has?
SELECT products_number,tot_churn_customer,tot_customer,
concat(round((tot_churn_customer / tot_customer) * 100,1),' %') AS churn_rate FROM
(SELECT products_number,COUNT(CASE WHEN churn=1 THEN 1 END ) AS tot_churn_customer,COUNT(*) AS tot_customer
FROM bank_customer_churn
GROUP BY products_number
ORDER BY tot_churn_customer DESC) AS x;

--Customer behavior analysis:
--How does tenure (length of time as a customer) vary with churn?
SELECT tenure,COUNT(CASE WHEN churn=1 THEN 1 END ) AS tot_churn_customer
FROM bank_customer_churn
GROUP BY tenure
ORDER BY tot_churn_customer DESC;

--Do active members have lower churn rates compared to inactive members?
SELECT active_member,CONCAT(round(tot_churn_customer/tot,2) * 100,'%') AS churn_rates FROM(
SELECT active_member,COUNT(CASE WHEN churn=1  THEN 1 END ) AS tot_churn_customer,
COUNT(*) tot
FROM bank_customer_churn
GROUP BY active_member
ORDER BY active_member DESC) x;

--Are there any specific customer segments that are more prone to churn, and how can the bank address their needs?
     WITH churn_data AS (
  SELECT credit_score_category,
         COUNT(CASE WHEN churn = 0 and active_member=0 THEN 1 END) AS tot
  FROM bank_customer_churn
  GROUP BY credit_score_category
)
SELECT
  credit_score_category,tot,
  round(tot * 100.0 / SUM(tot) OVER (),2) AS per
FROM churn_data
ORDER BY tot DESC;

