USE employee_analysis;

SELECT *
FROM general_data;

-- Q1: How many active and inactive employee?
SELECT 
    Attrition, COUNT(Attrition) AS Count
FROM
    general_data
GROUP BY Attrition;

-- Q2: How many department in the company?
SELECT DISTINCT (Department)
FROM
    general_data;

-- Q3: How many job role in the company?
SELECT DISTINCT(JobRole)
FROM
    general_data;

-- Q4: How many active employee at each department and jon role 
SELECT 
    Department, JobRole, COUNT(Attrition) AS Count
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY Department, JobRole
ORDER BY Department, Count DESC;

-- Q5: Calculate min, max, and average of age's employee
SELECT 
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age,
    ROUND(AVG(Age)) AS Avg_Age
FROM
    general_data
WHERE
    Attrition = 'No';

-- Q6: Calculate average distance from home of each department
SELECT 
    Department,
    ROUND(AVG(DistanceFromHome), 3) AS AVG_Dist_From_Home,
    COUNT(Department) AS Count_Employee
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY Department
ORDER BY AVG_Dist_From_Home;

-- Q7: The number of active employee by gender 
SELECT 
    Gender, COUNT(Gender) AS Count
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY Gender;
 
-- Q8: The number of active employee by oef each department and job role by gender  
SELECT 
    Department, JobRole, Gender, COUNT(Gender) AS Count_Gender
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY Department , JobRole , Gender
ORDER BY Department , Count_Gender DESC;

-- Q9: The number of active employee in each job role  
SELECT 
    Department, JobRole, COUNT(JobRole) AS count
FROM
    general_data
GROUP BY Department , JobRole
ORDER BY Department , count DESC;

-- Q10: Calculate min, max, average of monthly income for each job role
SELECT 
    JobRole,
    MIN(MonthlyIncome) AS Min_Income,
    MAX(MonthlyIncome) AS Max_Income,
    AVG(MonthlyIncome) AS Avg_Income
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY JobRole
ORDER BY JobRole;

-- Q11: Eduaction Field for each Job role 
SELECT 
    EducationField, JobRole, Gender, COUNT(Gender) AS Count
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY EducationField , JobRole , Gender
ORDER BY EducationField ASC , Gender DESC;

-- Q12: Calculate min, mac, and average years employee works 
SELECT 
    JobRole,
    MAX(YearsAtCompany) AS MAX_Years_At_Company,
    ROUND(AVG(YearsAtCompany)) AS AVG_Years_At_Company
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY JobRole
ORDER BY YearsAtCompany;

-- Q13:Find the department with the largest number of employee with job level = 5 
SELECT 
    JobLevel, Department, COUNT(JobLevel) AS Count
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY JobLevel , Department
ORDER BY JobLevel DESC , Count DESC;

/*  Q14: Calculate percentage of active employee (female and male) 
by marital status
*/
SELECT 
    Gender,
    MaritalStatus,
    COUNT(MaritalStatus) AS Count,
    ROUND((COUNT(MaritalStatus) * 100.0 / (SELECT COUNT(MaritalStatus)
                FROM
                    general_data
                WHERE
                    Attrition = 'No')),2) AS Percentage
FROM
    general_data
WHERE
    Attrition = 'No'
GROUP BY Gender , MaritalStatus
ORDER BY Gender , Percentage DESC;

/* Q15: Calculate average environment satisfaction and average work life balance
of each department and job role and grouping age based on this condition: 
age <=25 is Teenage 
age <=45 is Adult 
age >45 is Old Adult  
*/
SELECT 
    gen.Department,
    gen.JobRole,
    gen.Age,
    CASE
        WHEN gen.Age <= 25 THEN 'Teenage'
        WHEN gen.Age <= 45 THEN 'Adult'
        ELSE 'Old Adult'
    END AS Age_Group,
    ROUND(AVG(emp.JobSatisfaction), 2) AS Avg_Environment_Satisfaction,
    ROUND(AVG(emp.WorkLifeBalance), 2) AS Avg_WorkLifeBalance
FROM
    general_data AS gen
        JOIN
    employee_survey_data AS emp ON gen.EmployeeID = emp.EmployeeID
GROUP BY gen.Department , gen.JobRole
ORDER BY gen.Department , Avg_Environment_Satisfaction DESC;


