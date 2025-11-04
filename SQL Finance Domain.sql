-- Checking The Raw Data
select * from bank_loan_data

-- Total Loan Applications  
select COUNT(id) as Total_Loan_Applications from bank_loan_data

-- PMTD Total Loan Applications  
select COUNT(id) as PMTD_Total_Loan_Applications from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- Total Funded Amount
select SUM(loan_amount) as Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021 

-- PMTD Total Funded Amount
select SUM(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021 

-- Total Amount Recieved 
select SUM(total_payment) as Total_Amount_Recieved from bank_loan_data

-- MTD Total Amount Recieved 
select SUM(total_payment) as MTD_Total_Amount_Recieved from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- PMTD Total Amount Recieved 
select SUM(total_payment) as PMTD_Total_Amount_Recieved from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

-- MTD Avg Interest Rate
select ROUND(AVG(int_rate), 4) * 100 as MTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- PMTD Avg Interest Rate
select ROUND(AVG(int_rate), 4) * 100 as PMTD_Avg_Interest_Rate from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

-- MTD Avg DTI 
select ROUND(AVG(dti), 4) * 100 as MTD_Avg_DTI from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- PMTD Avg DTI 
select ROUND(AVG(dti), 4) * 100 as PMTD_Avg_DTI from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

-- Good Loan Application Percentage
select 
(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100)
/
COUNT(id) as Good_loan_percentage
from bank_loan_data

-- Good Loan Applications
select COUNT(id) as Good_Loan_Applications from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Good Loan Funded Amount
select SUM(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Good Loan Total Recieved Amount
select SUM(total_payment) as Good_Loan_Recieved_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Bad Loan Applications
select COUNT(id) as Bad_Loan_Applications from bank_loan_data
where loan_status = 'Charged Off'

-- Bad Loan Funded Amount
select SUM(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off'

-- Bad Loan Total Amount Recieved
select SUM(total_payment) as Bad_Loan_Amount_Recieved from bank_loan_data
where loan_status = 'Charged Off'

-- Loan Status
select 
loan_status,
COUNT(id) as Total_Loan_Applications,
SUM(total_payment) as Total_Amount_Recieved,
SUM(loan_amount) as Total_Funded_Amount,
AVG(int_rate * 100) as Interest_Rate,
AVG(dti * 100) as dti
from
bank_loan_data
group by
loan_status

-- Loan Status For Month
select 
loan_status,
SUM(total_payment) as MTD_Total_Amount_Recieved,
SUM(loan_amount) as MTD_Total_Funded_Amount
from bank_loan_data
where MONTH(issue_date) = 12
group by loan_status

-- Monthly Trends by Issue Date
select 
MONTH(issue_date) as Month_Number,
DATENAME(MONTH, issue_date),
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by MONTH(issue_date), DATENAME(MONTH, issue_date)
order by MONTH(issue_date)

-- Regional Analysis by State
select 
address_state,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by address_state
order by COUNT(id) DESC

-- Loan Term Analysis
select 
term,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by term
order by term DESC

-- Employee Length Analysis
select 
emp_length,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by emp_length
order by COUNT(id) DESC

-- Loan Purpose Breakdown
select 
purpose,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by purpose
order by COUNT(id) DESC

-- Home Ownership Analysis
select 
home_ownership,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) as Total_Funded_Amount,
SUM(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by home_ownership
order by COUNT(id) DESC