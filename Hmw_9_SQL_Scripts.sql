-- Dropping tables to ensure none are created prior to creation

DROP TABLE IF EXISTS departments CASCADE;
DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS titles CASCADE;

-- Creating the departments table
CREATE TABLE "departments" 
(
    "dept_no" varchar NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    PRIMARY KEY (dept_no) 
     
);
-- Importing and displaying the departments table
select * from departments; 

-- Creating the dept_emp table
CREATE TABLE "dept_emp" 
(
    "emp_no" int,
    "dept_no" VARCHAR   
);

-- Importing and displaying the dept_emp table
select * from dept_emp; 

-- Creating the dept_manager table
CREATE TABLE "dept_manager" 
(
    "dept_no" varchar,
    "emp_no" int   
);

-- Importing and displaying the dept_manager table
select * from dept_manager; 

-- Creating the employees table
CREATE TABLE "employees" 
(
    "emp_no" int,
    "emp_title_id" varchar, 
    "birth_date" date, 
    "first_name" varchar,
    "last_name" varchar,
    "sex" varchar, 
    "hire_date" date
);

-- Importing and displaying the employees table
select * from employees; 

-- Creating the salaries table
CREATE TABLE "salaries" 
(
    "emp_no" int,
    "salary" int   
);

-- Importing and displaying the salaries table
select * from salaries; 


-- Creating the titles table
CREATE TABLE "titles" 
(
    "title_id" varchar,
    "title" varchar   
);

-- Importing and displaying the titles table
select * from titles; 


-- 1. List the employee number, last name, first name, sex and salary of each employee. 

select e.emp_no, e.last_name, e.first_name, e.sex, s.salary  
from employees e
join salaries s 
on e.emp_no = s.emp_no
order by e.emp_no
; 


-- 2. List the first name, last name, and hire date for the employess who were hired in 1986.

select e.first_name, e.last_name, e.hire_date
from employees e 
where extract (year from e.hire_date) = 1986  
;

-- 3. List the manager of each department along with their department number, department name, 
--    employee number, last name and first name

select d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
from dept_manager dm 
join departments d
on dm.dept_no  = d.dept_no 
join employees e
on dm.emp_no = e.emp_no ; 

-- 4. List the department number for each employee along with that employee number, last name, 
--    first name and department name

select dm.dept_no, e.emp_no, e.first_name, e.last_name,  d.dept_name 
from employees e join dept_manager dm
on e.emp_no = dm.emp_no 
join departments d 
on d.dept_no = dm.dept_no;  


-- 5. List first name, last name, and sex of each employee whose first name is Hercules 
--    and whose last name begins with the letter B.

select e.first_name, e.last_name, e.sex
from employees e 
where e.first_name = 'Hercules'
and left(last_name,1) = 'B' ;


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name 
from employees e 
join dept_manager dm 
on e.emp_no = dm.emp_no 
join departments d
on dm.dept_no = d.dept_no 
where d.dept_name = 'Sales'; 


-- 7. List each employee in the Sales and Development departments, including their employee number, 
--    last name, first name, and department name.

select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e 
join dept_manager dm 
on e.emp_no = dm.emp_no 
join departments d
on dm.dept_no = d.dept_no 
where d.dept_name = 'Sales'
or d.dept_name = 'Development';



-- 8. List the frequency counts, in descending order, of all the employee last names 
--    (that is, how many employees share each last name).

select e.last_name, count(e.last_name) 
from employees e
group by e.last_name
order by count(e.last_name) desc ;



