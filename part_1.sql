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


--7
select d.DEPARTMENT_NAME, count(e.employee_id) how_many
from employees e
join departments d on e.department_id = d.department_id
where e.hire_date < to_date('2005-01-01','YYYY-MM-DD')
group by d.DEPARTMENT_NAME
order by  d.DEPARTMENT_NAME;

select (select d.DEPARTMENT_NAME from departments d where  d.department_id = e.department_id ) department_name, count(e.employee_id) how_many
from employees e
where e.hire_date < to_date('2005-01-01','YYYY-MM-DD')
group by e.department_id
order by  (select d.DEPARTMENT_NAME from departments d where  d.department_id = e.department_id );


--8
select (select j.job_title from jobs j where j.JOB_ID = e.job_id) job, count(*)
from employees e
group by e.job_id
order by (select j.job_title from jobs j where j.JOB_ID = e.job_id);

select j.job_title, COUNT(*)
from employees e
join jobs j on e.job_id = j.job_id
GROUP BY j.job_title
order by j.job_title;

--9
select d.department_name ,e.first_name, e.last_name
from employees e
join departments d on e.department_id = d.department_id
where lower(e.JOB_ID) not like '%it%';


--10

select j.job_title, (select count(*)
from employees e where e.job_id = j.job_id and to_char(e.hire_date,'mm')<4) how_many
from jobs j
where (select count(*)
from employees e where e.job_id = j.job_id and to_char(e.hire_date,'mm')<4) > 0;

select j.job_title, count(*)
from employees e
join jobs j on e.job_id = j.job_id
where to_char(e.hire_date,'mm')<4
group by j.job_title;


--11
select d.department_name, l.country_id, l.city, l.postal_code, l.street_address
from departments d
join locations l on d.location_id = l.location_id;

--12
select j.job_title, count(*)
from employees e
join jobs j on e.job_id = j.job_id
join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.department_name like 'S%'
group by j.job_title;

--13

select d.department_name, j.job_title, count(*)
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id
group by d.department_name, j.job_title
having lower(j.job_title) like '%manager%'
order by  d.department_name, j.job_title;

select d.department_name, j.job_title, count(*)
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id
where lower(j.job_title) like '%manager%'
group by d.department_name, j.job_title
order by  d.department_name, j.job_title;

--14

SELECT
    c.country_name,
    (
        SELECT
            COUNT(*)
        FROM
            locations     l
            JOIN departments   d ON d.location_id = l.location_id
        WHERE
            l.country_id = c.country_id
    ) how_many_departments,
    (
        SELECT
            COUNT(*)
        FROM
            locations     l
            JOIN departments   d ON d.location_id = l.location_id
            JOIN employees     e ON e.department_id = d.department_id
        WHERE
            l.country_id = c.country_id
    ) how_many_employees
FROM
    countries c;
    
--15
select e.salary
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.LOCATION_ID = l.LOCATION_ID
join countries c on l.country_id = c.country_id
where c.COUNTRY_NAME not like 'Canada';

--16
select d.department_name, avg(e.salary) averge_salary
from departments d
join employees e on e.department_id = d.department_id
group by d.department_name
having avg(e.salary) >=8000 and avg(e.salary) <= 10000
order by d.department_name;

--17
select c.country_name, sum(e.salary)
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on l.country_id = c.country_id
group by c.country_name;

--18
select d.department_name, avg(e.salary)
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
having avg(salary) < 5000
order by d.department_name;

--19
select DISTINCT j.job_title
from employees e
join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id
where d.department_name in ('Marketing', 'Shipping');

--20
select e.first_name, e.last_name
from employees e
where e.salary > (select avg(ee.salary) from employees ee);

--21
select *
from
(select e.first_name, e.last_name, e.salary
from employees e
order by salary asc)
where rownum <6;



--22
SELECT
    *
FROM
    (
        SELECT
            e.first_name,
            e.last_name,
            e.salary,
            j.job_title,
            h.start_date
        FROM
            employees     e
            JOIN jobs          j ON e.job_id = j.job_id
            JOIN job_history   h ON e.employee_id = h.employee_id
        WHERE
            lower(j.job_title) LIKE '%sal%'
    )
WHERE
    ROWNUM < 6;

--23
select e.first_name, e.last_name, e.salary, e.job_id
from employees e
where e.salary = (select max(ee.salary) from employees ee where ee.job_id =e.job_id)
order by e.salary desc;

--24
select ( select j.job_title from jobs j where j.job_id = e.job_id) job_title
from employees e
where e.salary = (select max(ee.salary) from employees ee where ee.job_id =e.job_id)
order by e.salary desc;

--25
select e.first_name, e.last_name
from employees e
where e.salary < (select min(ee.salary) from employees ee join jobs j on ee.job_id = j.job_id where j.job_title like '%Programmer%');

--26
select  m,
        employee_id,
        first_name,
        last_name,
        email,
        phone_number,
        hire_date,
        job_id,
        salary,
        commission_pct,
        manager_id,
            department_id
from(
select days_BETWEEN (h.end_date,h.start_date) m, e.*
from employees e
join job_history h on e.job_id = h.job_id
join jobs j on e.job_id = j.job_id
where lower(j.job_title) like '%manager%'
order by MONTHS_BETWEEN (h.end_date,h.start_date) desc)
where rownum = 1;

--27
SELECT
    d.department_name,
    AVG(ee.salary)
FROM
    employees     ee
    JOIN departments   d ON ee.department_id = d.department_id
GROUP BY
    d.department_name
HAVING
    AVG(ee.salary) > (
        SELECT
            AVG(e.salary)
        FROM
            employees e
    );

--28
Select count(*)
from employees ee
where ee.salary < (SELECT
            AVG(e.salary)
        FROM
            employees e)/2;

--29
SELECT
    jj.job_title,
    AVG(e.salary) averge_salary
FROM
    employees     e
    JOIN departments   d ON e.department_id = d.department_id
    join jobs jj on e.job_id = jj.job_id
WHERE
    lower(d.department_name) LIKE '%it%'
GROUP BY
    jj.job_title
HAVING
    AVG(e.salary) > (
        SELECT
            AVG(ee.salary)
        FROM
            employees   ee
            JOIN jobs        j ON ee.job_id = j.job_id
        WHERE
            j.job_title = 'Sales Manager'
    );


