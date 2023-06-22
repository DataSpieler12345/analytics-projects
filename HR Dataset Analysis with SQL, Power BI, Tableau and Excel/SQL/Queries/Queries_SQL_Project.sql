-- Employe Count
select sum(employee_count) from hrdata;

-- Employe Count filtered = High School
select sum(employee_count) from hrdata
where education = 'High School';

-- Employe Count filtered = Associates Degree
select sum(employee_count) from hrdata
where education = 'Associates Degree';

-- Employe Count filtered = Bachelor's Degree
select sum(employee_count) from hrdata
where education = 'Bachelor''s Degree';

-- Employe Count filtered = Doctoral Degree
select sum(employee_count) from hrdata
where education = 'Doctoral Degree';

-- Employe Count filtered = Master's Degree
select sum(employee_count) from hrdata
where education = 'Master''s Degree';

--Employe Count Filtered by Department 
select sum(employee_count) from hrdata
--where education = 'High School'
where department = 'R&D';

--Employe Count Filtered by Department 
select sum(employee_count) from hrdata
--where education = 'High School'
where department = 'HR';

--Employe Count Filtered by Department 
select sum(employee_count) from hrdata
--where education = 'High School'
where department = 'Sales';

--Attrition Count
select count(attrition) from hrdata where attrition='Yes';

--Attrition Rate
select 
round (((select count(attrition) from hrdata where attrition='Yes')/ 
sum(employee_count)) * 100,2)
from hrdata;

--Active Employee
select sum(employee_count) - (select count(attrition) from hrdata  where attrition='Yes') from hrdata;

--Active Employee
select (select sum(employee_count) from hrdata) - count(attrition) as active_employee from hrdata
where attrition='Yes';

--Average Age
select round(avg(age),0) from hrdata;

--Attrition by Gender
select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by gender
order by count(attrition) desc;

--Department wise Attrition
select department, count(attrition), round((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as pct from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc;

--No of Employee by Age Group
SELECT age,  sum(employee_count) AS employee_count FROM hrdata
GROUP BY age
order by age;

--Education Field wise Attrition
select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc;

--Attition Rate by Gender for differente Age Group
select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;

--crosstab function create
CREATE EXTENSION IF NOT EXISTS tablefunc;
--Job Statisfaction Rating 
SELECT *
FROM crosstab(
  'SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;

--Employee Count filtered Education field 
select sum(employee_count) from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Medical';

select sum(employee_count) from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Life Sciences';

select sum(employee_count) from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Marketing';

select sum(employee_count) from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Technical Degree';

select sum(employee_count) from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Other';

select sum(employee_count)as employee_count from hrdata
--where education = 'High School'
--where department = 'R&D';
where education_field = 'Human Resources';

