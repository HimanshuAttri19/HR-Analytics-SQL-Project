# 📊 HR Analytics — SQL Project

## 📌 Project Overview

This project focuses on analyzing **Human Resources (HR) data using PostgreSQL SQL** to generate meaningful workforce insights.

The analysis covers employee information, departments, performance, attendance, salary, attrition, hiring trends, diversity, and workforce metrics.

The main objective is to answer real-world **HR business questions using SQL** and convert raw HR data into useful insights for decision-making.

---

## 🎯 Business Objective

The objective of this project is to help HR teams understand:

* Workforce size and employee status
* Employee attrition
* Salary distribution
* Department-wise workforce
* Employee performance
* Bonus distribution
* Attendance and absenteeism
* Leave utilization
* Hiring trends
* Employee demographics
* Promotion eligibility
* Department-wise attrition
* Workforce growth

---

## 🗂️ Dataset / Tables

The project uses four main tables:

| Table         | Description                                                                                      |
| ------------- | ------------------------------------------------------------------------------------------------ |
| `employees`   | Employee details such as salary, designation, gender, age, city, hire date and employment status |
| `departments` | Department information                                                                           |
| `performance` | Employee performance ratings and bonus information                                               |
| `attendance`  | Employee attendance and leave records                                                            |

### Table Relationships

```text
departments
     │
     │ department_id
     ▼
employees
     │
     │ employee_id
     ├──────────────► performance
     │
     └──────────────► attendance
```

---

## 🔎 Key HR Business Questions

This project answers **25 HR analytics questions**, including:

### 👥 Workforce Analysis

1. What is the total number of employees?
2. How many employees are currently active?
3. What is the employee attrition rate?
4. What is the average employee salary?
5. What is the department-wise average salary?
6. What is the average salary by designation?
7. How many employees work in each department?

### 📈 Performance & Compensation

8. What is the average performance rating?
9. Who are the top-performing employees?
10. How is the bonus amount distributed?
11. Which department has the highest average salary?
12. Which job role has the highest average salary?
13. Which employees are eligible for promotion?
14. How are performance ratings distributed?

### 🧑‍🤝‍🧑 Diversity & Demographics

15. What is the male-to-female employee ratio?
16. Which age group has the highest concentration of employees?
17. How many employees are located in each city?

### 📅 Hiring & Workforce Growth

18. What is the average employee tenure?
19. How many employees were hired each month?
20. How has employee headcount grown over time?

### 🕒 Attendance Analysis

21. What is the overall employee attendance rate?
22. How much leave have employees utilized?
23. What is the absenteeism rate?

### 📉 Attrition & Management

24. Which department has the highest attrition rate?
25. What does the overall workforce dashboard summary look like?

---

## 🛠️ Tools & Technologies

* **Database:** PostgreSQL
* **Language:** SQL
* **Analysis:** HR / Workforce Analytics
* **Concepts Used:**

  * `SELECT`
  * `WHERE`
  * `GROUP BY`
  * `ORDER BY`
  * `HAVING`
  * `CASE`
  * Aggregate Functions
  * Subqueries
  * `JOIN`
  * Date Functions
  * `EXTRACT`
  * `AGE`
  * Conditional Aggregation
  * Percentage Calculations

---

## 📊 Key Metrics

The project calculates important HR KPIs such as:

| KPI                          | Description                                                   |
| ---------------------------- | ------------------------------------------------------------- |
| Total Employees              | Total workforce size                                          |
| Active Employees             | Currently active employees                                    |
| Attrition Rate               | Percentage of employees who left                              |
| Average Salary               | Average employee compensation                                 |
| Average Performance Rating   | Overall employee performance                                  |
| Attendance Rate              | Percentage of present working days                            |
| Absenteeism Rate             | Percentage of absent working days                             |
| Leave Utilization            | Total leave records                                           |
| Average Tenure               | Average employee tenure                                       |
| Department Headcount         | Employees by department                                       |
| Promotion Eligible Employees | Employees with performance rating above the defined threshold |

---

## 💡 Example SQL Analysis

### Employee Attrition Rate

```sql
SELECT
    SUM(
        CASE
            WHEN employment_status IN ('Resigned', 'Terminated')
            THEN 1
            ELSE 0
        END
    ) * 100 / COUNT(*) AS attrition_rate
FROM employees;
```

### Department-wise Average Salary

```sql
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_salary DESC;
```

### Attendance Rate

```sql
SELECT
    ROUND(
        SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attendance_rate
FROM attendance;
```

### Promotion Eligibility

```sql
SELECT
    p.employee_id,
    e.employee_name,
    p.performance_rating
FROM employees e
JOIN performance p
    ON p.employee_id = e.employee_id
WHERE p.performance_rating > 4.5
ORDER BY p.performance_rating DESC;
```

These queries represent the types of analysis included in the project.

---

## 📈 Workforce Dashboard Metrics

The project also combines major HR metrics into a single workforce summary:

* Total Employees
* Active Employees
* Attrition Rate
* Average Salary
* Average Performance Rating

This can be used as the foundation for an **HR Analytics Dashboard** in Power BI or another visualization tool.

---

## 📁 Project Structure

```text
HR-Analytics-SQL/
│
├── README.md
│
├── HR_ANALYSIS_QUESTION_FILE.sql
│
├── dataset-HR_ANALYTICS_DATASET.sql
│  
└── dashboard/
    └── HR_Analytics_Dashboard.pbix
```

> Update the folder/file names according to the actual files you upload to GitHub.

---

## 🚀 How to Run the Project

### 1. Install PostgreSQL

Install PostgreSQL and open **pgAdmin** or another PostgreSQL SQL client.

### 2. Create the Database

```sql
CREATE DATABASE hr_analytics;
```

### 3. Connect to the Database

Connect to the newly created `hr_analytics` database.

### 4. Create the Tables

Create/import the following tables:

```text
employees
departments
performance
attendance
```

### 5. Load the Data

Import the corresponding HR datasets into PostgreSQL.

### 6. Run the SQL Queries

Open:

```text
HR_ANALYSIS_QUESTION_FILE.sql
```

Execute the queries to perform the HR analysis.

---

## 📌 Skills Demonstrated

This project demonstrates practical Data Analyst skills including:

* SQL Data Analysis
* PostgreSQL
* Data Aggregation
* Business Question Solving
* HR Analytics
* KPI Development
* Employee Attrition Analysis
* Salary Analysis
* Performance Analysis
* Attendance Analysis
* Data Segmentation
* Joining Multiple Tables
* Conditional Logic
* Date-Based Analysis
* Subquery Usage
* Business Insight Generation

---

## 🎯 Key Learning Outcome

Through this project, I practiced converting **real-world HR business questions into SQL queries** and using multiple HR datasets to generate measurable insights.

The project demonstrates how SQL can be used not only to retrieve data but also to support **business decision-making and HR strategy**.

---

## 👨‍💻 Author

**Himanshu Attri**

Aspiring Data Analyst | SQL | Excel | Power Query | Power BI | Python

---

## ⭐ Future Improvements

* Build an interactive **Power BI HR Analytics Dashboard**
* Add more advanced SQL queries
* Perform employee-level trend analysis
* Add salary and performance correlation analysis
* Analyze attendance vs. performance
* Analyze attrition by age, gender, department and designation
* Add automated KPI reporting
* Add advanced window-function analysis
