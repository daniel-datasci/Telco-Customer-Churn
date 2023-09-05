create database Telco_Company;

use Telco_Company;


/* DATA EXPLORATION */
/*========================================*/
/* visualizing the number of customers by gender */
select gender, count(*) as Customers
from telco
group by gender;


/* Q1 - What is the overall churn rate for the telecommunications company ? */

/* add new columns called retained and churned to make the calculations easy */
alter table telco
add Retained int;

alter table telco
add Churned int;

/* use the case and when function to group customers into these columns */
update telco
set Retained = CASE
	WHEN Churn = 0 THEN 1
	ELSE 0
END;

update telco
set Churned = CASE
	WHEN Churn = 1 THEN 1
	ELSE 0
END;

/* calculating the percentage */
SELECT (CAST(SUM(Churned) AS DECIMAL) / COUNT(*)) * 100 AS Churn_rate, (CAST(SUM(Retained) AS DECIMAL) / COUNT(*)) * 100 AS Retained_rate
from telco;
/*========================================*/
/*  Q2 - what is the ratio between males and females in the company? */
SELECT
    (CAST(SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*)) * 100 AS Male_ratio,
    (CAST(SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*)) * 100 AS Female_ratio
FROM telco;

/*========================================*/
/*  Q3 - how many Internet Services we provide in our company? */
select InternetService, COUNT(InternetService) as Number
from telco
group by InternetService;
/*========================================*/
/*  Q4 - what is our Contract types we provide? */
select Contract, COUNT(Contract) as Number
from telco
group by Contract;
/*========================================*/
/*  Q5 - how many customers uses StreamingTV? */
/* First we need to update the StreamingTV column by changing 0s and 1s to Yes and No */
alter table telco
alter column StreamingTV nvarchar(10);

update telco
set StreamingTV = CASE
	WHEN StreamingTV = 0 THEN 'No'
	ELSE 'Yes'
END;
/* getting StreamingTV count */
select StreamingTV, count(StreamingTV) as Number
from telco
group by StreamingTV;
/*========================================*/
/*  Q6 - what is the ratio between users who streaming movies to StreamingTV subscribers? */
/* First we need to update the StreamingMovies column by changing 0s and 1s to Yes and No */
alter table telco
alter column StreamingMovies nvarchar(10);

update telco
set StreamingMovies = CASE
	WHEN StreamingMovies = 0 THEN 'No'
	ELSE 'Yes'
END;
/* calculating the ratio */
SELECT
    (CAST(SUM(CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*)) * 100 AS Movies_ratio,
    (CAST(SUM(CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*)) * 100 AS TV_ratio
FROM telco;
/*========================================*/
/*  Q7 - Is there a strong relationship between the monthly recharge rate and the dependents? */
/* First we need to update the Dependents column by changing 0s and 1s to Yes and No */
alter table telco
alter column Dependents nvarchar(10);

update telco
set Dependents = CASE
	WHEN Dependents = 0 THEN 'No'
	ELSE 'Yes'
END;

SELECT Dependents, AVG(MonthlyCharges) AS Average_monthly_charges
FROM telco
GROUP BY Dependents;
/*========================================*/
/*  Q8 - who is the the most important customer in the company according to Monthly and Total charges? */
SELECT top 1 customerID, MonthlyCharges, TotalCharges
FROM telco
ORDER BY MonthlyCharges DESC, TotalCharges DESC;
/*========================================*/
/*  Q9 - how many payment methods we provide? and what is the ratio between each others? */
select PaymentMethod, (cast(count(PaymentMethod) as decimal) / 7043) * 100 as Ratio
from telco
group by PaymentMethod;




