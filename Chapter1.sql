CREATE DATABASE analysis;
CREATE TABLE teachers (
id bigserial,
first_name varchar(25),
last_name varchar(50),
school varchar(50),
hire_date date,
salary numeric
);
DROP TABLE teacher;

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);


CREATE TABLE animal_types (
id bigserial,
	animal_name varchar(50),
	scientific_name varchar(50),
	conservation_status varchar(50)
);

CREATE TABLE animal_specifics (
id bigserial,
);

INSERT INTO animal_types (animal_name, scientific_name, conservation_status)
VALUES ('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
       ('Arctic Wolf', 'Canis lupus arctos', 'Least Concern'),
	   ('Mountain Lion', 'Puma concolor', 'Not Concerning'),
	   ('Python', 'Pythonidae', 'Very Concerning')
	   
SELECT * FROM animal_types;	   

SELECT animal_name, conservation_status FROM animal_types
ORDER BY scientific_name asc;