
--(listing 5.1) Basic addition, subtraction, and multiplication
SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;


--(listing 5.2) Integer and decimal division with SQL
SELECT 11 / 6;
SELECT 11 % 6;
SELECT 11.0 / 6;
SELECT CAST (11 AS numeric(3,1)) / 6;


--(listing 5.3)
SELECT 3 ^ 4;
SELECT |/ 10; --square root
SELECT sqrt(10);
SELECT ||/ 10; --cube root
SELECT 4 !;


--Order of operation
SELECT 7 + 8 * 9;
SELECT (7 + 8) * 9;

SELECT 3 ^ 3 - 1;
SELECT 3 ^ (3 - 1);

--(listing 5.4) Selecting census population columns by race with aliases
SELECT geo_name,
state_us_abbreviation AS "st",
p0010001 AS "Total Population",
p0010003 AS "White Alone",
p0010004 AS "Black or African American Alone",
p0010005 AS "Am Indian/Alaska Native Alone",
p0010006 AS "Asian Alone",
p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
p0010008 AS "Some Other Race Alone",
p0010009 AS "Two or More Races"
FROM us_counties_2010;

--(listing 5.5) Adding two columns in us_counties_2010
SELECT geo_name,
state_us_abbreviation AS "st",
p0010003 AS "White Alone",
p0010004 AS "Black Alone",
p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;


--(listing 5.6) Checking census data totals
SELECT geo_name,
state_us_abbreviation AS "st",
p0010001 AS "Total",
p0010003 + p0010004 + p0010005 + p0010006 + p0010007
+ p0010008 + p0010009 AS "All Races",
(p0010003 + p0010004 + p0010005 + p0010006 + p0010007
+ p0010008 + p0010009) - p0010001 AS "Difference"
FROM us_counties_2010
ORDER BY "Difference" DESC;


--(listing 5.7) Calculating the percentage of Asian population
SELECT geo_name,
state_us_abbreviation AS "st",
(CAST (p0010006 AS numeric(8,1)) / p0010001) * 100 AS "pct_asian"
FROM us_counties_2010
ORDER BY "pct_asian" DESC;


--(listing 5.8) Calculating percent change
CREATE TABLE percent_change (
department varchar(20),
spend_2014 numeric(10,2),
spend_2017 numeric(10,2)
);

INSERT INTO percent_change
VALUES
('Building', 250000, 289000),
('Assessor', 178556, 179500),
('Library', 87777, 90001),
('Clerk', 451980, 650000),
('Police', 250000, 223000),
('Recreation', 199000, 195000);

SELECT department,
spend_2014,
spend_2017,
round( (spend_2017 - spend_2014) /
spend_2014 * 100, 1) AS "pct_change"
FROM percent_change;


--(listing 5.9) Using the sum() and avg() aggregate functions
SELECT sum(p0010001) AS "County Sum",
round(avg(p0010001), 0) AS "County Average"
FROM us_counties_2010;


--(listing 5.10) Testing percentile functions
CREATE TABLE percentile_test (
numbers integer
);

INSERT INTO percentile_test (numbers) VALUES
(1), (2), (3), (4), (5), (6);

SELECT
percentile_cont(.5)
WITHIN GROUP (ORDER BY numbers),
percentile_disc(.5)
WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;


--(listing 5.11) Using sum(), avg(), and percentile_cont() aggregate functions
SELECT sum(p0010001) AS "County Sum",
round(avg(p0010001), 0) AS "County Average",
percentile_cont(.5)
WITHIN GROUP (ORDER BY p0010001) AS "County Median"
FROM us_counties_2010;


--(listing 5.12)
SELECT percentile_cont(uarray[.25,.5,.75])
WITHIN GROUP (ORDER BY p0010001) AS "quartiles"
FROM us_counties_2010;


--(listing 5.13) Using unnest() to turn an array into rows
SELECT unnest(
percentile_cont(array[.25,.5,.75])
WITHIN GROUP (ORDER BY p0010001)
) AS "quartiles"
FROM us_counties_2010;


--(listing 5.14) Creating a median() aggregate function in PostgreSQL
CREATE OR REPLACE FUNCTION _final_median(numeric[])
RETURNS float8 AS
$$
WITH q AS
(
SELECT val
FROM unnest($1) val
WHERE VAL IS NOT NULL
ORDER BY 1
),
cnt AS
(
SELECT COUNT(*) AS c FROM q
)
SELECT AVG(val)::float8
FROM
(
SELECT val FROM q
LIMIT 2 - MOD((SELECT c FROM cnt), 2)
OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)
) q2;
$$
LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE median(anyelement) (
SFUNC=array_append,
STYPE=anyarray,
FINALFUNC=_final_median,
INITCOND='{}'
);


--(listing 5.15) Using a median() aggregate function
SELECT sum(p0010001) AS "County Sum",
round(AVG(p0010001), 0) AS "County Average",
median(p0010001) AS "County Median",
percentile_cont(.5)
WITHIN GROUP (ORDER BY p0010001) AS "50th Percentile"
FROM us_counties_2010;

--(listing 5.16) Finding the most frequent value with mode()
SELECT mode() WITHIN GROUP (ORDER BY p0010001)
FROM us_counties_2010;