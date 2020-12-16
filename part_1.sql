--1
SELECT
    e.first_name,
    e.last_name,
    j.job_title
FROM
    employees   e
    JOIN jobs        j ON e.job_id = j.job_id;

--2
SELECT
    e.*
FROM
    employees   e
    JOIN jobs        j ON e.job_id = j.job_id
WHERE
    j.job_title = 'Sales Manager';

--3
SELECT
    e.last_name,
    to_char(e.hire_date, 'YYYY') year,
    to_char(e.hire_date, 'month') month
FROM
    employees e;
    
--4
SELECT
    e.*
FROM
    employees e
WHERE
    to_char(e.hire_date, 'dd') > 20;
    
--5
SELECT
    e.first_name,
    e.last_name,
    round(months_between(sysdate, e.hire_date)) "months of working"
FROM
    employees e;

SELECT
    e.first_name,
    e.last_name,
    round(((sysdate - e.hire_date) / 365) * 12)
FROM
    employees e;

--6
select e.department_id, MAX(salary) "Maximum"
from employees e
where e.department_id in (50,60,70)
group by e.department_id;

select MAX(salary) "Maximum"
from employees e
where e.department_id = 50
union
select MAX(salary) "Maximum"
from employees e
where e.department_id = 60
union
select MAX(salary) "Maximum"
from employees e
where e.department_id = 70;
