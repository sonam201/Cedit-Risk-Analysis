select * from credit_risk;
-- what is the default rate for each loan grad, and how many borrowers fall into each grade?

select loan_grade, count(*) as total_borrowers, round( avg(loan_status * 100) ::numeric,2)  as default_rate from credit_risk
group by loan_grade
order by loan_grade;

-- which loan intent category has the highest number of high-risk borowers(thoese who actually defaulted), and what percentage of each intent category defaulted?

select loan_intent, round(avg(loan_status * 100)::numeric,2) as category_defaulted_rate, COUNT(CASE WHEN loan_status = 1 THEN 1 END) AS number_of_defaulters from credit_risk
group by loan_intent
order by loan_intent;

-- what is the average income, average loan amount and average loan percent income for defaulters versus non-defaulters
select loan_status, round(avg(income)::numeric,2) as average_income, round(avg(loan_amnt)::numeric,2) as average_loan_amount, round(avg(loan_percent_income)::numeric,2) as average_loan_percent_income
from credit_risk
group by loan_status
order by loan_status;

-- Identify the top 10 highest risk borrowers- thoese who defaulted, have a prior default on file, and have the highest loan perdnt income."
select income, loan_amnt,loan_grade,cb_person_default_on_file, loan_percent_income, loan_status
from credit_risk
where loan_status = 1 and cb_person_default_on_file = 'Y'
order by loan_percent_income desc
limit 10;


-- Create a risk summary showing for each combination of loan grade and home ownership the total borrowers,
-- deafult rate and average income. Order by default rate desceding

Select loan_grade, home_ownership, count(*) as total_borrowers, round(avg(loan_status * 100)::numeric,2) as Default_rate, round(avg(income)::numeric,2) as average_income from credit_risk
group by loan_grade,home_ownership
HAVING COUNT(*) > 50
order by Default_rate desc;