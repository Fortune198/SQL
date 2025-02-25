
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
p0010001 AS "Total Population",
p0010003 AS "White Alone",
p0010004 AS "Black or African American Alone",
p0010005 AS "Am Indian/Alaska Native Alone",
p0010006 AS "Asian Alone",
p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
p0010008 AS "Some Other Race Alone",
p0010009 AS "Two or More Races"
FROM us_counties_2010;