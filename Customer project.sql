

SELECT *
FROM customers$

SELECT *
FROM orders$


--Task 1: Identify First Purchase Per Customer

SELECT *, DATEDIFF(DAY,signup_date,order_date)
FROM
(SELECT Cus.customer_id,signup_date,order_date, ROW_NUMBER () OVER (PARTITION BY 
																	Cus.customer_id
																	ORDER BY order_date) Row_num
FROM customers$ Cus
JOIN orders$ Ord
	ON Cus.customer_id = Ord.customer_id) first_purchase
WHERE Row_num = 1

--Task 2: Days Since first purchase

WITH Cohort_Monthly AS
(
SELECT customer_id,MIN(order_date) first_purchase
FROM orders$
GROUP BY customer_id
)
, Cohort_Diff AS
(
SELECT Ord.customer_id,order_id,order_date,first_purchase,DATEDIFF(DAY,first_purchase,order_date) Days_since_first,
ROW_NUMBER () OVER(PARTITION BY Ord.customer_id ORDER BY order_date ) Row_num
FROM orders$ Ord
JOIN Cohort_Monthly Cm
	ON Ord.customer_id = Cm.customer_id
)
SELECT customer_id,Order_id,
CASE
	WHEN Row_num = 1 THEN '1st_order'
	WHEN Row_num = 2 THEN '2nd_order'
	WHEN Row_num = 3 THEN '3rd_order'
END order_No,order_date,first_purchase,Days_since_first
FROM Cohort_Diff;

--Task 3: Create Monthly Cohorts

WITH First_Purchase AS 
(
SELECT customer_id,MIN(order_date) First_Purchase
FROM orders$
GROUP BY customer_id
), Cohort_month AS
(
SELECT Ord.customer_id,Month(First_Purchase) Fp_month,Month(ord.order_date)order_month
FROM orders$ ord
JOIN First_Purchase Fp
	ON ord.customer_id = Fp.customer_id
)
SELECT Fp_month,order_month,COUNT(DISTINCT(Customer_ID)) ActiveUsers
FROM Cohort_month
GROUP BY Fp_month,order_month;

