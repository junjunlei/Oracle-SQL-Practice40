--1. Show all data for clerks hired after the year 1997.
SELECT *
FROM employees
WHERE job_id = 'ST_CLERK'
AND hire_date > '31-DEC-1997';
--2. Show the last name, job, salary, and commission of those employees who earn commission. Sort the data by the salary in descending order.
SELECT last_name, job_id, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC;
--3. Show the employees who have no commission, but have a 10% raise in their salary (round off the salaries).
select 'the salary of ' || last_name || ' after a 10% raise is ' || round(salary * 1.10) "New salary"
  from employees
 where commission_pct is null;
--4. Show the last names of all employees together with the number of years and the number of completed months that they have been employed.
SELECT last_name, 
TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) YEARS, 
TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, hire_date), 12)) 
MONTHS
FROM employees;
--5. Show those employees that have a name starting with J, K, L, or M.
SELECT last_name 
FROM employees
WHERE SUBSTR(last_name, 1,1) IN ('J', 'K', 'L', 'M');

--6. Show all employees, and indicate with ※Yes§ or ※No§ whether they receive a commission.
SELECT last_name, salary,
decode(commission_pct, NULL, 'No', 'Yes') commission
FROM employees;

--7. Show the department names, locations, names, job titles, and salaries of employees who work
in location 1800.
SELECT d.department_name, d.location_id,
e.last_name, e.job_id, e.salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.location_id = 1800;
--8. How many employees have a name that ends with an ※n§? Create two possible solutions.
SELECT COUNT(*)
FROM employees
WHERE last_name LIKE '%n';
SELECT COUNT(*)
FROM employees
WHERE SUBSTR(last_name, -1) = 'n';
--9. Show the names and locations for all departments and the number of employees working in each department. Make sure that departments without employees are included as well.
SELECT d.department_id, d.department_name, 
d.location_id, COUNT(e.employee_id)
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id
GROUP BY d.department_id, d.department_name, d.location_id;

--10. Which jobs are found in departments 10 and 20?
SELECT DISTINCT job_id
FROM employees 
WHERE department_id IN (10, 20);
--11. Which jobs are found in the administrative and executive departments, and how many employees do these jobs? Show the job with the highest frequency first.
SELECT e.job_id, count(e.job_id) FREQUENCY
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_name IN ('Administration', 'Executive')
GROUP BY e.job_id
ORDER BY FREQUENCY DESC;

--12. Show all employees who were hired in the first half of the month (before the 16th of the month).
SELECT last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'DD') < 16;

--13. Show the names, salaries, and the number of dollars (in thousands) that each employee earns.
SELECT last_name, salary, TRUNC(salary, -3)/1000 Thousands
FROM employees;

--14. Show all employees who have managers with a salary higher than $15,000. Show thefollowing data: employee name, manager name, manager salary, and salary grade of the manager.

SELECT e.last_name, m.last_name manager, m.salary, 
j.grade_level
FROM employees e, employees m, job_grades j
WHERE e.manager_id = m.employee_id
AND m.salary BETWEEN j.lowest_sal AND j.highest_sal
AND m.salary > 15000;

