
--(listing 2.1) querying everthing in table
SELECT * FROM teachers;

--(listing 2.2) querying specific column
SELECT last_name, first_name, salary FROM teachers;


--(listing 2.3) using DISTINCT 
SELECT DISTINCT school
FROM teachers;

--(listing 2.5) sorting using ORDER BY
SELECT first_name, last_name, salary
FROM teachers
ORDER BY salary DESC;

--(listing 2.6) sorting multiple columns
SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;

--(listing 2.7) filtering rows using WHERE
SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

--teachers with Janet as first name 
SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet';

--schools where school is not F.D Roosevelt HS
SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';

--teachers hired after given date
SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';

--teachers earning 43500 or more
SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= 43500;

--teachers earning between 40000 and 65000
SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000;


--(listing 2.8)filtering using LIKE and ILIKE
SELECT first_name
FROM teachers
WHERE first_name LIKE 'sam%';

--case insenstive
SELECT first_name
FROM teachers
WHERE first_name ILIKE 'sam%';


--(listing 2.9) Combining operators with AND and ORDER
SELECT *
FROM teachers
WHERE school = 'Myers Middle School'
AND salary < 40000;



SELECT *
FROM teachers
WHERE last_name = 'Cole'
OR last_name = 'Bush';



SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
AND (salary < 38000 OR salary > 40000);


--(listing 2.10) 
SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;

