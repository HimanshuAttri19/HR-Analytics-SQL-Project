select * from employees;
select * from departments;
select * from performance;
select * from attendance;
/*1. Total Employees
What is the total number of employees currently registered in the organization?*/
select count(*) from employees;

/*2. Active Employees
How many employees currently have an "Active" employment status?*/
select count(*)as Active_emp from employees where employment_status='Active';

/*3. Employee Attrition Rate
What percentage of employees have left the company (resigned or terminated)?*/
select sum(case when employment_status in('Resigned','Terminated') then 1 else 0 end)*100/count(*) as attrition_rate from employees;

/*4. Average Employee Salary
What is the average salary across all employees?*/
select round(avg(salary),2)as avg_salary from employees;

/*5. Salary by Department
What is the average salary in each department, and which department pays the most?*/
select d.department_name,round(avg(e.salary),2) as avg_salary from employees e
join departments d on e.department_id=d.department_id group by d.department_id
order by avg_salary desc;

/*6. Salary by Designation
What is the average salary across different job designations/roles?*/
select designation,round(avg(salary),2) as Deg_salary from employees group by designation;

/*7. Average Performance Rating
What is the average performance rating across all employees?*/
select round(avg(performance_rating),2) as avg_performance_rating from performance;

/*8. Top Performers
Who are the employees with the highest performance ratings (top performers)?*/
select p.employee_id,e.employee_name,max(p.performance_rating) as highest_rating from employees e 
join performance p on e.employee_id=p.employee_id 
group by p.employee_id,e.employee_name order by highest_rating desc;
/*9. Bonus Distribution
How is bonus amount distributed across employees?*/
select case
when bonus<10000 then '0-10000'
when bonus between 10000 and 20000 then '10000-20000'
when bonus between 20000 and 30000 then '20000-30000'
when bonus between 30000 and 40000 then '30000-40000'
else '40000-50000'
end as bonus_group, count(employee_id)as total_emp from performance
group by bonus_group
order by bonus_group;

/*10. Department-wise Headcount
How many employees work in each department?*/
select d.department_name,count(e.department_id)as no_of_employees
from departments d 
join employees e 
on d.department_id=e.department_id 
group by d.department_name;

--IMPORTANT
/*11. Gender Diversity Ratio
What is the ratio of male to female employees in the company?*/
select gender,count(*) as total,
round(count(*)*100/(select count(*) from employees),2) from employees group by gender


/*12. Age Distribution
Which age group has the highest concentration of employees?*/
select 
case 
	when age between 18 and 29 then  '18-29'
	when age between 30 and 39 then '30-39'
	when age between 40 and 49 then '40-49'
	when age between 50 and 59 then '50-59'
	else '60 and above '
end as age_group,
count(*) as no_of_employee from employees
group by age_group order by age_group;

/*13. Average Employee Tenure
On average, how long have employees been working at the company (based on hire date)?*/
SELECT 
    ROUND(
        AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)))::numeric,
        2
    ) AS average_tenure_years
FROM employees;

/*14. New Hires by Month
How many new employees were hired each month (hiring trend)?*/
select extract(year from hire_date) as year,extract(month from hire_date) as month ,count(*) from employees 
group by extract(year from hire_date),extract(month from hire_date ) order by 1,2;

select TO_char(hire_date,'yyyy-mm')as hire_month ,count(*) as new_hire from employees group by hire_month order by hire_month

--IMPORTANT
/*15. Employee Attendance Rate
What is the overall attendance rate of employees (Present days / Total days)?*/
select round(sum(case when status ='Present' then 1 else 0 end)*100/count(*),2) as attendance_rate from attendance;

/*16. Leave Utilization
How much leave have employees taken/utilized?*/
select sum(case when status='Leave' then 1 else 0 end ) from attendance;
select count(*)as total_leave from attendance where status='Leave';

/*17. Absenteeism Rate
What is the absenteeism rate relative to total working days?*/
select round(sum(case when status='Absent' then 1 else 0 end)*100/count(*),2) as absent_rate_per from attendance

/*18. Highest Paying Department
Which department offers the highest average salary?*/
select d.department_name,round(avg(e.salary),2) as avg_salary 
from employees e
join departments d on 
e.department_id=d.department_id
group by d.department_name 
order by avg_salary desc
limit 1;
/*19. Highest Paying Job Role
Which designation/job role earns the highest average salary?*/
select designation,Round(avg(salary),2) as avg_salary from employees 
group by designation 
order by avg_salary desc limit 1;

/*20. Promotion Eligibility List
Which employees are eligible for promotion based on high performance ratings?*/
select p.employee_id,e.employee_name,p.performance_rating from employees e
join performance p on p.employee_id=e.employee_id
where p.performance_rating>4.5 
order by p.performance_rating desc;

/*21. Performance Rating Distribution
How are performance ratings distributed across the company (how many employees fall in each
rating range)?*/
select case when performance_rating<2 then '1.00-1.99'
when performance_rating <3 then '2.00-2.99'
when performance_rating <4 then '3.00-3.99'
else '4.00-5.00'
end as performance_rating_dist,count(*) from performance group by performance_rating_dist order by performance_rating_dist;

/*22. Employee Growth Trend
How has the employee headcount grown over time (year/month-wise)?*/
select extract(year from hire_date) as hire_year ,count(*) from employees group by hire_year order by hire_year;

/*23. Employees by City
How many employees are based in each city?*/
select city,count(*) as total_employee from employees group by city 

/*24. Department-wise Attrition
Which department has the highest attrition rate?*/
select d.department_name,round(sum(case when e.employment_status in('Resigned','Terminated') then 1 else 0 end)*100 /count(*),2) as attrition_rate from employees e
join departments d
on e.department_id=d.department_id
group by d.department_name
order by attrition_rate desc;

/*25. Workforce Dashboard Metrics
What does the overall workforce summary look like (total headcount, active employees, attrition rate,
average salary, average rating — all in one dashboard view)? */

select 
  (select count(*) from employees) as total_emp,
  (select count(*) from employees where employment_status='Active') as Active_emp,
  (select round(sum(case when e.employment_status in('Resigned','Terminated') then 1 else 0 end)*100 /count(*),2) from employees)as attrition_rate,
  (select round(avg(salary),2) from employees) as avg_salary,
  (select round(avg(performance_rating),2) from performance) as avg_performance_ratig
  from employees e
  join performance p on e.employee_id=p.employee_id