
# Customer Purchase Cohort Analysis (SQL)

## Project Overview
This SQL project explores customer purchasing behavior by tracking first purchases, calculating days since sign-up, and organizing users into monthly cohorts. The goal is to help a business understand retention trends and lifecycle behavior.

## Objectives
- Determine each customer's first purchase date
- Calculate days between signup and first order
- Segment users into cohorts based on first purchase month
- Visualize customer retention and re-order behavior over time

##  Dataset
- `customers$`: customer_id, signup_date
- `orders$`: order_id, customer_id, order_date

##  Tools & Skills
SQL Server, CTEs, `ROW_NUMBER()`, `DATEDIFF()`, `JOINS`, `GROUP BY`, `MONTH()`

## Sample Query
```sql
SELECT *, DATEDIFF(DAY,signup_date,order_date)
FROM (
  SELECT Cus.customer_id, signup_date, order_date,
         ROW_NUMBER() OVER (PARTITION BY Cus.customer_id ORDER BY order_date) Row_num
  FROM customers$ Cus
  JOIN orders$ Ord ON Cus.customer_id = Ord.customer_id
) first_purchase
WHERE Row_num = 1;
```

## 📌 Key Insights
- Most users placed their first order within a short time of signing up, indicating a strong initial user intent and
effective onboarding.
- A noticeable drop-off in purchase frequency after the third order suggests room to improve customer
engagement and retention beyond early purchases.
- Monthly cohort analysis revealed patterns of user activity that can inform marketing strategies, such as
which months attract higher-quality users or stronger conversion rates.
- These insights enable the business to segment customers effectively, personalize follow-ups, and better
forecast future purchasing behavior based on signup cohorts.

---

## 📁 Customer_cohort_analysis.sql
https://github.com/dikko34/customer-cohort-analysis-sql/blob/main/Customer%20project.sql
