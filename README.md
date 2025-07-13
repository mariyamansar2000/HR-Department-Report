# HR-Department-Report
<img width="1392" height="805" alt="Screenshot 2025-07-13 120114" src="https://github.com/user-attachments/assets/f1f4594c-2917-4790-8008-318ecab1f1d8" />
<img width="1391" height="801" alt="image" src="https://github.com/user-attachments/assets/c240e561-5395-4067-8e37-4b8a21159ea0" />

# Data Used

**Data:** HR Data with over 22000 rows from the year 2000 to 2020.

**Data Cleaning and Analysis:** My SQL, Jupyter Notebook(sql magic)

**Data Visualization** Power BI

# Questions

1. What is the gender breakdown of employees in the company?
2. What is the athnicity breakdown of employees in the company?
3. What is the age distribution of employees in the company?
4. How gender is distributed among age group?
5. How many employees work at headquarters versus remote locations?
6. What is the average length of employement for employees who have been terminated?
7. How does gender distribution vary across departments and job titles?
8. What is the distribution of job titles across the company?
9. Which department has the highest turnover rate?
10. What is the distribution of employees across locations by city and state?
11. How has thee company's employee count changed over time based on hire and term dates?
12. What is the tenure distribution for each department?

# Findings

1. There are more male employees.
2. White race is the most dominant while Native Hawaiian and American Indian are the least dominant.
3. The youngest employee is 20 years old and the oldest is 57 years old.
4. 5 age groups were created (18–24, 25–34, 35–44, 45–54, 55–64). A large number of employees were between 25–34 followed by 35–44 while the smallest group was 55–64.
5. A large number of employees work at the headquarters versus remotely.
6. The average length of employment for terminated employees is around 7 years.
7. The gender distribution across departments is fairly balanced but there are generally more male than female employees.
8. The Marketing department has the highest turnover rate followed by Training. The least turnover rate is in the Research and Development, Support, and Legal departments.
9. A large number of employees come from the state of Ohio.
10. The net change in employees has increased over the years.
11. The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales, and Marketing having the lowest.

# Limitations
1. Some records had negative ages and these were excluded during querying(967 records). Ages used were 18 years and above.
2. Some termdates were far into the future and were not included in the analysis(1599 records). The only term dates used were those less than or equal to current date.
