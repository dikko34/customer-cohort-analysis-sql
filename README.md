
# 🧾 Customer Purchase Cohort Analysis (SQL)

## 🧩 Project Overview
This SQL project explores customer purchasing behavior by tracking first purchases, calculating days since sign-up, and organizing users into monthly cohorts. The goal is to help a business understand retention trends and lifecycle behavior.

## 🎯 Objectives
- Determine each customer's first purchase date
- Calculate days between signup and first order
- Segment users into cohorts based on first purchase month
- Visualize customer retention and re-order behavior over time

## 🗃️ Dataset
- `customers$`: customer_id, signup_date
- `orders$`: order_id, customer_id, order_date

## 🛠️ Tools & Skills
SQL Server, CTEs, `ROW_NUMBER()`, `DATEDIFF()`, `JOINS`, `GROUP BY`, `MONTH()`

## 🧠 Sample Query
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
- Most users placed their first order shortly after sign-up
- Repeat purchases dropped after the 3rd order
- Monthly cohort trends showed peak months for user engagement

---

## 📁 File Included



## 📫 Contact
Feel free to connect or collaborate with me on LinkedIn or GitHub!
