--creating animal database
CREATE DATABASE animals;

--creating animals table 
CREATE TABLE animal_type (
    type_id bigserial,
    common_name varchar(100),
    scientic_name varchar(100),
    habitat varchar(100),
    diet varchar(100)
);

--creating animal specifics
CREATE TABLE animal_data (
    animal_id bigserial,
    name varchar(50),
    gender varchar(50),
    health_status varchar(50) arrival_date date,
    type_id numeric
);

--inserting data into animal_type table
INSERT INTO
    animal_type (common_name, scientic_name, habitat, diet)
VALUES
    (
        'Polar bear',
        'Ursus maritimus',
        'Arctic',
        'Conivore'
    ),
    ('Lion', 'Panthera loe', 'Grassland', 'Conivore'),
    (
        'Elephant',
        'Elephas maximus',
        'Grassland',
        'Herbivore'
    ),
    (
        'Crocodile',
        'Crocodylus palustris',
        'Wetlands',
        'Conivore'
    ),
    (
        'Yellow-belly gecko',
        'Hemidactylus flaviviridis',
        'Forest',
        'Omnivore'
    ),
    (
        'Gorilla',
        'Gorilla beringei',
        'Forest',
        'Herbivore'
    );

--inserting data into animal_type table
INSERT INTO
    animal_data (
        name,
        gender,
        health_status,
        arrival_date,
        type_id
    )
VALUES
    ('Mufasa', 'male', 'healthy', '2011-10-30', 2),
    ('Rufas', 'male', 'healthy', '2015-09-12', 2),
    ('Sheer', 'female', 'healthy', '1991-10-02', 2),
    ('Silver', 'male', 'healthy', '2000-05-20', 6),
    ('Musa', 'male', 'healthy', '1992-08-10', 6),
    ('Lefy', 'female', 'healthy', '2001-10-30', 6),
    ('Geck', 'male', 'healthy', '2020-07-10', 5),
    ('Reddy', 'female', 'healthy', '2021-09-27', 5),
    ('Mulas', 'male', 'healthy', '2011-10-30', 4),
    ('Mufasa', 'male', 'healthy', '2002-02-10', 4);

--SELECT for both tables

SELECT * FROM animal_type;


SELECT * FROM animal_data;