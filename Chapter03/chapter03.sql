
--(listing 3.1)
CREATE TABLE char_data_types (
varchar_column varchar(10),
char_column char(10),
text_column text
);

INSERT INTO char_data_types
VALUES
('abc', 'abc', 'abc'),
('defghi', 'defghi', 'defghi');


COPY char_data_types TO 'C:\YourDirectory\typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');


--(listing 3.2)
CREATE TABLE number_data_types (
numeric_column numeric(20,5),
real_column real,
double_column double precision
);

INSERT INTO number_data_types
VALUES
(.7, .7, .7),
(2.13579, 2.13579, 2.13579),
(2.1357987654, 2.1357987654, 2.1357987654);

--(listing 3.4)
CREATE TABLE date_time_types (
timestamp_column timestamp with time zone,
interval_column interval
);

INSERT INTO date_time_types
VALUES
('2018-12-31 01:00 EST','2 days'),
('2018-12-31 01:00 -8','1 month'),
('2018-12-31 01:00 Australia/Melbourne','1 century'),
(now(),'1 week');

SELECT * FROM date_time_types;