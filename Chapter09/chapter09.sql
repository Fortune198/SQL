--(listing 9.1) Importing the FSIS Meat, Poultry, and Egg Inspection Directory
CREATE TABLE meat_poultry_egg_inspect (
    est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
    company varchar(100),
    street varchar(100),
    city varchar(30),
    st varchar(2),
    zip varchar(5),
    phone varchar(14),
    grant_date date,
    activities text,
    dbas text
);

COPY meat_poultry_egg_inspect
FROM
    'C:\YourDirectory\MPI_Directory_by_Establishment_Name.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

--(listing 9.2) Finding multiple companies at the same address
SELECT
    company,
    street,
    city,
    st,
    count(*) AS address_count
FROM
    meat_poultry_egg_inspect
GROUP BY
    company,
    street,
    city,
    st
HAVING
    count(*) > 1
ORDER BY
    company,
    street,
    city,
    st;

--(listing 9.3) Grouping and counting states
SELECT
    st,
    count(*) AS st_count
FROM
    meat_poultry_egg_inspect
GROUP BY
    st
ORDER BY
    st;

--(listing 9.4) Using IS NULL to find missing values in the st column

SELECT est_number,
    company,
    city,
    st,
    zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

--(listing 9.5) Using GROUP BY and count() to find inconsistent company names

SELECT company,
count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

--(listing 9.6) Using length() and count() to test the zip column

SELECT length(zip),
count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;


--(listing 9.7) Filtering with length() to find short zip values

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
WHERE length(zip) < 5 --malformed values
GROUP BY st
ORDER BY st ASC;

--(listing 9.8) Backing up a table

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT * FROM meat_poultry_egg_inspect;

SELECT --checking if table values count match
(SELECT count(*) FROM meat_poultry_egg_inspect) AS original,
(SELECT count(*) FROM meat_poultry_egg_inspect_backup) AS backup;


--(listing 9.9) Creating and filling the st_copy column with ALTER TABLE and UPDATE

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);
UPDATE meat_poultry_egg_inspect
SET st_copy = st;


--(listing 9.10) Checking values in the st and st_copy columns

SELECT st,
st_copy
FROM meat_poultry_egg_inspect
ORDER BY st;


--(listing 9.11) Updating the st column for three establishments

UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';

UPDATE meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';


--(listing 9.12) Restoring original st column values

UPDATE meat_poultry_egg_inspect
SET st = st_copy;

UPDATE meat_poultry_egg_inspect original
SET st = backup.st
FROM meat_poultry_egg_inspect_backup backup
WHERE original.est_number = backup.est_number;


--(listing 9-13) Creating and filling the company_standard column

ALTER TABLE meat_poultry_egg_inspect 
ADD COLUMN company_standard varchar(100);

UPDATE meat_poultry_egg_inspect
SET company_standard = company;


--(listing 9.14) Using an UPDATE statement to modify field values that match a string

UPDATE meat_poultry_egg_inspect
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%';

SELECT company, company_standard
FROM meat_poultry_egg_inspect
WHERE company LIKE 'Armour%';


--(listing 9.15) Creating and filling the zip_copy column

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);
UPDATE meat_poultry_egg_inspect
SET zip_copy = zip;

--(listing 9.16) Modifying codes in the zip column missing two leading zeros

UPDATE meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

SELECT * FROM meat_poultry_egg_inspect --(test values before updating)
WHERE st IN('PR','VI');

--(listing 9.17) Modifying codes in the zip column missing one leading zero

UPDATE meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

--(listing 9.18) Creating and filling a state_regions table

CREATE TABLE state_regions (
st varchar(2) CONSTRAINT st_key PRIMARY KEY,
region varchar(20) NOT NULL
);

COPY state_regions
FROM 'C:\YourDirectory\state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');


--(listing 9.19) 

ALTER TABLE meat_poultry_egg_inspect 
ADD COLUMN inspection_date date;
UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
FROM state_regions
WHERE inspect.st = state_regions.st
AND state_regions.region = 'New England');


--(listing 9.20) Viewing updated inspection_date values




SELECT st, inspection_date
FROM meat_poultry_egg_inspect
GROUP BY st, inspection_date
ORDER BY st;

--(lisitng 9.21) Deleting rows matching an expression

DELETE FROM meat_poultry_egg_inspect
WHERE st IN('PR','VI');

--(listing 9.22) Removing a column from a table using DROP

ALTER TABLE meat_poultry_egg_inspect DROP COLUMN zip_copy;

--(listing 9.23) Removing a table from a database using DROP

DROP TABLE meat_poultry_egg_inspect_backup;

--(listing 9.24) Demonstrating a transaction block

START TRANSACTION; --signals the start of the transaction block

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK; --signals the end of the block and reverts all changes

--(listing 9.25) Backing up a table while adding and filling a new column

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT *,
'2018-02-07'::date AS reviewed_date
FROM meat_poultry_egg_inspect;

--(listing 9.26) Swapping table names using ALTER TABLE

ALTER TABLE meat_poultry_egg_inspect 
RENAME TO meat_poultry_egg_inspect_temp;

ALTER TABLE meat_poultry_egg_inspect_backup
RENAME TO meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect_temp
RENAME TO meat_poultry_egg_inspect_backup;

