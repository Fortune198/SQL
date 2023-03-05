--chapter 7

CREATE TABLE natural_key_example (
 license_id varchar(10) CONSTRAINT license_key PRIMARY KEY,
first_name varchar(50),
last_name varchar(50)
);

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Sam', 'Tracy');


CREATE TABLE natural_key_composite_example (
student_id varchar(10),
school_day date,
present boolean,
CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2017/01/22', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2017/01/23', 'N');


CREATE TABLE surrogate_key_example (
order_number bigserial,
product_name varchar(50),
order_date date,
CONSTRAINT order_key PRIMARY KEY (order_number)
);

INSERT INTO surrogate_key_example (product_name, order_date)
VALUES ('Beachball Polish', '2015-03-17'),
('Wrinkle De-Atomizer', '2017-05-22'),
('Flux Capacitor', '1985-10-26');


SELECT * FROM surrogate_key_example;

CREATE TABLE licenses (
license_id varchar(10),
first_name varchar(50),
last_name varchar(50),
CONSTRAINT licenses_key PRIMARY KEY (license_id)
);

CREATE TABLE registrations (
registration_id varchar(10),
registration_date date,
license_id varchar(10) REFERENCES licenses (license_id),
CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Malero');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '3/17/2017', 'T229901');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '3/17/2017', 'T000001');

