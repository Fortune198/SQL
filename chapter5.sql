--chapter 5

SELECT CAST (11 AS numeric(3,1)) / 6;
SELECT 11.0 / 6;
SELECT 10 % 4;
SELECT 11 / 6;


SELECT 3 ^ 4;
SELECT |/ 16;
SELECT sqrt(10);
SELECT ||/ 8;
SELECT 4 !;


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


SELECT geo_name,
state_us_abbreviation AS "st",
p0010003 AS "White Alone",
p0010004 AS "Black Alone",
p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;



CREATE OR REPLACE FUNCTION _final_median(anyarray)
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