/*15. Show the department number, name, number of employees, and average salary of all 
departments, together with the names, salaries, and jobs of the employees working in each 
department.*/
BREAK ON department_id -
ON department_name ON employees ON avg_sal SKIP 1
SELECT d.department_id, d.department_name, 
count(e1.employee_id) employees,
NVL(TO_CHAR(AVG(e1.salary), '99999.99'),
'No average' ) avg_sal,
e2.last_name, e2.salary, e2.job_id
FROM departments d, employees e1, employees e2
WHERE d.department_id = e1.department_id(+)
AND d.department_id = e2.department_id(+)
GROUP BY d.department_id, d.department_name, 
e2.last_name, e2.salary, e2.job_id
ORDER BY d.department_id, employees;
CLEAR BREAKS
--16. Show the department number and the lowest salary of the department with the highest average salary.
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id);
--17. Show the department numbers, names, and locations of the departments where no sales representatives work.
SELECT *
FROM departments
WHERE department_id NOT IN(SELECT department_id
FROM employees
WHERE job_id = 'SA_REP'
AND department_id IS NOT NULL);
--18. Show the department number and name, and the number of employees working in each department that:
-- a. Has fewer than three employees:
SELECT d.department_id, d.department_name, COUNT(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(*) < 3;
--b. Has the highest number of employees:
SELECT d.department_id, d.department_name, COUNT(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees
GROUP BY department_id);
--c. Has the lowest number of employees: 
SELECT d.department_id, d.department_name, COUNT(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(*) = (SELECT MIN(COUNT(*))
FROM employees
GROUP BY department_id);

--19. Show the employee number, last name, salary, department number, and the average salary in their department for all employees.
SELECT e.employee_id, e.last_name,
e.department_id, AVG(s.salary)
FROM employees e, employees s
WHERE e.department_id = s.department_id
GROUP BY e.employee_id, e.last_name, e.department_id;

--20. Show all employees who were hired on the day of the week on which the highest number of employees were hired.
SELECT last_name, TO_CHAR(hire_date, 'DAY') day
FROM employees
WHERE TO_CHAR(hire_date, 'Day') = 
(SELECT TO_CHAR(hire_date, 'Day')
FROM employees
GROUP BY TO_CHAR(hire_date, 'Day')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
FROM employees
GROUP BY TO_CHAR(hire_date, 'Day')));

/*21. Create an anniversary overview based on the hire date of the employees. Sort the anniversaries 
in ascending order.*/
SELECT last_name, TO_CHAR(hire_date, 'Month DD') BIRTHDAY 
FROM employees
ORDER BY TO_CHAR(hire_date, 'DDD');

-- 22. Find the job that was filled in the first half of 1990 and the same job that was filled during the same period in 1991.
SELECT job_id
FROM employees
WHERE hire_date 
BETWEEN '01-JAN-1990' AND '30-JUN-1990'
INTERSECT
SELECT job_id
FROM employees
WHERE hire_date BETWEEN '01-JAN-1991'
AND '30-JUN-1991';
/* 23. Write a compound query to produce a list of employees showing raise percentages, employee 
IDs, and old salary, and new salary increase. Employees in departments 10, 50, and 110 are given 
a 5% raise, employees in department 60 are given a 10% raise, employees in departments 20 and 
80 are given a 15% raise, and employees in department 90 are not given a raise. */
SELECT '05% raise' raise, employee_id, salary, 
salary *.05 new_salary
FROM employees
WHERE department_id IN (10,50, 110)
UNION
SELECT '10% raise', employee_id, salary, salary * .10
FROM employees
WHERE department_id = 60
UNION
SELECT '15% raise', employee_id, salary, salary * .15 
FROM employees
WHERE department_id IN (20, 80)
UNION
SELECT 'no raise', employee_id, salary, salary
FROM employees
WHERE department_id = 90;

-- 24. Alter the session to set the NLS_DATE_FORMAT to DD-MON-YYYY HH24:MI:SS.

ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

--25. a. Write queries to display the time zone offsets (TZ_OFFSET), for the following time zones.

/* 每 Australia/Sydney  */
SELECT TZ_OFFSET ('Australia/Sydney') from dual;
/* 每 Chile/EasterIsland  */
SELECT TZ_OFFSET ('Chile/EasterIsland') from dual;
/* b. Alter the session to set the TIME_ZONE parameter value to the time zone offset of 
Australia/Sydney. */
ALTER SESSION SET TIME_ZONE = '+10:00';
/* c. Display the SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP, and LOCALTIMESTAMP
for this session. 
Note: The output might be different based on the date when the command is executed. */
SELECT SYSDATE,CURRENT_DATE, 
CURRENT_TIMESTAMP, LOCALTIMESTAMP
FROM DUAL;
/* d. Alter the session to set the TIME_ZONE parameter value to the time zone offset of 
Chile/EasterIsland. */
ALTER SESSION SET TIME_ZONE = '-06:00';
Introduction to Oracle9i: SQL Additional Practices Solutions-9
/* e. Display the SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP, and 
LOCALTIMESTAMP for this session. 
Note: The output might be different based on the date when the command is executed. */
SELECT SYSDATE,CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP
FROM DUAL;
/* f. Alter the session to set the NLS_DATE_FORMAT to DD-MON-YYYY. */
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY';
/* Note: Observe in the preceding question that CURRENT_DATE, CURRENT_TIMESTAMP, and
LOCALTIMESTAMP are all sensitive to the session time zone. Observe that SYSDATE is not 
sensitive to the session time zone.
Note: The results of the preceding question are based on a different date, and in some cases they 
will not match the actual results that the students get. Also the time zone offset of the various 
countries might differ, based on daylight savings time. */

/*26. Write a query to display the last names, month of the date of join, and hire date of those employees 
who have joined in the month of January, irrespective of the year of join. */
SELECT last_name, EXTRACT (MONTH FROM HIRE_DATE),HIRE_DATE
FROM employees
WHERE EXTRACT (MONTH FROM HIRE_DATE) = 1; 

/* 27. Write a query to display the following for those departments whose department ID is greater than 80:
每 The total salary for every job within a department 
每 The total salary 
每 The total salary for those cities in which the departments are located
每 The total salary for every job, irrespective of the department 
每 The total salary for every department irrespective of the city
每 The total salary of the cities in which the departments are located
每 Total salary for the departments, irrespective of job titles and cities  
*/
COLUMN city FORMAT A25 Heading CITY
COLUMN department_name FORMAT A15 Heading DNAME
COLUMN job_id FORMAT A10 Heading JOB
COLUMN SUM(salary) FORMAT $99,99,999.00 Heading SUM(SALARY)
SELECT l.city,d.department_name, e.job_id, SUM(e.salary)
FROM locations l,employees e,departments d
WHERE d.location_id = l.location_id
AND e.department_id = d.department_id
AND e.department_id > 80
GROUP BY CUBE( l.city,d.department_name, e.job_id);


/* 28. Write a query to display the following groupings:
每 Department ID, Job ID
每 Job ID, Manager ID 
The query should calculate the maximum and minimum salaries for each of these groups.  */
SELECT department_id, job_id, manager_id,max(salary),min(salary)
FROM employees
GROUP BY GROUPING SETS
((department_id,job_id), (job_id,manager_id));

/* 29. Write a query to display the top three earners in the EMPLOYEES table. Display their last names 
and salaries.  */
SELECT last_name, salary
FROM employees e
WHERE 3 > (SELECT COUNT(*)
FROM employees
WHERE e.salary < salary);

/*30. Write a query to display the employee ID and last names of the employees who work in the state of 
California. 
Hint: Use scalar subqueries. 
*/
SELECT employee_id, last_name
FROM employees e
WHERE ((SELECT location_id
FROM departments d
WHERE e.department_id = d.department_id )
IN (SELECT location_id
FROM locations l
WHERE STATE_province = 'California'));

/* 31. Write a query to delete the oldest JOB_HISTORY row of an employee by looking up the 
JOB_HISTORY table for the MIN(START_DATE) for the employee. Delete the records of only
those employees who have changed at least two jobs. If your query executes correctly, you will get 
the following feedback:
Hint: Use a correlated DELETE command.   
*/
DELETE FROM job_history JH
WHERE employee_id =
(SELECT employee_id 
FROM employees E
WHERE JH.employee_id = E.employee_id
AND START_DATE = (SELECT MIN(start_date)
FROM job_history JH
WHERE JH.employee_id = E.employee_id)
AND 3 > (SELECT COUNT(*) 
FROM job_history JH
WHERE JH.employee_id = E.employee_id
GROUP BY EMPLOYEE_ID
HAVING COUNT(*) >= 2));

--32. Roll back the transaction. 

ROLLBACK;

/* 33. Write a query to display the job IDs of those jobs whose maximum salary is above half the 
maximum salary in the whole company. Use the WITH clause to write this query. Name the 
query MAX_SAL_CALC.  */
WITH 
MAX_SAL_CALC AS (
SELECT job_title, MAX(salary) AS job_total
FROM employees, jobs
WHERE employees.job_id = jobs.job_id
GROUP BY job_title)
SELECT job_title, job_total
FROM MAX_SAL_CALC
WHERE job_total > (SELECT MAX(job_total) * 1/2
FROM MAX_SAL_CALC)
ORDER BY job_total DESC;

/* 34. Write a SQL statement to display employee number, last name, start date, and salary, showing:
a. De Haan's direct reports  */
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE manager_id = (SELECT employee_id
FROM employees
WHERE last_name = 'De Haan');
/*
b. The organization tree under De Haan (employee number 102)
*/
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE employee_id != 102
CONNECT BY manager_id = PRIOR employee_id
START WITH employee_id = 102;
/* 35. Write a hierarchical query to display the employee number, manager number, and employee last 
name for all employees who are two levels below employee De Haan (employee number 102). 
Also display the level of the employee.
*/
SELECT employee_id, manager_id, level, last_name
FROM employees
WHERE LEVEL = 3
CONNECT BY manager_id = PRIOR employee_id
START WITH employee_id= 102;

/* 36. Produce a hierarchical report to display employee number, manager number, the LEVEL
pseudocolumn, and employee last name. For every row in the EMPLOYEES table, you should print a 
tree structure showing the employee, the employee's manager, then the manager's manager, and so 
on. Use indentations for the NAME column.
COLUMN name FORMAT A25 
*/
SELECT employee_id, manager_id, LEVEL,
LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_') LAST_NAME 
FROM employees
CONNECT BY employee_id = PRIOR manager_id;
COLUMN name CLEAR

/* 37. Write a query to do the following: 
每 Retrieve the details of the employee ID, hire date, salary, and manager ID of those employees 
whose employee ID is more than or equal to 200 from the EMPLOYEES table.
每 If the salary is less than $5,000, insert the details of employee ID and salary into the 
SPECIAL_SAL table.
每 Insert the details of employee ID, hire date, and salary into the SAL_HISTORY table. 
每 Insert the details of employee ID, manager ID, and salary into the MGR_HISTORY table.
*/
INSERT ALL
WHEN SAL < 5000 THEN
INTO special_sal VALUES (EMPID, SAL)
ELSE
INTO sal_history VALUES(EMPID,HIREDATE,SAL)
INTO mgr_history VALUES(EMPID,MGR,SAL) 
SELECT employee_id EMPID, hire_date HIREDATE,
salary SAL, manager_id MGR
FROM employees
WHERE employee_id >=200;
--38. Query the SPECIAL_SAL, SAL_HISTORY and the MGR_HISTORY tables to view the inserted records.
SELECT * FROM special_sal;
SELECT * FROM sal_history;
SELECT * FROM mgr_history;

--39. Create the LOCATIONS_NAMED_INDEX table based on the following table instance chart. Name the index for the PRIMARY KEY column as LOCATIONS_PK_IDX.
CREATE TABLE LOCATIONS_NAMED_INDEX
(location_id NUMBER(4) PRIMARY KEY USING INDEX
(CREATE INDEX locations_pk_idx ON
LOCATIONS_NAMED_INDEX(location_id)),
location_name VARCHAR2(20));

-- 40. Query the USER_INDEXES table to display the INDEX_NAME for the LOCATIONS_NAMED_INDEX table. 
select index_name, table_name
  from user_indexes
 where table_name = 'locations_named_index';
