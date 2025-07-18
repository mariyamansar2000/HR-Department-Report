CREATE DATABASE HR_DB;
USE hr_db;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

UPDATE hr
SET 

set sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE null
END;

SELECT hire_date from hr;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- UPDATE hr
-- SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%M:%s UTC'))
-- WHERE termdate IS NOT NULL AND termdate!='';

UPDATE hr
SET termdate = 
    CASE 
        WHEN termdate IS NULL OR termdate = '' OR termdate = '0000-00-00' THEN '0000-00-00'
        ELSE DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
    END;

select termdate from hr;

-- Check SQL mode
SELECT @@sql_mode;

-- Temporarily disable STRICT mode (use with caution)
SET sql_mode = '';

ALTER TABLE hr
MODIFY COLUMN termdate date;

ALTER TABLE hr ADD COLUMN AGE int;

UPDATE hr 
SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT age FROM hr;

SELECT min(age) AS youngest,
	   max(age) AS oldest
FROM hr;

SELECT COUNT(*) FROM hr
WHERE age<18;

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, count(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY gender;

-- 2. What is the athnicity breakdown of employees in the company?
SELECT race, count(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- 3. What is the age distribution of employees in the company?
SELECT min(age) AS youngest,
	   max(age) AS oldest
FROM hr
WHERE age>=18 and termdate='0000-00-00';

SELECT 
	CASE 
		WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
     END AS age_group,
     count(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY age_group
ORDER BY age_group;

-- 4. How gnder is distributed among age group
SELECT 
	CASE 
		WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
     END AS age_group,gender,
     count(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 5. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY location;

-- 6. What is the average length of employement for employees who have been terminated?
SELECT round(avg(datediff(termdate, hire_date))/365,0) AS avg_length_employment
FROM hr
WHERE termdate<=curdate() AND termdate<>'0000-00-00'AND age>=18;

-- 7. How does gender distribution vary across departments and job titles?
SELECT department, gender,COUNT(*) AS count
from hr 
WHERE age>=18 and termdate='0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 8. What is the distribution of job titles across the company?
SELECT jobtitle, count(*) AS count
from hr 
WHERE age>=18 and termdate='0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

SELECT * from hr;
-- 9. Which department has the highest turnover rate?
SELECT department,
	total_count,
	terminated_count,
	terminated_count/total_count AS termination_rate
FROM (
	SELECT department,
    count(*) AS total_count,
    SUM(CASE WHEN termdate<>'0000-00-00' AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminated_count
    from hr 
    WHERE age>=18
    GROUP BY department
    ) AS subquery
ORDER BY termination_rate DESC;

-- 10. What is the distribution of employees across locations by city and state?
SELECT location_state, COUNT(*) AS count
FROM hr
WHERE age>=18 and termdate='0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 11. How has thee company's employee count changed over time based on hire and term dates?
SELECT 
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    round((hires - terminations)/hires*100, 2) AS net_change_percent
FROM(
	SELECT
		YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate<>'0000-00-00' AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminations
	FROM hr
    WHERE age>=18
    GROUP BY year(hire_date)
) AS subquery
ORDER BY year ASC;

-- 12. What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate, hire_date)/365),0)AS avg_tenure
FROM hr
WHERE termdate <=curdate() AND termdate<>'000-00-00' AND age>=18
GROUP BY department;