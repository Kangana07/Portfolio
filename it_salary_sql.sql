show databases;

use salary;

select * from 2018_it_cleaned;

select * from 2019_it_cleaned;

select * from 2020_it_cleaned;

alter table 2018_it_cleaned drop column column1;
alter table 2019_it_cleaned drop column column1;
alter table 2020_it_cleaned drop column column1;

#2018 dataset analysis 


#Avg salary by seniority level.
select seniority_level , AVG(current_salary) as avg_salary
from 2018_it_cleaned
group by seniority_level
order by avg_salary desc;

#Salary growth over time.
select position, 
       AVG(current_salary - salary_1_year_ago) as avg_growth_1_year, 
       AVG(current_salary - salary_2_years_ago) as avg_growth_2_years
from 2018_it_cleaned
group by position
order by avg_growth_1_year DESC;

#Stock options and salary.
select stock_options, AVG(current_salary) as avg_salary
from 2018_it_cleaned
group by stock_options;

#2019 dataset analysis


#Average salary and bonus by technology.
select main_technology, 
       AVG(current_salary) AS avg_salary, 
       AVG(bonus) AS avg_bonus
from 2019_it_cleaned
group by main_technology
order by avg_salary DESC;

#Vacation days and salary relationship.
select vacation_days, AVG(current_salary) AS avg_salary
from 2019_it_cleaned
group by vacation_days
order by vacation_days;

#Business sector insights.
select business_sector, AVG(current_salary) AS avg_salary
from 2019_it_cleaned
group by business_sector
order by avg_salary DESC;

#2020 dataset analysis

#Impact of covid on job status.
SELECT lost_job_due_to_covid, COUNT(*) AS affected_count
FROM 2020_it_cleaned
GROUP BY lost_job_due_to_covid;

#Salary and experience in germany.
SELECT experience_in_germany, AVG(current_salary) AS avg_salary
FROM 2020_it_cleaned
GROUP BY experience_in_germany
ORDER BY avg_salary DESC;

#Additional support received during covid.
SELECT additional_support, COUNT(*) AS support_count
FROM 2020_it_cleaned
GROUP BY additional_support
ORDER BY support_count DESC;


#Union salaries across years.
SELECT '2018' AS year, AVG(current_salary) AS avg_salary
FROM 2018_it_cleaned
UNION ALL
SELECT '2019', AVG(current_salary)
FROM 2019_it_cleaned
UNION ALL
SELECT '2020', AVG(current_salary)
FROM 2020_it_cleaned;

#Comparing senior levels across years.

SELECT seniority_level, current_salary, '2018' AS year
FROM 2018_it_cleaned
UNION ALL
SELECT seniority_level, current_salary, '2019' AS year
FROM 2019_it_cleaned
UNION ALL
SELECT seniority_level, current_salary, '2020' AS year
FROM 2020_it_cleaned;

#MISSING COLUMN YEAR.
SELECT *, '2018' AS year FROM 2018_it_cleaned;
SELECT *, '2019' AS year FROM 2019_it_cleaned;
SELECT *, '2020' AS year FROM 2020_it_cleaned;

#NULL VALUES IN CURRENT SALARY.
SELECT seniority_level, 
       AVG(CASE WHEN year = '2018' THEN current_salary END) AS avg_salary_2018,
       AVG(CASE WHEN year = '2019' THEN current_salary END) AS avg_salary_2019,
       AVG(CASE WHEN year = '2020' THEN current_salary END) AS avg_salary_2020
FROM (
    SELECT seniority_level, current_salary, '2018' AS year
    FROM 2018_it_cleaned
    UNION ALL
    SELECT seniority_level, current_salary, '2019' AS year
    FROM 2019_it_cleaned
    UNION ALL
    SELECT seniority_level, current_salary, '2020' AS year
    FROM 2020_it_cleaned
) AS combined_data
GROUP BY seniority_level
ORDER BY seniority_level;

#Gender pay gap.
SELECT year, gender, AVG(current_salary) AS avg_salary
FROM (
    SELECT gender, current_salary, '2018' AS year FROM 2018_it_cleaned
    UNION ALL
    SELECT gender, current_salary, '2019' AS year FROM 2019_it_cleaned
    UNION ALL
    SELECT gender, current_salary, '2020' AS year FROM 2020_it_cleaned
) AS combined_data
GROUP BY year, gender
ORDER BY year, gender;


#City_wise salary analysis.
SELECT year, city, AVG(current_salary) AS avg_salary
FROM (
    SELECT city, current_salary, '2018' AS year FROM 2018_it_cleaned
    UNION ALL
    SELECT city, current_salary, '2019' AS year FROM 2019_it_cleaned
    UNION ALL
    SELECT city, current_salary, '2020' AS year FROM 2020_it_cleaned
) AS combined_data
GROUP BY year, city
ORDER BY avg_salary DESC;















